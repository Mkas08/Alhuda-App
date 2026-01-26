from datetime import timedelta
from typing import Any
from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select

from app.core import security
from app.config import settings
from app.api import deps
from app.models.user import User
from app.schemas.user import UserCreate, User as UserSchema
from app.schemas.token import Token, RefreshTokenCreate

router = APIRouter()

from app.models.user import User, UserProfile, UserLocation

@router.post("/register", response_model=UserSchema)
async def register(
    *,
    db: AsyncSession = Depends(deps.get_db),
    user_in: UserCreate
) -> Any:
    """Register a new user."""
    # Check if user exists
    result = await db.execute(select(User).where(User.email == user_in.email))
    user = result.scalar_one_or_none()
    if user:
        raise HTTPException(
            status_code=400,
            detail="The user with this email already exists in the system.",
        )
    
    # Create new user
    db_obj = User(
        email=user_in.email,
        username=user_in.username,
        password_hash=security.get_password_hash(user_in.password),
    )
    db.add(db_obj)
    await db.flush() # Get user_id before session ends

    # Initialize User Profile
    profile_obj = UserProfile(
        user_id=db_obj.user_id,
        display_name=db_obj.username,
    )
    db.add(profile_obj)

    # Initialize empty Location
    location_obj = UserLocation(
        user_id=db_obj.user_id,
        latitude=0.0,
        longitude=0.0,
    )
    db.add(location_obj)

    await db.commit()
    await db.refresh(db_obj)
    return db_obj

@router.post("/login", response_model=Token)
async def login(
    db: AsyncSession = Depends(deps.get_db),
    form_data: OAuth2PasswordRequestForm = Depends()
) -> Any:
    """OAuth2 compatible token login, get an access token for future requests."""
    result = await db.execute(select(User).where(User.username == form_data.username))
    user = result.scalar_one_or_none()
    
    if not user or not security.verify_password(form_data.password, user.password_hash):
        raise HTTPException(status_code=400, detail="Incorrect email or password")
    elif not user.is_active:
        raise HTTPException(status_code=400, detail="Inactive user")
    
    access_token_expires = timedelta(minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES)
    refresh_token_expires = timedelta(days=settings.REFRESH_TOKEN_EXPIRE_DAYS)
    return {
        "access_token": security.create_access_token(
            user.user_id, expires_delta=access_token_expires
        ),
        "refresh_token": security.create_refresh_token(
            user.user_id, expires_delta=refresh_token_expires
        ),
        "token_type": "bearer",
    }

@router.post("/refresh", response_model=Token)
async def refresh_token(
    refresh_in: RefreshTokenCreate,
    db: AsyncSession = Depends(deps.get_db)
) -> Any:
    """Refresh tokens."""
    try:
        payload = security.jwt.decode(
            refresh_in.refresh_token, settings.SECRET_KEY, algorithms=[settings.ALGORITHM]
        )
        if payload.get("type") != "refresh":
            raise HTTPException(status_code=401, detail="Invalid refresh token")
        user_id = payload.get("sub")
    except security.jwt.JWTError:
        raise HTTPException(status_code=401, detail="Invalid refresh token")
    
    result = await db.execute(security.select(User).where(User.user_id == user_id))
    user = result.scalar_one_or_none()
    if not user or not user.is_active:
        raise HTTPException(status_code=401, detail="User not found or inactive")
    
    access_token_expires = timedelta(minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES)
    refresh_token_expires = timedelta(days=settings.REFRESH_TOKEN_EXPIRE_DAYS)
    
    return {
        "access_token": security.create_access_token(
            user.user_id, expires_delta=access_token_expires
        ),
        "refresh_token": security.create_refresh_token(
            user.user_id, expires_delta=refresh_token_expires
        ),
        "token_type": "bearer",
    }

@router.post("/logout")
async def logout(
    current_user: User = Depends(deps.get_current_active_user)
) -> Any:
    """Logout current user (Blacklist handling to be added with Redis)."""
    return {"msg": "Successfully logged out"}

from app.schemas.user import UserCreate, User as UserSchema, UserDetailed

@router.get("/me", response_model=UserDetailed)
async def read_users_me(
    current_user: User = Depends(deps.get_current_active_user),
    db: AsyncSession = Depends(deps.get_db)
) -> Any:
    """Get current user."""
    # Ensure profile is loaded for UserDetailed schema
    # current_user is already loaded by deps.get_current_active_user
    # SQLA 2.0 async loading might be needed if not eager loaded
    result = await db.execute(
        select(User).where(User.user_id == current_user.user_id).options(security.selectinload(User.profile))
    )
    user = result.scalar_one()
    return user
