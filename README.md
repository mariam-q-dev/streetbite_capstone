# 🍔 StreetBite V1.0 - Food Discovery & Ordering App

**StreetBite V1.0** is a production-oriented cross-platform mobile application designed to connect street food vendors with hungry customers. Built as a Capstone graduation project using Flutter, Firebase, and Clean Architecture.

---

## 📱 Project Overview & Features
* **Bilingual Support:** Full localization for English (`en`) and Arabic (`ar`) with runtime language toggling.
* **Authentication & Profiles:** Secure email/password authentication via Firebase Auth, persistent states, and biometric fingerprint login option.
* **Live Menu & Dio Integration:** Fetching meals dynamically from TheMealDB API, supporting caching via `SharedPreferences`, and state management using `flutter_bloc` / `Cubit`.
* **Vendor Discovery Map:** Interactive Google Maps integrated with `google_maps_flutter` displaying nearby hardcoded vendors with custom info windows.
* **Cart & Checkout:** Solid implementation of payment handling (Cash/Card options sharing a common interface adhering to SOLID principles), reactive cart updates, and storing orders directly to Cloud Firestore.

---

## 🛠️ Architecture & Tech Stack
* **Architecture:** Clean Architecture (`Data`, `Domain`, `Presentation` layers) ensuring separation of concerns and testable components.
* **Design Patterns:** Builder Pattern (User model), Factory Pattern (MealRepository data source selection), and Singleton Pattern (Firestore service).
* **Core Technologies:**
  * **Framework:** Flutter & Dart
  * **State Management:** `flutter_bloc`, `equatable`, `get_it` (Dependency Injection)
  * **Backend & Database:** Firebase Authentication, Cloud Firestore
  * **APIs & Utilities:** `Dio`, `google_maps_flutter`, `image_picker`, `local_auth`, `device_info_plus`

---

## 📂 Expected Repository Structure
```text
streetbite-capstone/
├── flutter_app/
│   ├── lib/
│   │   ├── main.dart
│   │   ├── injection.dart
│   │   ├── core/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   ├── presentation/
│   │   │   ├── blocs/
│   │   │   ├── screens/
│   │   │   └── widgets/
│   │   └── l10n/
│   │       ├── app_en.arb
│   │       └── app_ar.arb
│   ├── pubspec.yaml
│   └── README.md