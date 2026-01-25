---
name: defining-mobile-architecture
description: Defines the standard architecture, folder structure, and development principles for Flutter mobile applications. Use when setting up a new project or validating adherence to architectural standards.
---

# Flutter Mobile App Architecture Guidelines

## When to use this skill
- When initializing a new Flutter project.
- When creating new features or modules to ensure they fit the established structure.
- When refactoring existing code to align with architectural standards.
- When you need to check where a specific file type (service, model, etc.) belongs.

## Framework
- **Framework**: Flutter 3.x with Dart
- **Target Platforms**: iOS, Android

## Architecture Pattern
- **Pattern**: Clean Architecture with feature-first organization
- **Core Rule**: Separate business logic from UI (presentation layer).
- **Modularity**: Widgets must be small (<300 lines), reusable, and composable.

## Folder Structure
Strictly adhere to this directory layout in `/lib`:

```
lib/
├── main.dart                    # App entry point
├── app.dart                     # MaterialApp configuration
├── core/
│   ├── constants/               # App-wide constants
│   │   ├── api_constants.dart
│   │   ├── app_constants.dart
│   │   └── colors.dart
│   ├── theme/                   # Theme configuration
│   │   ├── app_theme.dart
│   │   ├── text_styles.dart
│   │   └── theme_extensions.dart
│   ├── utils/                   # Pure helper functions
│   │   ├── date_utils.dart
│   │   ├── hasanat_calculator.dart
│   │   └── validators.dart
│   └── network/                 # API client setup
│       ├── api_client.dart
│       ├── api_interceptors.dart
│       └── websocket_client.dart
├── features/                    # Feature modules
│   └── {feature_name}/
│       ├── data/                # Data layer
│       │   ├── models/          # JSON serializable DTOs
│       │   ├── repositories/    # Repository implementations
│       │   └── datasources/     # Remote/local data sources
│       ├── domain/              # Business logic layer
│       │   ├── entities/        # Core business objects
│       │   ├── repositories/    # Repository interfaces
│       │   └── usecases/        # Business logic operations
│       └── presentation/        # UI layer
│           ├── screens/         # Full page widgets
│           ├── widgets/         # Feature-specific widgets
│           └── providers/       # Riverpod providers
├── shared/                      # Shared across features
│   ├── widgets/                 # Reusable UI components
│   ├── models/                  # Shared data models
│   └── services/                # App-wide services
└── config/
    ├── routes/                  # go_router configuration
    └── dependencies/            # Dependency injection setup
```

## Key Principles

1. **Type Safety**: All code must be written in Dart with strict analysis options. Avoid `dynamic` types.

2. **Single Responsibility**: Each widget, function, or service should have exactly one responsibility.

3. **Environment Variables**: Never hardcode API keys or endpoints. Use `--dart-define` or a config file.

4. **Reusable Widgets**: If a UI element is used more than once, extract it to `/shared/widgets` or the feature's `/widgets` folder.

5. **State Management**: Use Riverpod for all state management:
   - `Provider` for computed values
   - `StateProvider` for simple state
   - `StateNotifierProvider` for complex state
   - `FutureProvider` / `StreamProvider` for async data

6. **Dependency Inversion**: Depend on abstractions (repository interfaces in domain/) not implementations.

## Layer Rules

| Layer | Can Import | Cannot Import |
|-------|------------|---------------|
| **presentation** | domain, shared | data (directly) |
| **domain** | nothing (pure Dart) | data, presentation |
| **data** | domain | presentation |

## Instructions for implementation

1. **Check Structure**: When evaluating code, verify it lives in the correct folder based on the structure above.
2. **Verify Types**: Ensure all models have proper `fromJson`/`toJson` methods.
3. **Review Logic**: Ensure business logic is NOT inside widgets, but in providers or usecases.
4. **Check Imports**: Verify no circular dependencies between layers.
