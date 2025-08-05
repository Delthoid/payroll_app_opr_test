# Payroll App Operational Test (Flutter)

This repository is a Flutter assessment project demonstrating clean architecture, dependency injection, and state management with **flutter_bloc**.

---

## Features

- **Clean Architecture:** Project organized into clear layers (presentation, domain, data, core) for testability and scalability.
- **Dependency Injection:** All dependencies are managed using the [get_it](https://pub.dev/packages/get_it) package and initialized via a central setup function (`setup()`).
- **State Management:** Uses [flutter_bloc](https://pub.dev/packages/flutter_bloc) for business logic separation and reactive UI updates.
- **Navigation:** Routing is implemented with [go_router](https://pub.dev/packages/go_router), including nested routes for feature flows.

---

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.x recommended)
- [Dart SDK](https://dart.dev/get-dart)
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/) with Flutter plugin
- Xcode (for iOS, on macOS)
- Git

### Installation

Clone the repository:

```bash
git clone https://github.com/Delthoid/payroll_app_opr_test.git
cd payroll_app_opr_test
```

Install dependencies:

```bash
flutter pub get
```

### Running the App

To run on Android:

```bash
flutter run
```

To run on iOS (macOS only):

```bash
flutter run
```

---

## Project Structure

```
lib/
 ├── core/           # Shared utilities, DI setup, base classes
 ├── data/           # Data sources, models, services (e.g., SessionService)
 ├── domain/         # Entities, repositories, use cases
 ├── presentation/   # UI, pages, widgets, bloc/cubit files
 ├── router/         # Route definitions using go_router
 └── main.dart       # App entry, DI setup, MultiBlocProvider
```

---

## Architecture & Patterns

### Clean Architecture

- **Presentation Layer:** UI widgets and pages use `BlocBuilder`, `BlocConsumer`, or `Cubit` for state management.
- **Domain Layer:** Business logic, use cases, and entities.
- **Data Layer:** Handles data sources and models.
- **Core Layer:** Shared dependencies, utility classes, DI setup.

### Dependency Injection

- Initial setup in `main.dart` via `setup()`.
- Dependencies registered with `get_it`.
- Blocs and services are resolved from DI container.

### State Management

- All user-facing features (employees, logs, payroll periods, authentication) use `Bloc` or `Cubit` for state control.
- Example: `EmployeesBloc`, `EmployeeBloc`, `AuthBloc`, etc.

### Navigation and Nested Routes

Routing is handled by `go_router` with both top-level and nested routes for feature flows.  
**Examples of routes:**

- **Employee Flow:**
  - `/home/employeeDetails/:id` → Employee Details
  - `/home/employeeDetails/:id/employeeEdit/:employeeId` → Edit Employee
  - `/home/employeeCreate` → Add New Employee

- **Employee Logs Flow:**
  - `/home/employeeLogs` → Employee Logs Page
  - `/home/employeeLogs/createLog` → Create Log
  - `/home/employeeLogs/viewLog` → View Log
  - `/home/employeeLogs/viewLog/updateLog` → Update Log

- **Payroll Period Flow:**
  - `/home/addPayrollPeriod` → Add Payroll Period
  - `/home/editPayrollPeriod` → Edit Payroll Period

**Authentication:**
- `/login` → Login/Authentication Page
- `/` → Redirects to AuthPage
- Automatic redirect logic based on session state

**Route Protection:**
- All routes under `/home` require authentication
- Unauthenticated users are redirected to `/login`
- Authenticated users accessing `/login` are redirected to `/home`

---

## Relevant Notes

- Code follows clean separation for scalability and testability.
- All business logic is separated from UI.
- DI makes it easy to swap implementations (e.g., for testing).
- UI updates reactively based on bloc/cubit state.
- **Note:** This project does not contain automated tests yet.

---

## Contact

For questions or feedback, contact [Delthoid](https://github.com/Delthoid).