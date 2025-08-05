# 🌤️ Floward Task – Flutter + iOS Native Integration

This project showcases integration between a **Flutter app** and a **native iOS view**, along with weather data fetching and custom communication using `MethodChannel` and `PlatformView`.

📺 **[Watch the demo video here](https://drive.google.com/file/d/1xKUNsxeVELPVd4VEKRT4fE0OsXlZGfpw/view?usp=share_link)**

---

## 📱 How the App Works

1. **Initial Launch**  
   When the app launches, it opens the **Dashboard** tab by default. This screen shows the current weather in **Cairo**, fetched live from the Weather API.

2. **Viewing Weather Info**  
   The weather screen displays:
   - City name
   - Weather condition 
   - Temperature in °C
   - A weather icon
   - A **Send Feedback** button

3. **Sending Feedback to Native**  
   - Tapping the **Send Feedback** button opens a dialog where the user can enter a message.
   - When submitted, the message is sent via `MethodChannel` to the iOS native side.
   - The native screen then displays the feedback in an alert.

4. **Switching to Native Profile View**  
   - Navigating to the **Profile** tab opens the native iOS view.
   - The screen displays:
     - User profile picture
     - Name and email
     - A **Send user data to dashboard** button

5. **Sending Data to Flutter**  
   - When the user taps the button, native sends the user data (name, email, image) to Flutter via `MethodChannel`.
   - Flutter updates the Dashboard UI to display this user info.
   - A confirmation snackbar is shown to indicate successful data transfer.
   - The native button becomes hidden after sending the data once.

---

## 📁 Project Structure

```
lib/
├── features/
│   ├── layout/                    # Main layout and navigation
│   ├── user_profile/             # User native view and cubit logic
│   └── weather/                  # Weather feature implementation
│       ├── data/                 # Datasources, models, repositories
│       ├── domain/               # Entities, use cases
│       ├── presentation/         # BLoC, screens, widgets
├── src/
│   ├── api/                      # API services and endpoints
│   ├── cubit/                    # Custom reusable cubits
│   ├── errors/                   # App-wide exception and failure classes
│   ├── platform/                 # MethodChannel-based native service
│   ├── usecases/                # Shared base usecase
│   ├── routes_manager.dart      # Centralized route generation
│   ├── service_locator.dart     # DI container setup with GetIt
│   └── app.dart                 # Root MaterialApp setup
```

### Native iOS (`ios/Runner`)
- `AppDelegate.swift` – Initializes the `FlutterEngine`, registers plugins, and sets the root controller.
- `MethodChannelManager.swift` – Handles feedback + user data via `FlutterMethodChannel`.
- `ProfileNativeView.swift` – Custom native `UIView` used in integration.
- `ProfileView.swift` – SwiftUI View to display user information.
- `ProfileViewFactory.swift` – Factory that registers the view for Flutter using `UiKitView`.

---

## 📲 Native Module Integration

- A **custom native iOS view** (`ProfileView`) is displayed within Flutter using `UiKitView`.
- `MethodChannel` is used for bidirectional communication between Flutter and iOS.
  - **From Native to Flutter:** Sends user data (name, email, image).
  - **From Flutter to Native:** Sends feedback messages from a Flutter dialog.

### Setup Summary:

1. `AppDelegate.swift` creates and configures the `FlutterEngine`.
2. `MethodChannelManager.configure()` registers the `MethodChannel` with handlers for:
   - `sendFeedback`
   - `userData`
3. In Flutter, `NativeService.sendFeedbackToNative()` invokes native method `sendFeedback`.
4. The iOS native view is exposed to Flutter with:
   ```dart
   const UiKitView(
     viewType: 'profile-view',
     creationParams: {},
     creationParamsCodec: StandardMessageCodec(),
   );
   ```

---

## 🌦️ Weather Data Flow

The weather feature follows **clean architecture** using the following layers:

```
UI (Flutter Widgets)
  ↓
Bloc (WeatherBloc)
  ↓
Use Case (GetWeatherConditionUsecase)
  ↓
Repository (WeatherRepositoryImpl)
  ↓
Datasource (WeatherRemoteDatasource)
  ↓
API (WeatherAPI via DioConsumer)
```

- Weather data is fetched from [weatherapi.com](https://www.weatherapi.com/).
- Uses `Dio` for network requests, and responses are mapped from model → entity for decoupling.

---

## ✅ Getting Started

### Prerequisites:
- Flutter SDK
- Xcode (for iOS build)
- CocoaPods (for iOS plugin installation)

### Steps:
1. Clone the repository:
   ```bash
   git clone https://github.com/YussifKahilo/floward_task
   cd floward_task
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   cd ios
   pod install
   cd ..
   ```

3. Run on iOS Simulator:
   ```bash
   flutter run
   ```

---

## 📧 Author

**Yussif Kahilo** – [yusufkahilo@icloud.com](mailto:yusufkahilo@icloud.com)

---
