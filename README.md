# 🦾 Physical Therapy Assistant App

A Flutter-powered mobile application for physical therapy sessions using MQTT-based robotics and Firebase integration. 
Designed for real-time monitoring, exercise control, and seamless patient session management.

---

## ✨ Features

- 🔒 **Secure Login System** with Firebase Authentication
- 📡 **Real-time Robot Communication** via MQTT (HiveMQ broker)
- 🧠 **Persistent Login & Session Timeout** logic
- ⚙️ **Session Customization** for different joints and exercises
- 📊 **Reports & History View**
- 💬 **Live MQTT Connection Status**
- 📲 **Manual Robot Control Interface**
- 👩‍⚕️ **Patient Management Tools**

---

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/physical-therapy-app.git
cd physical-therapy-app
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Set Up Firebase

- Create a Firebase project.
- Add your `google-services.json` (Android) or `GoogleService-Info.plist` (iOS).
- Enable **Email/Password Authentication** in Firebase Console.
- Set up **Firestore** or **Realtime Database** depending on your backend model.
- Optional: Enable **Firebase Storage** if media files will be involved.

### 4. Update MQTT Credentials

In `mqtt_service.dart`, configure:

```dart
String broker = 'broker.hivemq.com';
int port = 1883;
String currentTopic = 'MovTest';
```

---

## 🧩 Folder Structure

```bash
lib/
├── Services/
│   ├── FirebaseServices.dart
│   └── mqtt_service.dart
├── StartSession/
│   ├── AnklePage.dart
│   ├── KneePage.dart
│   └── ...
├── ViewReports/
│   ├── ViewReportsPage.dart
│   └── RealTimeMonitoringPage.dart
├── ManualControl/
│   └── ManualControlPage.dart
├── Tools/
│   └── MyColors.dart
├── WelcomePage.dart
└── OptionsPage.dart
```

---

## 🔐 Session Management

- User login timestamp is stored using `SharedPreferences`
- Session expires after predetrmined days, triggering auto logout on app start
- Users can also logout manually via the top-right app bar

---

## 🛠️ Dependencies Used

- [`firebase_auth`](https://pub.dev/packages/firebase_auth)
- [`cloud_firestore`](https://pub.dev/packages/cloud_firestore)
- [`mqtt_client`](https://pub.dev/packages/mqtt_client)
- [`provider`](https://pub.dev/packages/provider)
- [`shared_preferences`](https://pub.dev/packages/shared_preferences)
- [`get_it`](https://pub.dev/packages/get_it)
