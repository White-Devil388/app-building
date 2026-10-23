# DriveLux - Luxury Car Rental & Hosting Flutter App

DriveLux React Web App ka complete Android Flutter version.

---

## 📱 Features Included
1. **Fleet Browsing & Search**:
   - Live search by car brand/model.
   - Body type filter (SUV, Sedan, Luxury, Sports).
   - Sort by Popularity, Price (Low to High, High to Low), Top Rating.
2. **Car Details & Specs**:
   - Image carousel / slider with page indicators.
   - Specs badges (Power, Engine, Seating, Transmission, Mileage, Deposit).
   - Instant booking CTA and Host info.
3. **Complete Reservation & Checkout**:
   - Date range picker (calculates dynamic total days).
   - Pickup & Drop-off Hubs selection.
   - Add-on extras (FASTag, Zero-dep insurance, Chauffeur, Child seat).
   - Promo coupon engine (`WELCOME10`, `LUXURY20`, `WEEKEND15`).
   - Driver KYC verification details.
   - Payment method selection (UPI, Credit Card, NetBanking).
   - Dynamic price breakdown with 18% GST.
4. **Booking Confirmation**:
   - Boarding pass / Luxury ticket style receipt.
   - Booking reference ID generation.
5. **My Bookings & Saved (Favorites)**:
   - Full history of bookings.
   - Heart bookmark toggle on any car.
6. **User Roles & Account Management**:
   - One-tap switch between **Customer**, **Fleet Host**, and **Admin**.
   - Host Car form: List new luxury vehicles directly to the fleet.

---

## 🚀 Kaise Run Karein (Step-by-Step Guide)

### 1. Flutter SDK Install Karein
Agar aapke PC par Flutter install nahi hai:
1. [Flutter Official Website](https://docs.flutter.dev/get-started/install/windows) se Flutter SDK zip download karein.
2. Extract karke PATH environment variable me add karein (e.g. `C:\flutter\bin`).
3. Terminal me check karein:
   ```bash
   flutter doctor
   ```

### 2. Android Phone ya Emulator Connect Karein
- **Real Android Phone**: Settings > Developer Options on karein > USB Debugging on karein aur USB cable se PC me connect karein.
- **Android Emulator**: Android Studio me Device Manager open karke ek virtual device start karein.

### 3. Dependencies Install & App Run Karein
`flutter_app` folder ke andar terminal open karein:
```bash
cd flutter_app
flutter pub get
flutter run
```

### 4. Release APK Kaise Banayein (Installable Android APK)
Apne phone me bina PC ke install karne ke liye APK generate karein:
```bash
flutter build apk --release
```
Aapka ready APK yahan mil jayega:
`flutter_app/build/app/outputs/flutter-apk/app-release.apk`
Isko direct apne Android phone me send karke install kar sakte hain!
