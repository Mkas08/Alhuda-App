from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.config import settings
from app.core.sentry import init_sentry
from app.core.logging import setup_logging
from app.api.v1.api import api_router

def create_app() -> FastAPI:
    # Initialize Logging
    setup_logging()

    # Initialize Sentry
    if settings.SENTRY_DSN_BACKEND:
        init_sentry(dsn=settings.SENTRY_DSN_BACKEND, environment=settings.ENVIRONMENT)

    app = FastAPI(
        title=settings.APP_NAME,
        version="0.1.0",
        description="Quran Habit Builder API",
    )

    import time
    from fastapi import Request
    import logging

    logger = logging.getLogger(__name__)

    @app.middleware("http")
    async def log_response_time(request: Request, call_next):
        start_time = time.time()
        response = await call_next(request)
        process_time = time.time() - start_time
        response.headers["X-Process-Time"] = str(process_time)
        logger.info(f"Path: {request.url.path} Method: {request.method} Time: {process_time:.4f}s")
        return response

    # Set up CORS
    app.add_middleware(
        CORSMiddleware,
        allow_origins=["*"],  # Adjust for production
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )

    # Include API Router
    app.include_router(api_router, prefix="/api/v1")

    @app.get("/health")
    async def health_check():
        return {"status": "healthy", "environment": settings.ENVIRONMENT}

    return app

app = create_app()
