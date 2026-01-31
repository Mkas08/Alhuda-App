"""add_quran_indexes

Revision ID: 22b862459bbc
Revises: 1f10eeebe86d
Create Date: 2026-01-31 22:15:01.090654

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = '22b862459bbc'
down_revision: Union[str, Sequence[str], None] = '1f10eeebe86d'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    """Upgrade schema."""
    # Indexes for quran_verses
    op.create_index('ix_quran_verses_surah_number', 'quran_verses', ['surah_number'], unique=False)
    op.create_index('ix_quran_verses_lookup', 'quran_verses', ['surah_number', 'verse_number'], unique=True)
    
    # Index for quran_translations
    op.create_index('ix_quran_translations_translator_name', 'quran_translations', ['translator_name'], unique=False)


def downgrade() -> None:
    """Downgrade schema."""
    op.drop_index('ix_quran_translations_translator_name', table_name='quran_translations')
    op.drop_index('ix_quran_verses_lookup', table_name='quran_verses')
    op.drop_index('ix_quran_verses_surah_number', table_name='quran_verses')
