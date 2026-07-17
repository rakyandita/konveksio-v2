# Graph Report - konveksio-v2  (2026-07-17)

## Corpus Check
- 74 files · ~47,758 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 576 nodes · 637 edges · 49 communities (42 shown, 7 thin omitted)
- Extraction: 97% EXTRACTED · 3% INFERRED · 0% AMBIGUOUS · INFERRED: 18 edges (avg confidence: 0.81)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `e4a17cf0`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- win32_window.cpp
- main.dart
- my_application.cc
- login_screen.dart
- app_theme.dart
- FlutterWindow
- auth_provider.dart
- app_router.dart
- AppDelegate
- RunnerTests.swift
- wWinMain
- manifest.json
- konveksio_app
- RegisterPlugins
- MainActivity
- SceneDelegate
- FlutterActivity
- FlutterActivity
- Any
- Bool
- FlutterImplicitEngineBridge
- UIApplication
- FlPluginRegistry
- FlView
- GApplication
- gboolean
- gchar
- GObject
- GtkApplication
- MyApplicationClass
- Bool
- NSApplication
- PluginRegistry
- DartProject
- HWND
- LPARAM
- LRESULT
- UINT
- WPARAM
- DartProject
- FlutterViewController
- unique_ptr
- String?

## God Nodes (most connected - your core abstractions)
1. `Win32Window` - 22 edges
2. `MessageHandler` - 12 edges
3. `[Fase 1 | SoT #1] SRS: Konveksio` - 12 edges
4. `3. System Features` - 12 edges
5. `[Fase 2 | SoT #3] Design System` - 11 edges
6. `authControllerProvider` - 10 edges
7. `FlutterWindow` - 10 edges
8. `Create` - 10 edges
9. `WndProc` - 10 edges
10. `[Fase 4 | SoT #6] Data Model Registry` - 10 edges

## Surprising Connections (you probably didn't know these)
- `OnCreate` --calls--> `RegisterPlugins()`  [INFERRED]
  app/windows/runner/flutter_window.h → app/windows/flutter/generated_plugin_registrant.cc
- `wWinMain()` --calls--> `CreateAndAttachConsole()`  [INFERRED]
  app/windows/runner/main.cpp → app/windows/runner/utils.cpp
- `Win32Window::Win32Window()` --calls--> `Destroy`  [INFERRED]
  app/windows/runner/win32_window.cpp → app/windows/runner/win32_window.h
- `CMakeLists.txt (Linux)` --conceptually_related_to--> `konveksio_app`  [INFERRED]
  app/linux/CMakeLists.txt → app/pubspec.yaml
- `_handleLogin` --references--> `authControllerProvider`  [EXTRACTED]
  app/lib/features/auth/presentation/screens/login_screen.dart → app/lib/features/auth/providers/auth_provider.dart

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **Konveksio App Core Dependencies** — supabase_flutter, flutter_riverpod, go_router, flutter_dotenv [EXTRACTED 0.90]

## Communities (49 total, 7 thin omitted)

### Community 0 - "win32_window.cpp"
Cohesion: 0.07
Nodes (51): DartProject, HWND, LPARAM, LRESULT, UINT, WPARAM, FlutterWindow, flutter_controller_ (+43 more)

### Community 1 - "main.dart"
Cohesion: 0.06
Nodes (42): appRouterProvider, build, createState, dispose, _errorMessage, _formKey, _handleLogin, _isPasswordVisible (+34 more)

### Community 2 - "my_application.cc"
Cohesion: 0.09
Nodes (22): fl_register_plugins(), main(), first_frame_cb(), my_application_activate(), my_application_class_init(), my_application_dispose(), my_application_init(), my_application_local_command_line() (+14 more)

### Community 3 - "login_screen.dart"
Cohesion: 0.33
Nodes (5): branchId, fromJson, id, role, UserProfile

### Community 4 - "app_theme.dart"
Cohesion: 0.09
Nodes (21): AppTheme, background, border, branchContext, destructive, foreground, muted, onBranchContext (+13 more)

### Community 5 - "FlutterWindow"
Cohesion: 0.04
Nodes (47): 10. Future Considerations (V2+), 11. Revision History, 1.1 Purpose, 1.2 Scope, 1.3 Stakeholders, 1.4 Definitions, 1.5 References, 1. Introduction (+39 more)

### Community 6 - "auth_provider.dart"
Cohesion: 0.14
Nodes (15): supabaseProvider, AuthController, authStateProvider, build, login, logout, session, supabase (+7 more)

### Community 7 - "app_router.dart"
Cohesion: 0.12
Nodes (16): authState, dispose, _GoRouterRefreshStream, _subscription, userProfile, ChangeNotifier, dart:async, ../../features/auth/presentation/screens/login_screen.dart (+8 more)

