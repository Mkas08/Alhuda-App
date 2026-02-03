from fastapi import APIRouter
from app.api.v1.endpoints import auth, quran, goals, progress

api_router = APIRouter()
api_router.include_router(auth.router, prefix="/auth", tags=["auth"])
api_router.include_router(quran.router, prefix="/quran", tags=["quran"])
api_router.include_router(goals.router, prefix="/goals", tags=["goals"])
api_router.include_router(progress.router, prefix="/progress", tags=["progress"])
from app.api.v1.endpoints import sessions
api_router.include_router(sessions.router, prefix="/sessions", tags=["sessions"])
from app.api.v1.endpoints import users
api_router.include_router(users.router, prefix="/users", tags=["users"])
