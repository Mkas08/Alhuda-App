from uuid import UUID
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from typing import List
from sqlalchemy import select, desc

from app.api.deps import get_db, get_current_user
from app.services.session_service import SessionService
from app.models.user import User
from app.models.progress import ReadingSession as ReadingSessionModel
from app.schemas.progress import ReadingSession, ProgressUpdate

router = APIRouter()

@router.post("/start", response_model=ReadingSession)
async def start_session(
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Start a new reading session."""
    return await SessionService.start_session(db, user_id=current_user.user_id)

@router.patch("/{session_id}/pause", response_model=ReadingSession)
async def pause_session(
    session_id: UUID,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Pause an active session."""
    session = await SessionService.pause_session(db, session_id, current_user.user_id)
    if not session:
        raise HTTPException(status_code=404, detail="Session not found or access denied")
    return session

@router.patch("/{session_id}/resume", response_model=ReadingSession)
async def resume_session(
    session_id: UUID,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Resume a paused session."""
    session = await SessionService.resume_session(db, session_id, current_user.user_id)
    if not session:
        raise HTTPException(status_code=404, detail="Session not found or access denied")
    return session

@router.post("/{session_id}/end", response_model=ReadingSession)
async def end_session(
    session_id: UUID,
    verses_read: int, 
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """End a session."""
    session = await SessionService.end_session(db, session_id, current_user.user_id, verses_read)
    if not session:
        raise HTTPException(status_code=404, detail="Session not found or access denied")
    return session

@router.post("/verse_read", response_model=ReadingSession)
async def log_verse_read(
    verse_id: int,
    session_id: UUID,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Log a verse read during a session."""
    # Verify session ownership
    session = await SessionService.get_session(db, session_id)
    if not session or session.user_id != current_user.user_id:
        raise HTTPException(status_code=404, detail="Session not found")
        
    await SessionService.update_progress(
        db, 
        current_user.user_id, 
        ProgressUpdate(verse_id=verse_id, session_id=session_id)
    )
    
    # Return updated session
    await db.refresh(session)
    return session

@router.get("/", response_model=List[ReadingSession])
async def get_sessions(
    skip: int = 0,
    limit: int = 20,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Get user's session history."""
    return await SessionService.get_user_sessions(db, current_user.user_id, skip=skip, limit=limit)
