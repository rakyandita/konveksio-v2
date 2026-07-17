# Graph Report - .  (2026-07-17)

## Corpus Check
- cluster-only mode — file stats not available

## Summary
- 323 nodes · 351 edges · 69 communities (18 shown, 51 thin omitted)
- Extraction: 95% EXTRACTED · 5% INFERRED · 0% AMBIGUOUS · INFERRED: 16 edges (avg confidence: 0.81)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `6eb7f5f3`
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
- Win32Window
- _In_
- _In_opt_
- string
- vector
- wchar_t
- HWND
- LPARAM
- LRESULT
- Point
- RECT
- Size
- UINT
- wchar_t
- Win32Window
- WPARAM
- wstring
- HWND
- FlutterPluginRegistry
- String?
- State
- StatefulWidget

## God Nodes (most connected - your core abstractions)
1. `Win32Window` - 18 edges
2. `FlutterWindow` - 10 edges
3. `MessageHandler` - 10 edges
4. `authControllerProvider` - 10 edges
5. `Create` - 9 edges
6. `WndProc` - 9 edges
7. `_MyApplication` - 7 edges
8. `MessageHandler` - 7 edges
9. `WindowClassRegistrar` - 7 edges
10. `konveksio_app` - 7 edges

## Surprising Connections (you probably didn't know these)
- `OnCreate` --calls--> `RegisterPlugins()`  [INFERRED]
  app/windows/runner/flutter_window.h → app/windows/flutter/generated_plugin_registrant.cc
- `wWinMain()` --calls--> `CreateAndAttachConsole()`  [INFERRED]
  app/windows/runner/main.cpp → app/windows/runner/utils.cpp
- `Win32Window::Win32Window()` --calls--> `Destroy`  [INFERRED]
  app/windows/runner/win32_window.cpp → app/windows/runner/win32_window.h
- `CMakeLists.txt (Linux)` --conceptually_related_to--> `konveksio_app`  [INFERRED]
  app/linux/CMakeLists.txt → app/pubspec.yaml
- `my_application_activate()` --calls--> `fl_register_plugins()`  [INFERRED]
  app/linux/runner/my_application.cc → app/linux/flutter/generated_plugin_registrant.cc

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **Konveksio App Core Dependencies** — supabase_flutter, flutter_riverpod, go_router, flutter_dotenv [EXTRACTED 0.90]

## Communities (69 total, 51 thin omitted)

### Community 0 - "win32_window.cpp"
Cohesion: 0.09
Nodes (38): OnCreate, HWND, LPARAM, LRESULT, Point, RECT, Size, UINT (+30 more)

### Community 1 - "main.dart"
Cohesion: 0.10
Nodes (25): appRouterProvider, build, _handleLogin, authControllerProvider, BossHomeScreen, build, build, KaryawanHomeScreen (+17 more)

### Community 2 - "my_application.cc"
Cohesion: 0.09
Nodes (22): FlPluginRegistry, fl_register_plugins(), main(), FlView, GApplication, gboolean, gchar, GObject (+14 more)

### Community 3 - "login_screen.dart"
Cohesion: 0.08
Nodes (22): branchId, fromJson, id, role, UserProfile, createState, dispose, _errorMessage (+14 more)

### Community 4 - "app_theme.dart"
Cohesion: 0.09
Nodes (21): AppTheme, background, border, branchContext, destructive, foreground, muted, onBranchContext (+13 more)

### Community 5 - "FlutterWindow"
Cohesion: 0.12
Nodes (16): DartProject, HWND, LPARAM, LRESULT, UINT, WPARAM, FlutterWindow, flutter_controller_ (+8 more)

### Community 6 - "auth_provider.dart"
Cohesion: 0.14
Nodes (15): supabaseProvider, AuthController, authStateProvider, build, login, logout, session, supabase (+7 more)

### Community 7 - "app_router.dart"
Cohesion: 0.12
Nodes (16): authState, dispose, _GoRouterRefreshStream, _subscription, userProfile, ChangeNotifier, dart:async, ../../features/auth/presentation/screens/login_screen.dart (+8 more)

### Community 8 - "AppDelegate"
Cohesion: 0.15
Nodes (10): AppDelegate, Any, Bool, FlutterImplicitEngineBridge, UIApplication, AppDelegate, Bool, NSApplication (+2 more)

### Community 9 - "RunnerTests.swift"
Cohesion: 0.16
Nodes (8): RunnerTests, MainFlutterWindow, RunnerTests, Cocoa, FlutterMacOS, NSWindow, XCTest, XCTestCase

### Community 10 - "wWinMain"
Cohesion: 0.23
Nodes (9): _In_, _In_opt_, wWinMain(), string, vector, wchar_t, CreateAndAttachConsole(), GetCommandLineArguments() (+1 more)

### Community 11 - "manifest.json"
Cohesion: 0.18
Nodes (10): background_color, description, display, icons, name, orientation, prefer_related_applications, short_name (+2 more)

### Community 12 - "konveksio_app"
Cohesion: 0.25
Nodes (8): CMakeLists.txt (Linux), konveksio_app, flutter_dotenv, flutter_riverpod, Flutter SDK, go_router, google_fonts, supabase_flutter

## Knowledge Gaps
- **69 isolated node(s):** `parent_instance`, `dart_entrypoint_arguments`, `name`, `short_name`, `start_url` (+64 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **51 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `OnCreate` connect `win32_window.cpp` to `RegisterPlugins`, `FlutterWindow`?**
  _High betweenness centrality (0.016) - this node is a cross-community bridge._
- **Why does `FlutterWindow` connect `FlutterWindow` to `win32_window.cpp`?**
  _High betweenness centrality (0.013) - this node is a cross-community bridge._
- **Why does `Win32Window` connect `win32_window.cpp` to `FlutterWindow`?**
  _High betweenness centrality (0.013) - this node is a cross-community bridge._
- **Are the 3 inferred relationships involving `MessageHandler` (e.g. with `Destroy` and `GetClientArea`) actually correct?**
  _`MessageHandler` has 3 INFERRED edges - model-reasoned connections that need verification._
- **What connects `parent_instance`, `dart_entrypoint_arguments`, `name` to the rest of the system?**
  _69 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `win32_window.cpp` be split into smaller, more focused modules?**
  _Cohesion score 0.09059233449477352 - nodes in this community are weakly interconnected._
- **Should `main.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.10114942528735632 - nodes in this community are weakly interconnected._