### Community 8 - "AppDelegate"
Cohesion: 0.08
Nodes (25): 10. Traceability, 1. Core Principles, 2. Color Palette, 3. Typography, 4. Spacing & Layout (8dp Rhythm), 5.1. Buttons (Tombol), 5.2. Cards, 5.3. Kotak Input (Text Field) (+17 more)

### Community 9 - "RunnerTests.swift"
Cohesion: 0.07
Nodes (23): Any, AppDelegate, Bool, SceneDelegate, RunnerTests, AppDelegate, Bool, MainFlutterWindow (+15 more)

### Community 10 - "wWinMain"
Cohesion: 0.24
Nodes (9): wWinMain(), string, wchar_t, CreateAndAttachConsole(), GetCommandLineArguments(), Utf8FromUtf16(), _In_, _In_opt_ (+1 more)

### Community 11 - "manifest.json"
Cohesion: 0.18
Nodes (10): background_color, description, display, icons, name, orientation, prefer_related_applications, short_name (+2 more)

### Community 12 - "konveksio_app"
Cohesion: 0.25
Nodes (8): CMakeLists.txt (Linux), konveksio_app, flutter_dotenv, flutter_riverpod, Flutter SDK, go_router, google_fonts, supabase_flutter

### Community 15 - "SceneDelegate"
Cohesion: 0.11
Nodes (17): 1. Objective & Threat Model, 2. Entity Relationship Diagram (ERD), 3.1. Tenant & Auth, 3.2. Master Data, 3.3. Transaksional (Order & SPK), 3.4. Produksi & Tracking, 3.5. Keuangan & SDM, 3.6. Notifikasi (+9 more)

### Community 17 - "FlutterActivity"
Cohesion: 0.18
Nodes (9): 1. Overview, 2. Global Navigation Strategy, 3.1. Role: Owner (Super Admin), 3.2. Role: Boss Cabang / Admin, 3.3. Role: Karyawan Produksi, 3. Sitemap & Page Hierarchy, 4. Route Mapping (Flutter Navigation), 5. Traceability (+1 more)

### Community 21 - "FlutterActivity"
Cohesion: 0.18
Nodes (10): 1. Metadata, 2. Main Flow (Skenario Utama), 3. Alternative Flows, 4. Exception Flows, 5. Postconditions, 6. Related Pages, 7. Acceptance Criteria, 8. Data Used (+2 more)

### Community 22 - "Any"
Cohesion: 0.18
Nodes (10): 1. Metadata, 2. Main Flow (Skenario Utama), 3. Alternative Flows, 4. Exception Flows, 5. Postconditions, 6. Related Pages, 7. Acceptance Criteria, 8. Data Used (+2 more)

### Community 23 - "Bool"
Cohesion: 0.18
Nodes (10): 1. Metadata, 2. Main Flow (Skenario Utama), 3. Alternative Flows, 4. Exception Flows, 5. Postconditions, 6. Related Pages, 7. Acceptance Criteria, 8. Data Used (+2 more)

### Community 24 - "FlutterImplicitEngineBridge"
Cohesion: 0.18
Nodes (10): 1. Metadata, 2. Main Flow (Skenario Utama Karyawan → Karyawan), 3. Alternative Flows, 4. Exception Flows, 5. Postconditions, 6. Related Pages, 7. Acceptance Criteria, 8. Data Used (+2 more)

### Community 25 - "UIApplication"
Cohesion: 0.18
Nodes (10): 1. Metadata, 2. Main Flow (Skenario Utama), 3. Alternative Flows, 4. Exception Flows, 5. Postconditions, 6. Related Pages, 7. Acceptance Criteria, 8. Data Used (+2 more)

### Community 26 - "FlPluginRegistry"
Cohesion: 0.18
Nodes (10): 1. Metadata, 2. Main Flow (Skenario Utama), 3. Alternative Flows, 4. Exception Flows, 5. Postconditions, 6. Related Pages, 7. Acceptance Criteria, 8. Data Used (+2 more)

### Community 27 - "FlView"
Cohesion: 0.18
Nodes (10): 1. Metadata, 2. Main Flow (Skenario Utama), 3. Alternative Flows, 4. Exception Flows, 5. Postconditions, 6. Related Pages, 7. Acceptance Criteria, 8. Data Used (+2 more)

### Community 28 - "GApplication"
Cohesion: 0.18
Nodes (10): 1. Metadata, 2. Main Flow (Skenario Utama), 3. Alternative Flows, 4. Exception Flows, 5. Postconditions, 6. Related Pages, 7. Acceptance Criteria, 8. Data Used (+2 more)

### Community 29 - "gboolean"
Cohesion: 0.18
Nodes (10): 1. Metadata, 2. Main Flow (Skenario Utama), 3. Alternative Flows, 4. Exception Flows, 5. Postconditions, 6. Related Pages, 7. Acceptance Criteria, 8. Data Used (+2 more)

