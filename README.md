# Rick and Morty Character App

A Flutter application that displays characters from the Rick and Morty API with offline support, favorites, and infinite scroll pagination.


---

## Setup Instructions

### Prerequisites
- Flutter SDK: `>=3.0.0`
- Dart SDK: `>=3.0.0`
- Android Studio / VS Code
- A device or emulator

### Steps

**1. Clone the repository**
```bash
git clone https://github.com/your-username/pridesys_task.git
cd pridesys_task
```

**2. Install dependencies**
```bash
flutter pub get
```

**3. Generate Hive adapters**
```bash
dart run build_runner build --delete-conflicting-outputs
```

**4. Run the app**
```bash
flutter run
```

---

## State Management — Provider

This project uses the **Provider** package for state management.

**Why Provider?**

| Reason | Detail |
|--------|--------|
| Simplicity | Easy to understand for small-to-medium apps |
| Official support | Recommended by the Flutter team |
| Less boilerplate | No need for events, states, blocs |
| ChangeNotifier | Straightforward — call `notifyListeners()` and UI updates |

Alternatives like **Bloc** or **Riverpod** are more powerful but add unnecessary complexity for a task of this scale. Provider keeps the code readable and maintainable.

---

## 💾 Storage Approach — Hive

This project uses **Hive** for local/offline storage.

**Why Hive?**

| Reason | Detail |
|--------|--------|
| Fast | Key-value NoSQL, no SQL parsing overhead |
| Flutter-native | Pure Dart, no native dependencies |
| Type-safe | Stores typed objects using generated adapters |
| Offline-first | Data persists across app restarts |



## 🎥 App Walkthrough Video

> 📹 [Watch on YouTube](https://youtube.com/your-link-here)

**Video covers:**
- App overview and UI walkthrough
- Infinite scroll pagination in action
- Offline mode demonstration
- Favorite feature
- search Filter
- Code explanation (Provider + Hive)



