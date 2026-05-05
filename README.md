# dddflutter Brick

Flutter DDD (Domain Driven Design) project template with clean architecture structure, Riverpod state management, and go_router navigation.

## Prerequisites

This brick requires [Mason](https://github.com/felangel/mason) to be installed globally:

```bash
dart pub global activate mason_cli
```

Verify installation:
```bash
mason --version
```

## Architecture

The brick follows a DDD layered architecture:

```
lib/
├── config/                 # App configuration
│   ├── constants/          # Environment variables, constants
│   ├── routers/            # go_router setup with auth guards
│   └── theme/              # App theme and styling
│
├── domain/                 # Business logic layer (pure Dart)
│   ├── datasources/        # Abstract data source interfaces
│   ├── entities/           # Domain models / entities
│   └── repositories/       # Abstract repository contracts
│
├── infraestructure/        # Data layer (implements domain contracts)
│   ├── datasources/        # Concrete data source implementations
│   ├── models/             # Response models, parsers
│   └── repositories/       # Concrete repository implementations
│
├── presentation/           # UI layer
│   ├── providers/          # Riverpod providers (Notifier, autoDispose)
│   │   ├── auth/           # Authentication state & login
│   │   ├── example/        # Example CRUD provider
│   │   └── general/        # Shared providers (secure storage, etc.)
│   ├── screens/            # Page/screen widgets
│   ├── services/           # Notification, URL launcher, etc.
│   └── widgets/            # Reusable UI components
│
└── utils/                  # Helper functions and utilities
```

## Dependencies

The brick includes these dependencies in `pubspec.yaml`:

| Package | Version | Purpose |
|---------|---------|---------|
| `flutter_riverpod` | ^3.3.1 | State management (Notifier, autoDispose) |
| `go_router` | ^17.1.0 | Declarative routing with auth guards |
| `flutter_secure_storage` | ^10.0.0 | Secure token/credential storage |
| `flutter_web_plugins` | SDK | Web URL strategy |

A post-gen hook automatically adds missing dependencies to `pubspec.yaml` and runs `flutter pub get`.

## Usage

### From local path

```bash
mason make dddflutter --path /path/to/bricks/dddflutter
```

### From Git

```bash
mason add dddflutter --git-url https://github.com/your-user/dddflutter-brick
mason make dddflutter
```

### With config file (non-interactive)

```bash
mason make dddflutter --config-path mason.json
```

Where `mason.json` contains:

```json
{
  "project_name": "my_app",
  "description": "A new Flutter project.",
  "app_title": "My App"
}
```

## Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `project_name` | Project name (used for imports) | `my_app` |
| `description` | Project description | `A new Flutter project.` |
| `app_title` | App display title | `My App` |

## What's Included

### Routing
- `goRouterProvider` — Riverpod provider for GoRouter with auth state refresh
- `addPublicRoute` / `addPrivateRoute` — Auth-guarded route helpers
- `auth_routes.dart` / `private_routes.dart` — Separate route definitions

### Authentication
- `AuthProviderNotifier` — Manages auth state, tokens, login/logout
- `AuthState` with `copyWith` — Status, user, error, tokens
- `LoginStateNotifier` — Form validation + login flow
- `SecureStorageService` — Encrypted token storage

### Data Layer Pattern
Each feature follows this pattern:

1. **Domain** — Abstract datasource interface + abstract repository
2. **Infrastructure** — Concrete datasource impl + repository impl
3. **Presentation** — Riverpod `repositoryProvider` + `featureProvider` (Notifier)

The `example` module demonstrates a full CRUD flow with `example_provider.dart`.

### UI Components
- `CustomInputForm` — Reusable form field with validation
- `PanelLoadingIndicator` — Overlay loading spinner
- `NotificationService` — Snackbar error/success messages

### Hooks
- `post_gen.dart` — Auto-adds missing dependencies and runs `flutter pub get`

## Getting Started After Generation

1. Run `mason make dddflutter` in your project root
2. Update `lib/config/constants/env.dart` with your API base URL
3. Customize `lib/config/theme/app_theme.dart` with your colors
4. Implement your datasource in `lib/infraestructure/datasources/`
5. Add screens and providers following the `example` pattern

## Riverpod Pattern

Providers use the modern `Notifier` API (Riverpod 2.x+):

```dart
final exampleProvider = NotifierProvider<ExampleNotifier, ExampleState>(
  ExampleNotifier.new,
);

class ExampleNotifier extends Notifier<ExampleState> {
  late final ExampleRepository _repository;

  @override
  ExampleState build() {
    _repository = ref.read(exampleRepositoryProvider);
    return ExampleState();
  }

  Future<void> fetch() async {
    // ...
  }
}
```

For auto-dispose providers:
```dart
final loginProvider = NotifierProvider.autoDispose<LoginNotifier, LoginState>(
  LoginNotifier.new,
);
```
