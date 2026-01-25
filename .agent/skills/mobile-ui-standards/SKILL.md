---
name: maintaining-ui-standards
description: Maintain consistent UI/UX, enforce design system usage, and ensure accessibility/responsiveness for Flutter apps. Use when designing screens, styling widgets, or reviewing UI implementation.
---

# Flutter UI/UX Standards

## When to use this skill
- When implementing new UI screens or widgets.
- When applying themes or styles.
- When reviewing UI/UX design choices.
- When debugging layout or responsiveness issues.

## Design System

### Single Source of Truth
Always use theme variables - never hardcode values:
```dart
// ✅ Good
color: Theme.of(context).colorScheme.primary
color: context.emeraldPrimary // via ThemeExtension

// ❌ Bad
color: Color(0xFF13ec5b)
```

### Color Palette (Emerald Night Theme)
Use semantic color names from the design system:
```dart
// Primary
emeraldPrimary: Color(0xFF13ec5b)
emeraldLight: Color(0xFF4ff285)
emeraldGlow: Color(0xFF13ec5b).withOpacity(0.3)

// Backgrounds
deepForest: Color(0xFF102216)
surfaceDark: Color(0xFF1c271f)

// Accents
gold: Color(0xFFd4af37)
streakOrange: Color(0xFFf97316)
```

### Typography
Use the defined type scale from `app_theme.dart`:
```dart
// Headings
Theme.of(context).textTheme.headlineLarge
Theme.of(context).textTheme.headlineMedium

// Body
Theme.of(context).textTheme.bodyLarge
Theme.of(context).textTheme.bodyMedium

// Arabic text - custom style
AppTextStyles.arabicAyah // 36px, Noto Sans Arabic
```

### Spacing Scale
Based on 4px unit - use theme constants:
```dart
const spacing4 = 4.0;
const spacing8 = 8.0;
const spacing12 = 12.0;
const spacing16 = 16.0;  // Base spacing
const spacing20 = 20.0;
const spacing24 = 24.0;
const spacing32 = 32.0;
```

### Border Radius
Use consistent radii from design tokens:
```dart
const radiusSmall = 8.0;
const radiusMedium = 12.0;
const radiusLarge = 16.0;
const radiusFull = 9999.0;  // Pills/circles
```

## Widget Standards

### Consistency
- Use project's reusable widgets from `/shared/widgets` first
- Check if a similar widget exists before creating new ones
- Follow the Emerald Night visual guidelines

### Platform Conventions
- Use `Platform.isIOS` / `Platform.isAndroid` for platform-specific behavior
- Respect safe areas with `SafeArea` widget
- Handle notches with `MediaQuery.of(context).padding`

### Accessibility (A11y)
```dart
// Touch targets: minimum 48x48
SizedBox(
  width: 48,
  height: 48,
  child: IconButton(...),
)

// Semantic labels
Semantics(
  label: 'Play Quran recitation',
  child: PlayButton(),
)

// Sufficient contrast: WCAG AA (4.5:1 for text)
```

### Dark Mode
All widgets must work with the Emerald Night dark theme:
```dart
// Use theme colors that adapt
color: Theme.of(context).colorScheme.onSurface
backgroundColor: Theme.of(context).colorScheme.surface
```

## Responsive Design

### Mobile First
Design for smallest screen (320px width) first, then scale up.

### Safe Areas
```dart
SafeArea(
  child: Scaffold(
    body: ...,
  ),
)
```

### Layouts
```dart
// ✅ Good: Flexible layouts
Expanded(child: ...)
Flexible(child: ...)
FractionallySizedBox(widthFactor: 0.8, ...)

// ❌ Bad: Fixed dimensions
Container(width: 375, ...) // Hardcoded phone width
```

### Testing
Verify UI on:
- Small phones (320px width)
- Standard phones (375-414px)
- Large phones (428px+)
- Tablets (if supported)

## User Experience

### Loading States
```dart
// Shimmer effect for content loading
Shimmer.fromColors(
  baseColor: Color(0xFF1c271f),
  highlightColor: Color(0xFF23482f),
  child: ContentPlaceholder(),
)

// Centered loader for full-screen loading
const Center(child: CircularProgressIndicator())
```

### Error States
```dart
// User-friendly error messages
ErrorWidget(
  message: 'Unable to load verses. Please check your connection.',
  onRetry: () => ref.refresh(versesProvider),
)

// ❌ Bad: Technical errors
Text('DioException: Connection timeout')
```

### Success Feedback
```dart
// Snackbar for success
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text('Goal saved successfully')),
);

// Celebration for achievements
showDialog(
  context: context,
  builder: (_) => CelebrationDialog(milestone: milestone),
);
```

### Interactions
```dart
// Button press feedback
InkWell(
  onTap: onTap,
  splashColor: emeraldPrimary.withOpacity(0.2),
  child: ...,
)

// Haptic feedback for significant actions
HapticFeedback.lightImpact();
```

### Navigation
Follow standard Flutter patterns:
- `go_router` for declarative navigation
- Bottom navigation for main sections
- Stack navigation within features
- Modal bottom sheets for options
