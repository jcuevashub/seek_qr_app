# **📱 Seek QR App**  
🚀 A Flutter application for **QR code scanning and biometric authentication**, using a modular architecture with native integrations via **Pigeon**.  

## **📖 Overview**  
Seek QR App is a modular Flutter application that features:  
✔️ **Native QR code scanning** using platform-specific implementations via **Pigeon**.  
✔️ **Biometric authentication** (Face ID / Fingerprint) with native code.  
✔️ **Modular architecture** with BLoC and reusable packages.  

## **📂 Project Structure**  
```
seek_qr_app/
┣ 📂 apps/
┃ ┗ 📂 flutter_app/         # Main Flutter application
┣ 📂 native_plugins/
┃ ┣ 📂 qr_scanner/          # Native QR scanner implementation with Pigeon
┃ ┗ 📂 auth_biometrics/     # Native biometric authentication implementation with Pigeon
┣ 📂 packages/
┃ ┣ 📂 app_common/          # Shared utilities (helpers, models, etc.)
┃ ┣ 📂 qr_scanner/          # QR scanner implementation with Clean Achitecture and Bloc
┃ ┗ 📂 auth_biometrics/     # Biometric authentication implementation Clean Achitecture and Bloc
┣ 📜 melos.yaml             # Monorepo configuration
┣ 📜 pubspec.yaml           # Global dependencies
┗ 📜 README.md              # Project description
```

## **🛠 Installation & Setup**  

### **1️⃣ Clone the Repository**  
```sh
git clone https://github.com/jcuevas/seek_qr_app.git
cd seek_qr_app
```

### **2️⃣ Install Dependencies with Melos**  
Ensure you have **Melos** installed:  
```sh
dart pub global activate melos
```
Then bootstrap dependencies:  
```sh
melos bootstrap
```

### **3️⃣ Run the Application**  
```sh
cd apps/flutter_app
flutter run
```

## **🎯 Features**  
✅ **Native QR Scanning** with platform-specific code via **Pigeon**.  
✅ **Biometric Authentication** using native **Face ID / Fingerprint**.  
✅ **State Management** with BLoC.  
✅ **Persistent QR history** using Hive.  
✅ **Monorepo architecture** for modularity.  

## **🧪 Running Tests**  
Execute unit tests with:  
```sh
melos run test
```

## **📜 License**  
MIT License - [YourRepository](https://github.com/jcuevashub/seek_qr_app.git)  

