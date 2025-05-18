# Project Initialization steps:
📥 Clone the Repository `git clone https://github.com/maniraj1234/zuggled`
change directory: `cd zuggled`
📦 Install Dependencies: `flutter pub get`
▶️ Run the App

--->Make sure a device/emulator is connected:
    flutter devices

---> To open Emulators:
    In MAC: cmd + shift + p : Flutter Emulators : choose the emulator

--->Then run the app:
    flutter run 

--->Use this command to run this on firebase studio:
    flutter run --no-enable-impeller

 ## Running on Local Devices (Mobile Phones)
 ### Windows (Android Devices)
1. Enable Developer Mode:
   * On your phone: `Settings > About phone > Tap Build number 7 times`
   * Then go to `Settings > Developer options` and enable USB debugging
2. Connect your Android device via USB** to your PC
   Approve the prompt on your phone for USB debugging.
3. Run:
   flutter devices
   flutter run


## macOS (Android & iOS Devices)
 ### Connect Android Device to macOS
1. Enable Developer Mode on Android:
   `Settings > About phone > Tap Build number`, then enable USB debugging
2. Install Android File Transfer(optional):
   Helps macOS recognize Android devices. Download from:
   [https://www.android.com/filetransfer/](https://www.android.com/filetransfer/)
3. Install Android Platform Tools: `brew install android-platform-tools`
4. Connect the Android device via USB
5. Allow USB debugging prompt on your device
6. Verify connection: `flutter devices`
7. Run the app: `flutter run`

> ✅ Make sure your `adb` (Android Debug Bridge) works: `adb devices`

 Connect iOS Device to macOS
1. Install Xcode from App Store
2. Enable Developer Mode:
   iOS 16+: `Settings > Privacy & Security > Developer Mode` → Enable and reboot
3. Connect via USB and trust the Mac
4. Accept signing and provisioning permissions
5. Verify: `flutter devices`
6. Run: `flutter run`





🧪 Run Tests (Optional)
flutter test
