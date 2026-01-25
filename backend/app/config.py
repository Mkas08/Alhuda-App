from pydantic_settings import BaseSettings, SettingsConfigDict
from pydantic import EmailStr

class Settings(BaseSettings):
    model_config = SettingsConfigDict(
        env_file=".env", 
        env_file_encoding="utf-8",
        extra="ignore"
    )

    # App
    APP_NAME: str = "Al-Huda"
    ENVIRONMENT: str = "development"
    SECRET_KEY: str = "dev_secret_key"

    # Database
    DATABASE_URL: str
    REDIS_URL: str

    # Sentry
    SENTRY_DSN_BACKEND: str | None = None

    # SMTP
    SMTP_PORT: int = 465
    SMTP_TLS: bool = False
    SMTP_SSL: bool = True
    SMTP_USER: str | None = None
    SMTP_PASSWORD: str | None = None
    EMAILS_FROM_EMAIL: EmailStr | None = None

settings = Settings()
