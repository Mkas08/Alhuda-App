from sqlalchemy import String, Integer, Boolean, ForeignKey, BigInteger, Text
from sqlalchemy.orm import Mapped, mapped_column, relationship
from .base import Base, TimestampMixin

class QuranSurah(Base):
    __tablename__ = "quran_surahs"

    surah_number: Mapped[int] = mapped_column(primary_key=True)
    name_arabic: Mapped[str] = mapped_column(String(100), nullable=False)
    name_complex: Mapped[str] = mapped_column(String(100), nullable=False)
    name_english: Mapped[str] = mapped_column(String(100), nullable=False)
    revelation_place: Mapped[str] = mapped_column(String(20))
    verses_count: Mapped[int] = mapped_column(Integer)
    order_in_quran: Mapped[int] = mapped_column(Integer)

    # Relationships
    verses: Mapped[list["QuranVerse"]] = relationship(back_populates="surah")

class QuranVerse(Base):
    __tablename__ = "quran_verses"

    verse_id: Mapped[int] = mapped_column(primary_key=True)
    surah_number: Mapped[int] = mapped_column(ForeignKey("quran_surahs.surah_number"))
    verse_number: Mapped[int] = mapped_column(Integer, nullable=False)
    arabic_text: Mapped[str] = mapped_column(Text, nullable=False)
    simple_text: Mapped[str] = mapped_column(Text)  # For search
    letter_count: Mapped[int] = mapped_column(Integer)
    word_count: Mapped[int] = mapped_column(Integer)
    has_sajdah: Mapped[bool] = mapped_column(Boolean, default=False)
    juz_number: Mapped[int] = mapped_column(Integer)
    hizb_number: Mapped[int] = mapped_column(Integer)
    page_number: Mapped[int] = mapped_column(Integer)

    # Relationships
    surah: Mapped["QuranSurah"] = relationship(back_populates="verses")
    translations: Mapped[list["QuranTranslation"]] = relationship(back_populates="verse")

class QuranTranslation(Base):
    __tablename__ = "quran_translations"

    translation_id: Mapped[int] = mapped_column(primary_key=True, autoincrement=True)
    verse_id: Mapped[int] = mapped_column(ForeignKey("quran_verses.verse_id"))
    language: Mapped[str] = mapped_column(String(20), index=True)
    translator_name: Mapped[str] = mapped_column(String(100))
    translation_text: Mapped[str] = mapped_column(Text, nullable=False)

    # Relationships
    verse: Mapped["QuranVerse"] = relationship(back_populates="translations")
