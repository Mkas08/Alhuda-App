from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from .config import settings
from .core.sentry import init_sentry

def create_app() -> FastAPI:
    # Initialize Sentry
    if settings.SENTRY_DSN_BACKEND:
        init_sentry(dsn=settings.SENTRY_DSN_BACKEND, environment=settings.ENVIRONMENT)

    app = FastAPI(
        title=settings.APP_NAME,
        version="0.1.0",
        description="Quran Habit Builder API",
    )

    # Set up CORS
    app.add_middleware(
        CORSMiddleware,
        allow_origins=["*"],  # Adjust for production
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )

    @app.get("/health")
    async def health_check():
        return {"status": "healthy", "environment": settings.ENVIRONMENT}

    return app

app = create_app()
