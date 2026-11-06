# 🌟 GlowHub - Salon Booking & Management Ecosystem

**GlowHub** is a comprehensive, cross-platform mobile ecosystem built with Flutter, designed to seamlessly connect beauty salon clients with professional salon service providers and administrators.

---

## 📱 App Demo Previews

### 👤 Admin Side

https://github.com/user-attachments/assets/260e3c45-5c91-4d7b-8bd8-56ec6014a113

### 🛠️ Client Side

https://github.com/user-attachments/assets/e98ca34e-e22e-44a1-a860-5559e889243e




---

## 🚀 Key Features

### 👤 For Clients:
* **Interactive Service Selection:** Choose between Home-service or In-salon appointments seamlessly.
* **Smart Booking Flow:** Browse top-rated salons, filter services, and manage upcoming bookings.
* **User Profile & History:** Track active appointments and view past history with clean status indicators.

### 🛠️ For Admins & Salon Owners:
* **Real-time Dashboard:** Live statistics tracking Total, Confirmed, Completed, and Cancelled appointments for the day.
* **Status Management:** Instantly update booking states with reactive UI synchronization.
* **Clean Architecture:** Modular separation of concerns ensuring robust scalability and high performance.

---

## 🛠️ Tech Stack & Architecture

* **Framework:** Flutter (Cross-platform mobile development)
* **State Management:** Flutter Bloc / Cubit (Reactive & Predictable state handling)
* **Backend & Database:** Firebase Cloud Firestore & Firebase Authentication
* **Architecture:** Feature-First Clean Architecture (Presentation, Domain, and Data layers)
* **UI/UX Tooling:** Flutter ScreenUtil for responsive scaling across all screen sizes.

---

## 📂 Project Structure

```text
lib/
│
├── core/                  # Theme, constants, network, and firebase helpers
├── features/
│   ├── appointments/      # Shared booking models, repositories, and cubits
│   ├── home/              # User & Admin home dashboard sections
│   └── auth/              # Authentication modules
│
└── main.dart
