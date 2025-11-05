# Amazon-App

A cross-platform Flutter application (Android | iOS | Web) inspired by Amazon.  
Built using Flutter & Dart.

## 🎯 Project Overview

This project demonstrates a full-featured e-commerce style mobile/web app, with separate modules for sellers and buyers. Users can browse products, manage carts, sellers can view admin portal features, and everything is built with modern Flutter architecture.

## 🧩 Key Features

- Multi-platform support: Android, iOS & Web
- Buyer module: product listing, search, cart, checkout
- Seller/admin portal: product management, sales overview
- Integration of REST APIs (or Firebase backend) for data handling
- State management using Cubit/Bloc (or any architecture implemented)
- Local persistence for offline features (Hive / SQFLite if used)
- Responsive UI adapts to mobile & web
- Clean and modular folder structure for scalability

## 🚀 Tech Stack

- **Flutter** (Dart) — UI & business logic
- State management: **Cubit / Bloc**
- Backend / Data service: REST API or Firebase
- Persistence: Hive / SQFLite (local storage)
- Version control: Git / GitHub
- Responsive layout & web support

## 📂 Project Structure

<ul>
<li>/amazonclone — Buyer / main application</li>
<li>/sellers_app — Seller portal module</li>
<li>/admin_web_portal — Web admin portal</li>
<li>lib/ — Flutter modules & shared code</li>
<li>assets/ — Images, icons, fonts</li>
</ul>

## 🧪 Getting Started

1. Clone the repository
   ```bash
   git clone https://github.com/Marwansalem122/Amazon-App.git
   cd Amazon-App
   ```
2. Install dependencies

```bash
  flutter pub get
```

3. Run the app

```bash
  flutter run
```

Or choose target platform: -d chrome, -d android, -d ios
