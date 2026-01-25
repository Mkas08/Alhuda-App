# Al-Huda: Quran Habit Builder

*Nurture your soul, one ayah at a time.*

Al-Huda is a premium mobile application designed to help Muslims build a consistent and meaningful relationship with the Quran. It combines behavioral psychology with spiritual practice, featuring focus modes, hasanat tracking, and prayer time integration.

## Project Structure

- `mobile/`: Flutter application (Clean Architecture: Data, Domain, Presentation).
- `backend/`: FastAPI application (Python 3.11+, SQLAlchemy 2.0).
- `docs/`: Technical and design documentation.

## Getting Started

### Prerequisites

- **Flutter SDK:** 3.16+
- **Python:** 3.11+
- **PostgreSQL:** 15+
- **Redis:** 7+

### Backend Setup

1. Navigate to `/backend`.
2. Create a virtual environment: `python -m venv venv`.
3. Activate it: `source venv/bin/activate` (Mac/Linux) or `venv\Scripts\activate` (Windows).
4. Install dependencies: `pip install -r requirements.txt`.
5. Configure `.env` based on `.env.example`.

### Mobile Setup

1. Navigate to `/mobile`.
2. Run `flutter pub get`.
3. Start the application: `flutter run`.

## Tech Stack

- **Frontend:** Flutter, Riverpod, Hive, Dio.
- **Backend:** FastAPI, SQLAlchemy 2.0, PostgreSQL, Redis.
- **Infrastructure:** AWS, GitHub Actions, Sentry, Firebase.

## Design

The application follows the **"Emerald Night"** design theme—a premium, serene aesthetic with deep greens, gold accents, and glowing interface elements.
