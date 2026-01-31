from pydantic import BaseModel, ConfigDict
from typing import List, Optional

class QuranTranslationSchema(BaseModel):
    model_config = ConfigDict(from_attributes=True)
    
    translation_id: int
    language: str
    translator_name: str
    translation_text: str

class QuranVerseSchema(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    verse_id: int
    surah_number: int
    verse_number: int
    arabic_text: str
    simple_text: Optional[str] = None
    letter_count: int
    word_count: int
    has_sajdah: bool
    juz_number: int
    hizb_number: int
    page_number: int
    translations: List[QuranTranslationSchema] = []

class QuranSurahSchema(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    surah_number: int
    name_arabic: str
    name_complex: str
    name_english: str
    revelation_place: str
    verses_count: int
    order_in_quran: int

class QuranSurahDetailSchema(QuranSurahSchema):
    model_config = ConfigDict(from_attributes=True)
    
    verses: List[QuranVerseSchema] = []

class SearchResultSchema(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    verse: QuranVerseSchema
    relevance_score: Optional[float] = None
