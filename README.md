<<<<<<< HEAD
📱 Project Overview – ManageMe App
ManageMe is a Flutter-based user management app developed as part of a Flutter Developer assessment task. The app leverages the flutter_bloc state management pattern and integrates with the DummyJSON REST API to fetch and manage users, their posts, and todos.

This project emphasizes clean architecture, structured BLoC state management, and real-time API interaction with features like:

✅ Infinite scrolling with pagination

🔍 Live user search functionality

📋 Display of user-specific posts and todos

📝 Local post creation (title + body)

⚙️ Organized, scalable, and modular codebase

It offers a modern and responsive UI (designed with Visily) and showcases professional development practices suitable for real-world Flutter applications.


⚙️ Setup Instructions

Prerequisites

- **Flutter SDK** installed on your machine (check by running `flutter --version`)  
- IDE like **Android Studio** or **VS Code** with Flutter plugins  
- Connected physical device or emulator/simulator running

---

Step 1: Clone the Repository

bash
```git clone https://github.com/Mohd063/manage_me.git```
cd manage_me



## 🏗️ Architecture Explanation

This app follows a **Clean and Modular Architecture** pattern, primarily using the **BLoC (Business Logic Component)** state management approach for clear separation of concerns and maintainability.

### Folder Structure Overview

lib/
├── data/ # Handles data sources such as API calls and models
│ ├── models/ # Data models representing users, posts, todos
│ └── repository/ # API service classes to fetch data from DummyJSON
│
├── logic/ # BLoC files managing state and business logic
│ ├── bloc/ # UserBloc, PostBloc, TodoBloc, etc.
│ └── events/ # Bloc event definitions (fetch, search, paginate)
│ └── states/ # Bloc state definitions (loading, success, error)
│
├── presentation/ # UI layer containing screens and widgets
│ ├── screens/ # UserListScreen, UserDetailScreen, CreatePostScreen
│ └── widgets/ # Reusable widgets like user cards, loaders
│
├── themes/ # Theme data for light and dark modes
│
└── main.dart # App entry point and initial setup

markdown
Copy
Edit

### Data Flow

1. **UI Layer (presentation/):**  
   - Displays data and listens for user interaction.  
   - Sends events to BLoC layer.

2. **Logic Layer (logic/):**  
   - Receives events, processes business logic.  
   - Interacts with Data layer for fetching/updating data.  
   - Emits states back to UI.

3. **Data Layer (data/):**  
   - Handles API requests to DummyJSON.  
   - Converts raw data into model objects.  
   - Provides data to BLoC on demand.

---

### Benefits of this Architecture

- **Separation of Concerns:** UI, business logic, and data fetching are decoupled.  
- **Scalability:** Easy to add features without affecting other layers.  
- **Testability:** Logic can be unit tested separately from UI.  
- **Maintainability:** Clean folder structure keeps code organized.

- video 
## 🎬 Demo Video

👉 [Click here to watch demo video](assets/screen_shot_and_video/manageme.mp4)

## 🖼️ App Screenshots

### 1. Splash Screen
![Splash Screen](assets/screen_shot_and_video/Screenshot_20250604_123512.jpg)

### 2. User List - Light Mode
![User List Light](assets/screen_shot_and_video/Screenshot_20250604_123310.jpg)

### 3. User List - Dark Mode
![User List Dark](assets/screen_shot_and_video/Screenshot_20250604_123403.jpg)

### 4. User Detail - Light Mode
![User Detail Light](assets/screen_shot_and_video/Screenshot_20250604_123338.jpg)

### 5. User Detail - Dark Mode
![User Detail Dark](assets/screen_shot_and_video/Screenshot_20250604_123418.jpg)

### 6. Add Post - Light Mode
![Add Post Light](assets/screen_shot_and_video/Screenshot_20250604_123356.jpg)

### 7. Add Post - Dark Mode
![Add Post Dark](assets/screen_shot_and_video/Screenshot_20250604_123432.jpg)

### 8. No Internet - Light Mode
![No Internet Light](assets/screen_shot_and_video/Screenshot_20250604_123444.jpg)

### 9. No Internet - Dark Mode
![No Internet Dark](assets/screen_shot_and_video/Screenshot_20250604_123456.jpg)


=======
<<<<<<< HEAD
# user_management
=======
# manage_me

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
>>>>>>> 723b517 (Add local project files)
>>>>>>> 0f5c2f9 (Initial commit)
