# 🍔 StreetBite - Street Food Discovery & Ordering App

**StreetBite** is a cross-platform mobile application designed to connect street food vendors with hungry customers, enabling seamless discovery, real-time map tracking, and food ordering. Developed as a Capstone project using Flutter and Clean Architecture.

---

## 🚀 Features
* **User Authentication:** Secure Sign-up and Login powered by Firebase Authentication.
* **Vendor Discovery & Map Integration:** Interactive Google Maps displaying nearby street food vendors.
* **Menu & Cart Management:** Browse vendor menus, customize orders, and manage the shopping cart.
* **State Management:** Robust and scalable state management using `Flutter BLoC / Cubit`.
* **Local Storage & Security:** Data persistence using `SharedPreferences` and device security integration.

---

## 🛠️ Tech Stack & Architecture
* **Framework:** Flutter (Dart)
* **Architecture:** Clean Architecture (Presentation, Domain, Data Layers)
* **State Management:** `flutter_bloc`
* **Backend & Database:** Firebase (Auth, Cloud Firestore)
* **APIs & Packages:** Google Maps Flutter, Geolocator, Image Picker, Shared Preferences.

---

## 📂 Project Structure
```text
lib/
│
├── core/                  # Core utilities, constants, and themes
├── data/                  # Data layer (Models, Repositories, Data Sources)
├── domain/                # Domain layer (Entities, Use Cases, Repository contracts)
└── presentation/          # Presentation layer (Screens, Widgets, BLoCs/Cubits)