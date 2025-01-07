# Flutter Firebease Login

In this app we will create login, signup and forget password using firebase flutter project.

Flutter Version: 3.5.4

## Getting Started

This project is a starting point for a Flutter application.

## Package used in this app.

```
firebase_core: ^1.13.1
firebase_auth: ^3.3.10
cloud_firestore: ^3.1.10
fluttertoast: ^8.2.10
keyboard_dismisser: ^2.0.1
image_picker: ^0.8.4+11
firebase_storage: ^10.2.9
```

## First You have to clone this repo.

```
git clone https://github.com/kewal28/flutter_firebease_login.git
```

## To get Package from run below command

```
flutter pub get
```

## We have to update android minSdkVersion.

```
│ flutter_firebease_login/android/app/build.gradle:                                             │
│ android {                                                                                     │
│   defaultConfig {                                                                             │
│     minSdkVersion 21                                                                          │
│   }                                                                                           │
│ } 
```

## Directory structure

```
lib
├── Models
│   └── user.dart
├── Screens
│   ├── Privacy.dart
│   ├── after_login_page.dart
│   ├── forget_password.dart
│   ├── landing.dart
│   ├── login.dart
│   └── signup.dart
├── Services
│   └── user.dart
├── Widgets
├── config.dart
├── generated_plugin_registrant.dart
├── main.dart
├── screen-shot
│   ├── 1.jpeg
│   └── 2.jpeg
└── utils.dart
```

## How to create firebase project.

Follow the steps below. Open the Firebase console.

Click "Add Project".

## Where to find aplication key this will need when we create firebase application.

```
Path :- android/app/build.gradle
```

Follow on screen instructions.

