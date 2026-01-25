---
name: ensuring-mobile-standards
description: Ensure consistent code quality, style, and best practices for Flutter apps. Use when writing code, reviewing PRs, or setting up linting.
---

# Flutter Coding Standards

## When to use this skill
- When writing new code or refactoring existing code.
- During code reviews to check for adherence to standards.
- When configuring linting or formatting rules.
- When creating new widgets to ensure they meet quality guidelines.

## Code Style

### Type Checking
- Use Dart with strict analysis options enabled
- Avoid `dynamic` - always specify types
- Use `final` for immutable variables, `const` for compile-time constants

### Linting
Follow `analysis_options.yaml` rules:
```yaml
include: package:flutter_lints/flutter.yaml

linter:
  rules:
    prefer_const_constructors: true
    prefer_const_declarations: true
    avoid_print: true
    require_trailing_commas: true
```

### Naming Conventions
- **PascalCase**: Classes, enums, typedefs, extensions, mixins
- **camelCase**: Variables, functions, parameters, named parameters
- **snake_case**: File names, folder names
- **SCREAMING_CAPS**: Constants only
- Use meaningful, descriptive names (e.g., `fetchUserProfile` not `getData`)

### Documentation
- Add `///` doc comments for public APIs, classes, and complex functions
- Document parameters with `[paramName]` syntax
- Add `// TODO:` comments for incomplete work

## Widget Guidelines

### Functional Components
- Prefer `StatelessWidget` over `StatefulWidget` when possible
- Use `ConsumerWidget` or `ConsumerStatefulWidget` with Riverpod
- Extract `build` method logic into smaller private widgets

### Typed Props
Define all widget parameters with types:
```dart
class VerseCard extends StatelessWidget {
  final String arabicText;
  final String translation;
  final int verseNumber;
  final VoidCallback? onTap;

  const VerseCard({
    super.key,
    required this.arabicText,
    required this.translation,
    required this.verseNumber,
    this.onTap,
  });
}
```

### Size Limit
- Keep widgets small and focused: **<300 lines**
- Split larger widgets into smaller sub-widgets
- Extract repeated patterns into reusable components

### Logic Extraction
- Move business logic to Riverpod providers or usecases
- Keep widgets "dumb" - only UI rendering
- Use `ref.watch()` for reactive state, `ref.read()` for actions

## State Management (Riverpod)

### Provider Types
| Type | Use Case |
|------|----------|
| `Provider` | Computed/derived values, service instances |
| `StateProvider` | Simple single-value state |
| `StateNotifierProvider` | Complex state with multiple actions |
| `FutureProvider` | One-time async data fetch |
| `StreamProvider` | Real-time data streams |
| `ChangeNotifierProvider` | Legacy code migration only |

### Best Practices
```dart
// ✅ Good: Selective watching
final userName = ref.watch(userProvider.select((u) => u.name));

// ❌ Bad: Watching entire object when only name needed
final user = ref.watch(userProvider);
```

### Async Handling
Handle all three states explicitly:
```dart
asyncValue.when(
  data: (data) => DataWidget(data),
  loading: () => const LoadingIndicator(),
  error: (error, stack) => ErrorWidget(message: error.toString()),
);
```

## API Integration

### Async/Await
- Use `async`/`await` syntax for all async operations
- Avoid `.then()` chains - use `await` instead

### Error Handling
```dart
try {
  final response = await dio.get('/api/users');
  return User.fromJson(response.data);
} on DioException catch (e) {
  throw ApiException.fromDio(e);
} catch (e) {
  throw UnknownException(e.toString());
}
```

### Repository Pattern
```dart
// Interface (domain layer)
abstract class UserRepository {
  Future<User> getUser(String id);
}

// Implementation (data layer)
class UserRepositoryImpl implements UserRepository {
  final Dio dio;
  
  @override
  Future<User> getUser(String id) async {
    final response = await dio.get('/users/$id');
    return User.fromJson(response.data);
  }
}
```

## Performance

### Const Constructors
```dart
// ✅ Good
const Text('Hello');
const SizedBox(height: 16);

// ❌ Bad
Text('Hello');
SizedBox(height: 16);
```

### Lazy Loading
- Use `go_router` for lazy route loading
- Use `FutureProvider` for data that can wait

### Lists
- Use `ListView.builder` for long lists (not `ListView` with children)
- Add `itemExtent` when items have fixed height
- Use `const` constructors for list item widgets

### Avoid Rebuilds
```dart
// ✅ Good: Extract to separate widget
class _UserAvatar extends StatelessWidget {
  // Only rebuilds when user changes
}

// ❌ Bad: Inline widget rebuilt on every parent rebuild
```

## Testing

### Test Types
| Type | Location | Purpose |
|------|----------|---------|
| Unit | `test/` | Business logic, utilities |
| Widget | `test/widgets/` | UI component behavior |
| Integration | `integration_test/` | Full user flows |

### Naming Convention
```dart
test('should return hasanat when verse is read', () {
  // Arrange, Act, Assert
});

testWidgets('should display error when API fails', (tester) async {
  // Widget test
});
```
