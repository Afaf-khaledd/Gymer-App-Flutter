# 💪 Gymer

**Gymer** is a Flutter-based fitness and workout tracker app designed to help users build consistent workout routines, track progress, and stay motivated. It offers a clean UI, personalized fitness levels, profile editing, daily checklists, and more — all built with modern architecture using **Cubit** and **MVVM**.

---

## 🚀 Features

- 🏋️‍♂️ Personalized Workout based on Questionnaire
- 🗓️ Daily Workouts Checklist & Progress Tracking with Charts
- 🧠 Chat with Chatbot to get workout suggestions and advices
- ✏️ Edit Profile (with Image Upload & Edit Questionnaire Data)
- 🔐 Authentication Flow (Login, Register, Forgot Password)
- 📊 Progress Tracking with Daily Checklist & Charts
- 🔔 Workout Reminders (planned)

---

## 🛠️ Tech Stack

- **Flutter**
- **Dart**
- **Cubit** for state management
- **MVVM** architecture
- **Repository Pattern**
- **SharedPreferences** for local storage (Remember Me & Checklist)
- **FlutterSecureStorage** (Token)
- **Dio** for API handling
- **get_it** for dependency injection

---

## 📁 Project Structure
lib/
│
├── core/ # Core utilities (helpers, utils, components)
├── features/ # App features (analysis, auth, chatbot, favorite, home, machine recognition, questionnaire)
│ ├── analysis/ #charts and progress tracking
│ │ ├── data/
│ │ │ ├── models/
│ │ │ └── repository/
│ │ └── presentation/
│ │   ├── views/
│ │   └── view model/
│ ├── chatbot/ # ai chatbot
│ │ ├── data/
│ │ │ ├── models/
│ │ │ └── repository/
│ │ └── presentation/
│ │   ├── views/
│ │   └── view model/
│ ├── favorite/
│ │ ├── data/
│ │ │ ├── models/
│ │ │ └── repository/
│ │ └── presentation/
│ │   ├── views/
│ │   └── view model/
│ ├── home/ 
│ │ ├── data/
│ │ │ ├── models/
│ │ │ └── repository/
│ │ └── presentation/
│ │   ├── views/
│ │   └── view model/
│ ├── machine_recognition/
│ │ ├── data/
│ │ │ ├── models/
│ │ │ └── repository/
│ │ └── presentation/
│ │   ├── views/
│ │   └── view model/
│ ├── questionnaire/
│ │ ├── data/
│ │ │ ├── models/
│ │ │ └── repository/
│ │ └── presentation/
│ │   ├── views/
│ │   └── view model/
│ └── auth/
│ │ ├── data/
│ │ │ ├── models/
│ │ │ └── repository/
│ │ └── presentation/
│ │   ├── views/
│ │   └── view model/
│
├── main.dart # App entry point

## How to Run

1. Clone the repository and navigate to the project directory.
2. Run `flutter pub get` to fetch dependencies.
3. Go to the `lib/core/apiService.dart` file and update the `baseUrl` variable by your ip address.
4. Run Backend, Chatbot and Machine Recognition model on your local machine.
5. Run `flutter run` to start the app on your local device.

## 🙌 Credits

_**Built with ❤️ by Afaf Khaled & Ali Nader**_