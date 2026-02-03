---
description: Standard workflow for building new features (Prototype -> Mobile -> Backend)
---

# Feature Development Workflow

Follow this 5-step process for every new feature to ensure pixel-perfect implementation and zero backend waste.

## 1. Plan & Data Shape
Before coding, define *exactly* what data the feature needs.
*   [ ] Create/Update `technical_masterplan.md`
*   [ ] Define the JSON structure (Models)
*   [ ] **Stop**: Do not proceed until you know the JSON shape.

## 2. HTML Prototype (The Visual Check)
Verify the UX in the fast HTML/JS prototype first.
*   [ ] Modify `d:\Habit\prototype\index.html`
*   [ ] update `app.js` with logic + fake data
*   [ ] **Validation**: User must approve the "Feel" in the browser.

## 3. Flutter Shell (The Mobile Mock)
Build the "Walking Skeleton" in Flutter using Mock Data.
*   [ ] Create `MockDataService` method (e.g., `getFeatureData()`)
*   [ ] Build Widgets & Screens in `mobile/lib/features/...`
*   [ ] **Validation**: Run on simulator. It must *look* working, even with fake data.

## 4. Backend Engine
Build the API to match the Mock Data.
*   [ ] Create FastAPI Models & Schemas
*   [ ] Implement Endpoints
*   [ ] **Validation**: `curl` request must return the *exact same JSON structure* as Step 3.

## 5. Integration (The Wiring)
Connect the wires.
*   [ ] Switch Flutter from `MockRepository` to `ApiRepository`
*   [ ] Verify Error Handling & Loading States

---
**Why this order?**
If we build Backend first, we often find the UI needs different data, causing rework. By building UI first (Steps 2 & 3), the Backend requirements become rigorous and fixed.
