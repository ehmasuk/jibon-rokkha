# Jibon Rokkha (জীবন রক্ষা) 🚑

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Firebase](https://img.shields.io/badge/firebase-%23039BE5.svg?style=for-the-badge&logo=firebase)](https://firebase.google.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

**Jibon Rokkha** (meaning "Life Saver" in Bengali) is a premium, comprehensive mobile and web application designed for rapid response during medical emergencies. It provides accessible first-aid guidance, emergency alerting, and professional report generation, ensuring help is always one tap away.

---

## ✨ Key Features

- 🆘 **Panic Mode**: A high-stress interface designed for one-tap emergency triggers when every second counts.
- 📚 **First Aid Repository**: Offline-capable database of step-by-step instructions for common medical emergencies (Cardiac Arrest, Burns, Choking, etc.).
- 📞 **Emergency Contact System**: Integrated system dialers for immediate connection to emergency services.
- 🔖 **Sonrokkhito (Saved)**: A local bookmarking system to keep critical guides accessible even without an internet connection.
- 📄 **Professional Reports**: Generate and export activity logs as structured PDF files with full Bengali script support.
- 🌐 **Cross-Platform**: Seamless experience across Android, iOS, and Web layouts.

---

## 🛠️ Technology Stack

| Layer | Technology |
|---|---|
| **Framework** | [Flutter](https://flutter.dev/) (v3.x) |
| **Language** | [Dart](https://dart.dev/) |
| **State Management** | [Riverpod](https://riverpod.dev/) |
| **Local Database** | [Hive](https://docs.hivedb.dev/) |
| **Cloud Database** | [Cloud Firestore](https://firebase.google.com/docs/firestore) |
| **Backend** | [Firebase Core](https://firebase.google.com/docs/core) |

---

## 📂 Project Architecture

The project follows a **Feature-Driven Architecture**, ensuring scalability and maintainability:

```text
lib/
├── core/               # Global themes, constants, and utilities
├── features/           # Modularized app features (Home, Aid, Emergency)
│   ├── presentation/   # UI components and screen layouts
│   └── providers/      # Business logic and state management
├── models/             # Shared data structures
└── main.dart           # Application entry point
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.1.0)
- Dart SDK
- A Firebase project (for cloud features)

### Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/yourusername/jibon_rokkha.git
    cd jibon_rokkha
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Setup Firebase:**
    - Place your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) in the respective directories.
    - Run `flutterfire configure` if you have the CLI installed.

4.  **Run the application:**
    ```bash
    flutter run
    ```

---

## 📸 Screenshots

> [!TIP]
> Add screenshots of the Home Screen, First Aid Guide, and PDF Reports here to showcase the UI.

| Home Screen | First Aid Guide |
|:---:|:---:|
| <img width="622" height="906" alt="image" src="https://github.com/user-attachments/assets/895133e6-71a5-47bc-8849-4119eb653e5d" />
 | <img width="619" height="896" alt="image" src="https://github.com/user-attachments/assets/30fdfeba-8f10-4f56-b5bd-3f1f1de2bff6" />
 |

---

## 🤝 Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.

---

## 📞 Support

If you have any questions or feedback, please reach out via the [Issue Tracker](https://github.com/yourusername/jibon_rokkha/issues).

Developed with ❤️ for the community.
