# Al-Huda Coding Standards

## 1. General Principles
- **Document-Driven Development (DDD):** All changes must align with PRD, PLANNING, and TASKS.
- **Aesthetic Excellence:** Adhere to the "Emerald Night" theme. Use `ThemeExtension` for custom tokens.
- **Atomic Design:** Keep components small, focused, and reusable. Max 300 lines per file where possible.

## 2. Flutter Standards
- **Architecture:** Clean Architecture (Data, Domain, Presentation).
- **State Management:** Riverpod.
- **Naming Conventions:**
  - Classes: PascalCase
  - Files/Folders: snake_case
  - Variables/Functions: camelCase
- **Linting:** Follow `analysis_options.yaml`.
- **Widgets:** Use `const` where possible. Prefer `ConsumerWidget` or `ConsumerStatefulWidget`.

## 3. Backend (FastAPI) Standards
- **Architecture:** Layered structure (Models, Schemas, API, Services).
- **ORM:** SQLAlchemy 2.0 (Async).
- **Validation:** Pydantic v2.
- **Type Safety:** 100% type hinting coverage.
- **Async/Await:** Use async/await for all I/O bound operations.
- **Naming Conventions:**
  - Classes: PascalCase
  - Functions/Variables: snake_case
  - Constants: UPPER_SNAKE_CASE

## 4. Database Standards
- **Migrations:** Use Alembic for all schema changes.
- **UUIDs:** Use UUIDs for primary keys where appropriate (users, sessions).
- **Naming:** Table names in snake_case, plural. Column names in snake_case.

## 5. Security & Privacy
- Zero-trust architecture.
- Encryption for sensitive data.
- Respect user privacy settings in all data fetches.
