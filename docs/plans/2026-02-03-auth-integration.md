# Authentication Integration Plan

> **For Gemini:** REQUIRED SUB-SKILL: Use executing-plans to implement this plan task-by-task.

**Goal:** Connect the Flutter frontend authentication screens (Login, Signup, Forgot Password) to the existing FastAPI backend (`/api/v1/auth/*`).

**Architecture:** 
- **Frontend Layer:** `AuthService` (Dio) -> `AuthProvider` (Riverpod) -> UI Screens.
- **Backend Layer:** Existing FastAPI endpoints in `endpoints/auth.py`.

**Tech Stack:** Flutter, Riverpod, Dio, FastAPI.

---

### Task 1: API Configuration
**Files:**
- Modify: `mobile/lib/core/network/api_constants.dart` (Ensure base URL and endpoints match)

**Step 1: Verify API Constants**
Ensure `ApiConstants` points to the correct backend URL (e.g., `http://10.0.2.2:8000` for Android Emulator) and defines auth endpoints.

---

### Task 2: Auth Service Implementation
**Files:**
- Modify: `mobile/lib/features/auth/data/services/auth_service.dart`

**Step 1: Write Failing Test (Mental or Actual)**
Test that `login` calls `dio.post('/auth/login')`.

**Step 2: Implement Real `login`**
Replace mock logic with:
```dart
Future<AuthResponse> login(String email, String password) async {
  final response = await _dio.post(
    '/auth/login',
    data: FormData.fromMap({
      'username': email, // OAuth2 form uses 'username' field
      'password': password,
    }),
  );
  return AuthResponse.fromJson(response.data);
}
```

**Step 3: Implement Real `register`**
Call `POST /auth/register` with `UserCreate` body.

**Step 4: Implement Real `refreshToken`**
Call `POST /auth/refresh` with `refresh_token`.

---

### Task 3: Forgot Password Flow
**Files:**
- Modify: `mobile/lib/features/auth/data/services/auth_service.dart`
- Modify: `mobile/lib/features/auth/presentation/providers/reset_password_provider.dart`

**Step 1: Implement Service Methods**
- `requestPasswordReset(email)` -> `POST /auth/forgot-password`
- `verifyResetCode(email, code)` -> `POST /auth/verify-code`
- `resetPassword(token, newPassword)` -> `POST /auth/reset-password`

---

### Task 4: UI Connection (Login)
**Files:**
- Modify: `mobile/lib/features/auth/presentation/screens/login_screen.dart`

**Step 1: Connect to Provider**
Ensure `LoginScreen` invokes `ref.read(authProvider.notifier).login(...)` and handles loading/error states.

---

### Task 5: UI Connection (Signup)
**Files:**
- Modify: `mobile/lib/features/auth/presentation/screens/signup_screen.dart`

**Step 1: Connect to Provider**
Ensure `SignupScreen` invokes `ref.read(authProvider.notifier).register(...)`.

---

### Task 6: UI Connection (Forgot Password)
**Files:**
- Modify: `mobile/lib/features/auth/presentation/screens/forgot_password_screen.dart`

**Step 1: Connect to Provider**
Connect the 3-step wizard (Email -> Code -> New Password) to the backend calls.
