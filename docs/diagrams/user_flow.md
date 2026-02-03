# User Flow Diagram: Splash to Reading

This diagram illustrates the user journey from opening the app to engaging with the Reading Screen, highlighting where the **Focus Session** logic integrates.

```mermaid
graph TD
    %% Nodes
    Splash[Splash Screen\n(Checking Auth)]
    Onboarding[Onboarding Flow\n(New User)]
    Auth[Auth Screen\n(Login/Signup)]
    Setup[Goal Setup Screen\n(Set Preferred Times)]
    
    Home[Home Screen\n(Dashboard)]
    
    %% Reading Flows
    CheckTime{Is it\nScheduled Time?}
    NormalRead[Reading Screen\n(Normal Mode)]
    FocusRead[Reading Screen\n(Focus Mode)]
    
    %% Logic
    Splash -- No Token --> Onboarding
    Onboarding --> Auth
    Auth --> Setup
    Setup --> Home
    
    Splash -- Token Valid --> Home
    
    %% Reading Entry Points
    Home -- User Taps 'Resume' --> CheckTime
    Home -- User Taps 'Quran' --> CheckTime
    
    CheckTime -- Yes --> FocusRead
    CheckTime -- No --> NormalRead
    
    %% Focus Mode Details
    FocusRead -- Auto-Start --> Timer[Timer Overlay\n(Active)]
    Timer --> Blocker[App Blocker\n(Active)]
    
    %% Session End
    NormalRead -- Back/Exit --> SavePos[Save Position]
    FocusRead -- End Session --> Summary[Session Summary\n(Stats & Hasanat)]
    Summary --> Home

    %% Styling
    style FocusRead fill:#13ec5b,color:#000,stroke:#d4af37,stroke-width:2px
    style NormalRead fill:#102216,color:#fff,stroke:#4ff285
    style CheckTime fill:#1c271f,color:#fff,stroke:#d4af37
```

## Flow Description
1.  **Splash**: Checks for existing authentication.
2.  **Onboarding/Auth**: New users set up account and **Goals** (critical for Focus Mode).
3.  **Home**: Central dashboard.
4.  **Entry to Reading**:
    *   System checks `UserGoal.preferred_times` against `CurrentTime`.
    *   **IF MATCH**: Directs to **Focus Mode** (Green path). Timer starts, Apps blocked.
    *   **IF NO MATCH**: Directs to **Normal Mode** (Dark path). Distraction-free reading.
5.  **Completion**:
    *   Normal: Silent save.
    *   Focus: Detailed summary screen with gathered stats.
