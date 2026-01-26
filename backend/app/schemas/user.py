from typing import Optional
import re
from uuid import UUID
from pydantic import BaseModel, EmailStr, ConfigDict, field_validator

# Shared properties
class UserBase(BaseModel):
    email: Optional[EmailStr] = None
    is_active: Optional[bool] = True
    username: Optional[str] = None

# Properties to receive via API on creation
class UserCreate(UserBase):
    email: EmailStr
    password: str
    username: str

    @field_validator("password")
    @classmethod
    def password_strength(cls, v: str) -> str:
        if len(v) < 8:
            raise ValueError("Password must be at least 8 characters long")
        if not re.search(r"[A-Z]", v):
            raise ValueError("Password must contain at least one uppercase letter")
        if not re.search(r"[a-z]", v):
            raise ValueError("Password must contain at least one lowercase letter")
        if not re.search(r"\d", v):
            raise ValueError("Password must contain at least one digit")
        return v

# Properties to receive via API on update
class UserUpdate(UserBase):
    password: Optional[str] = None

class UserInDBBase(UserBase):
    user_id: Optional[UUID] = None
    model_config = ConfigDict(from_attributes=True)

# Additional properties to return via API
class User(UserInDBBase):
    pass

class ProfileBase(BaseModel):
    display_name: str
    profile_picture_url: Optional[str] = None
    bio: Optional[str] = None
    privacy_level: str = "private"

class Profile(ProfileBase):
    model_config = ConfigDict(from_attributes=True)

class UserDetailed(User):
    profile: Optional[Profile] = None

# Additional properties stored in DB
class UserInDB(UserInDBBase):
    password_hash: str