### Community 30 - "gchar"
Cohesion: 0.22
Nodes (8): 1. Purpose, 2. File Structure, 3. User Flow Catalog, 4. Requirement → User Flow Mapping, 5. Page → User Flow Mapping, 6. Dependencies, 7. Revision History, [Fase 2 | SoT #4] User Flows Registry

### Community 31 - "GObject"
Cohesion: 0.22
Nodes (8): Architecture Decisions, Checkpoint: Complete, Checkpoint: Foundation, Implementation Plan: Fase 2 (Product Structure), Overview, Phase 1: Information Architecture & Design System, Phase 2: User Flows Core, Task List

### Community 32 - "GtkApplication"
Cohesion: 0.25
Nodes (7): 1. Use Case Reference, 2. Related Screens, 3. Sequence Diagram, 4. API Contract (Postgres RPC), 5. Data Mapping, 6. Error Handling, [Fase 5 | SoT #7] UC-001 Pembuatan Order & SPK

### Community 33 - "MyApplicationClass"
Cohesion: 0.29
Nodes (6): 1. Purpose, 2. File Structure, 3. System Logic Catalog, 4. API Overview, 5. Revision History, [Fase 5 | SoT #7] System Logics (UCIC) Registry

### Community 34 - "Bool"
Cohesion: 0.29
Nodes (6): 1. Use Case Reference, 2. Related Screens, 3. Sequence Diagram, 4. API Contract (Supabase Auth SDK), 5. Error Handling, [Fase 5 | SoT #7] UC-000 Login & Role Redirect

### Community 35 - "NSApplication"
Cohesion: 0.29
Nodes (6): 1. Use Case Reference, 2. Related Screens, 3. Sequence Diagram, 4. API Contract (Postgres RPC), 5. Error Handling, [Fase 5 | SoT #7] UC-002 Smart Bulk Assign

### Community 36 - "PluginRegistry"
Cohesion: 0.29
Nodes (6): 1. Use Case Reference, 2. Related Screens, 3. Sequence Diagram, 4. API Contract (Supabase SDK & RPC), 5. Error Handling, [Fase 5 | SoT #7] UC-003 Handover & Auto-Task

### Community 37 - "DartProject"
Cohesion: 0.29
Nodes (6): 1. Use Case Reference, 2. Related Screens, 3. Sequence Diagram, 4. API Contract (Supabase SDK & RPC), 5. Error Handling, [Fase 5 | SoT #7] UC-004 Pengajuan Kasbon

### Community 38 - "HWND"
Cohesion: 0.29
Nodes (6): 1. Use Case Reference, 2. Related Screens, 3. Sequence Diagram, 4. API Contract (Postgres RPC), 5. Error Handling, [Fase 5 | SoT #7] UC-005 Generate Gaji Mingguan

### Community 39 - "LPARAM"
Cohesion: 0.29
Nodes (6): 1. Use Case Reference, 2. Related Screens, 3. Sequence Diagram, 4. API Contract (Supabase SDK), 5. Error Handling, [Fase 5 | SoT #7] UC-006 Update Progres Mandiri

### Community 40 - "LRESULT"
Cohesion: 0.29
Nodes (6): 1. Use Case Reference, 2. Related Screens, 3. Sequence Diagram, 4. API Contract (Supabase SDK), 5. Error Handling, [Fase 5 | SoT #7] UC-007 Owner Branch Context Mode

### Community 41 - "UINT"
Cohesion: 0.29
Nodes (6): 1. Use Case Reference, 2. Related Screens, 3. Sequence Diagram, 4. API Contract (Supabase SDK), 5. Error Handling, [Fase 5 | SoT #7] UC-008 Manajemen Vendor Eksternal

## Knowledge Gaps
- **301 isolated node(s):** `authState`, `userProfile`, `_subscription`, `dispose`, `AppTheme` (+296 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **7 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `FlutterWindow` connect `win32_window.cpp` to `RunnerTests.swift`?**
  _High betweenness centrality (0.019) - this node is a cross-community bridge._
- **Are the 4 inferred relationships involving `MessageHandler` (e.g. with `Destroy` and `GetClientArea`) actually correct?**
  _`MessageHandler` has 4 INFERRED edges - model-reasoned connections that need verification._
- **What connects `authState`, `userProfile`, `_subscription` to the rest of the system?**
  _301 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `win32_window.cpp` be split into smaller, more focused modules?**
  _Cohesion score 0.06594071385359952 - nodes in this community are weakly interconnected._
- **Should `main.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.05952380952380952 - nodes in this community are weakly interconnected._
- **Should `my_application.cc` be split into smaller, more focused modules?**
  _Cohesion score 0.09401709401709402 - nodes in this community are weakly interconnected._
- **Should `app_theme.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.09090909090909091 - nodes in this community are weakly interconnected._