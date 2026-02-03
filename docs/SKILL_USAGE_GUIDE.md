# Antigravity Skill Usage Guide

This document provides a detailed reference for all available skills in the `.agent/skills/` directory. Use this guide to determine which skill to invoke for specific tasks.

---

## 🏗️ Architecture & Standards

### `mobile-app-architecture`
**Path:** `.agent/skills/mobile-app-architecture`
**When to use:**
- **Starting a New Project:** When setting up the initial folder structure and core dependencies.
- **Refactoring:** When reorganizing code to adhere to Clean Architecture (Data/Domain/Presentation).
- **Code Placement:** When you aren't sure where a file (Model, Repository, Widget) belongs.
- **Validating Structure:** To ensure the codebase follows the strict folder hierarchy.

### `mobile-coding-standards`
**Path:** `.agent/skills/mobile-coding-standards`
**When to use:**
- **Writing Code:** continuously while developing to ensure style compliance (naming, types, linting).
- **Refactoring:** When cleaning up technical debt or legacy code.
- **State Management:** When implementing Riverpod providers to ensure best practices (selective watching, async handling).
- **Code Review:** As a checklist for self-review before committing.

### `mobile-ui-standards`
**Path:** `.agent/skills/mobile-ui-standards`
**When to use:**
- **Building UI:** When creating new screens or widgets to ensure they match the "Emerald Night" design system.
- **Theming:** When using colors, typography, or spacing (never hardcode values!).
- **Responsiveness:** When ensuring layouts work on all screen sizes (safe areas, flexible widgets).
- **Accessibility:** When implementing touch targets, semantic labels, and contrast checks.

### `mobile-security-standards`
**Path:** `.agent/skills/mobile-security-standards`
**When to use:**
- **Sensitive Data:** When handling tokens, passwords, or PII (use SecureStorage, not SharedPreferences).
- **Authentication:** When implementing login/logout flows and session management.
- **Networking:** When configuring SSL pinning or secure API clients.
- **Production Prep:** When hardening the app for release (obfuscation, removing logs).

### `api-integration-standards`
**Path:** `.agent/skills/api-integration-standards`
**When to use:**
- **Connecting APIs:** When building new service layers or repositories using Dio.
- **Error Handling:** When converting HTTP errors into app-specific exceptions.
- **Authentication:** When creating interceptors for JWT token injection and refreshing.
- **Offline Mode:** When implementing caching or retry logic.

---

## 🚀 Workflow & Process

### `brainstorming`
**Path:** `.agent/skills/brainstorming`
**When to use:**
- **The Start:** BEFORE writing any code or plans.
- **Clarification:** When requirements are vague or high-level.
- **Design:** To explore implementation options (Option A vs B) and agree on an approach.
- **Outcome:** Produces a validated design doc needed for the `planning` skill.

### `planning`
**Path:** `.agent/skills/planning`
**When to use:**
- **After Brainstorming:** Once the design is agreed upon.
- **Before Coding:** To generate a step-by-step Implementation Plan (`docs/plans/xxx.md`).
- **Complex Tasks:** When a feature involves multiple files or layers.
- **Outcome:** A detailed Markdown plan that can be executed by subagents.

### `feature-development-workflow`
**Path:** `.agent/skills/feature-development-workflow`
**When to use:**
- **New Features:** A high-level checklist for the entire lifecycle (Plan -> Setup -> Dev -> Test -> Review).
- **Jira/User Stories:** When starting work on a specific ticket.
- **Context:** Helps you remember "Did I verify mobile responsiveness?" or "Did I add analytics?".

### `using-git-worktrees`
**Path:** `.agent/skills/using-git-worktrees`
**When to use:**
- **Isolation:** When you need to work on a feature without messing up the current directory.
- **Parallel Work:** When you want to keep the main branch clean while experimenting.
- **Setup:** Automatically handles `git worktree add`, dependency installation, and baseline verification.

---

## ⚡ Execution & Implementation

### `subagent-driven-development`
**Path:** `.agent/skills/subagent-driven-development`
**When to use:**
- **Executing Plans (Same Session):** The preferred way to build features.
- **Task Loop:** Dispatches fresh subagents for each task in a plan.
- **Quality Gates:** Enforces "Spec Review" and "Code Quality Review" for every single task.
- **Use this when:** You have a plan and want to implement it efficiently right now.

### `executing-plans`
**Path:** `.agent/skills/executing-plans`
**When to use:**
- **Executing Plans (Separate Session):** When you want to manually run a plan or use a long-lived session.
- **Batching:** When you want to do 3 tasks at a time and then check in.
- **Legacy:** `subagent-driven-development` is generally preferred for speed/quality.

### `test-driven-development`
**Path:** `.agent/skills/test-driven-development`
**When to use:**
- **Implementing Logic:** ALWAYS write the test *first* (Red-Green-Refactor).
- **Bug Fixes:** Write a test that reproduces the bug before fixing it.
- **Core Principle:** "No production code without a failing test first."

### `error-handling-patterns`
**Path:** `.agent/skills/error-handling-patterns`
**When to use:**
- **Resilience:** When designing how the app recovers from failures.
- **Patterns:** Choosing between Exceptions, Result types, or Circuit Breakers.
- **Language Specifics:** Reference for Python vs Dart error handling patterns.

---

## 🏁 Verification & Completion

### `requesting-code-review`
**Path:** `.agent/skills/requesting-code-review`
**When to use:**
- **Checkpoints:** After completing a major task or feature.
- **Validation:** To get an AI "second opinion" on code quality, logic, and edge cases.
- **Before Merge:** Essential step before declaring work "done".

### `finishing-a-development-branch`
**Path:** `.agent/skills/finishing-a-development-branch`
**When to use:**
- **Feature Complete:** When all tasks are done and tests pass.
- **Cleanup:** To determine what to do with the branch (Merge, PR, or Discard).
- **Process:** Verifies tests one last time before allowing a merge.

### `mobile-deployment-pipeline`
**Path:** `.agent/skills/mobile-deployment-pipeline`
**When to use:**
- **Releasing:** Building APKs/IPAs for TestFlight or Play Store.
- **CI/CD:** Configuring GitHub Actions or Fastlane.
- **Environment:** Managing Dev vs Staging vs Prod flavors.

---

## 🎨 Branding & Meta

### `brand-identity`
**Path:** `.agent/skills/brand-identity`
**When to use:**
- **Copywriting:** When writing app content, error messages, or marketing text.
- **Visuals:** Source of truth for the "Emerald Night" aesthetic and voice/tone.
- **Legal:** Attribution and license checks.

### `creating-skills`
**Path:** `.agent/skills/creating-skills`
**When to use:**
- **Meta-Work:** When you want to teach the agent a NEW skill.
- **templating:** Generates the correct folder structure and YAML frontmatter for new skills.
