# flutter_firebease_login

## Getting Started

This project is a starting point for a Flutter application.

Package used in this app.

```
firebase_core: ^1.13.1
firebase_auth: ^3.3.10
cloud_firestore: ^3.1.10
fluttertoast: ^7.1.6
keyboard_dismisser: ^2.0.1
```

First You have to clone this repo.

```
git clone https://github.com/kewal28/flutter_firebease_login.git
```

To get Package from run below command

```
flutter pub get
```

We have to update android minSdkVersion.

```
│ flutter_firebease_login/android/app/build.gradle:       │
│ android {                                                                                     │
│   defaultConfig {                                                                             │
│     minSdkVersion 21                                                                          │
│   }                                                                                           │
│ } 
```

Directory 
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

Where to fin
google()  // Google's Maven repository

classpath 'com.google.gms:google-services:4.3.10'

apply plugin: 'com.google.gms.google-services'