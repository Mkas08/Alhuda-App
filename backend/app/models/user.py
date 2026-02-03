from uuid import UUID, uuid4
from sqlalchemy import String, Boolean, ForeignKey
from sqlalchemy.orm import Mapped, mapped_column, relationship
from .base import Base, TimestampMixin

class User(Base, TimestampMixin):
    __tablename__ = "users"

    user_id: Mapped[UUID] = mapped_column(primary_key=True, default=uuid4)
    email: Mapped[str] = mapped_column(String(255), unique=True, index=True, nullable=False)
    username: Mapped[str] = mapped_column(String(50), unique=True, index=True, nullable=False)
    password_hash: Mapped[str] = mapped_column(String(255), nullable=False)
    is_active: Mapped[bool] = mapped_column(Boolean, default=True)
    timezone: Mapped[str] = mapped_column(String(50), default="UTC", nullable=False)

    # Relationships
    profile: Mapped["UserProfile"] = relationship(back_populates="user", uselist=False, cascade="all, delete-orphan")
    location: Mapped["UserLocation"] = relationship(back_populates="user", uselist=False, cascade="all, delete-orphan")

class UserProfile(Base, TimestampMixin):
    __tablename__ = "user_profiles"

    user_id: Mapped[UUID] = mapped_column(ForeignKey("users.user_id"), primary_key=True)
    display_name: Mapped[str] = mapped_column(String(100), nullable=False)
    profile_picture_url: Mapped[str | None] = mapped_column(String(500))
    bio: Mapped[str | None] = mapped_column(String(500))
    privacy_level: Mapped[str] = mapped_column(String(20), default="private")  # private, friends, public

    # Relationships
    user: Mapped["User"] = relationship(back_populates="profile")

class UserLocation(Base, TimestampMixin):
    __tablename__ = "user_locations"

    user_id: Mapped[UUID] = mapped_column(ForeignKey("users.user_id"), primary_key=True)
    latitude: Mapped[float] = mapped_column()
    longitude: Mapped[float] = mapped_column()
    city: Mapped[str | None] = mapped_column(String(100))
    country: Mapped[str | None] = mapped_column(String(100))
    timezone: Mapped[str | None] = mapped_column(String(50))

    # Relationships
    user: Mapped["User"] = relationship(back_populates="location")
