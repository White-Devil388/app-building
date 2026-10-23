import 'package:flutter/material.dart';
import '../models/booking_model.dart';
import '../models/car_model.dart';
import '../data/app_data.dart';

class BookingProvider extends ChangeNotifier {
  final List<Booking> _bookings = [];

  // Draft Booking State
  Car? _selectedCar;
  String _pickupLocation = AppData.locations.first;
  String _dropLocation = AppData.locations.first;
  DateTime _startDate = DateTime.now().add(const Duration(days: 1));
  DateTime _endDate = DateTime.now().add(const Duration(days: 3));
  final List<BookingItemExtra> _selectedExtras = [];
  String? _couponCode;
  double _discountPercent = 0.0;

  List<Booking> get bookings => _bookings;
  Car? get selectedCar => _selectedCar;
  String get pickupLocation => _pickupLocation;
  String get dropLocation => _dropLocation;
  DateTime get startDate => _startDate;
  DateTime get endDate => _endDate;
  List<BookingItemExtra> get selectedExtras => _selectedExtras;
  String? get couponCode => _couponCode;

  BookingProvider() {
    _initInitialBooking();
  }

  void _initInitialBooking() {
    final defaultCar = AppData.initialCars.first;
    _bookings.add(
      Booking(
        id: "DL-2026-00101",
        userId: 1,
        car: defaultCar,
        pickupLocation: "Delhi Central Flagship Hub (Connaught Place)",
        dropLocation: "Delhi IGI Airport (DEL T3 & T1)",
        startDate: DateTime.now().add(const Duration(days: 2)),
        endDate: DateTime.now().add(const Duration(days: 4)),
        totalDays: 2,
        baseRate: defaultCar.pricePerDay * 2,
        extras: [
          BookingItemExtra(
            id: 2,
            name: 'Full Zero-Deductible Insurance Waiver',
            price: 90.0,
          )
        ],
        extrasTotal: 90.0,
        couponCode: "WELCOME10",
        discountAmount: 24.0,
        tax: 38.88,
        deposit: defaultCar.deposit,
        grandTotal: (defaultCar.pricePerDay * 2) + 90.0 - 24.0 + 38.88,
        status: "Upcoming",
        paymentMethod: "UPI (Google Pay)",
        paymentStatus: "Paid",
        driverName: "Aarav Sharma",
        driverPhone: "+91 98765 43210",
        driverEmail: "user@drivelux.com",
        licenseNumber: "DL-0420230098765",
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
    );
  }

  void selectCar(Car car) {
    _selectedCar = car;
    _selectedExtras.clear();
    _couponCode = null;
    _discountPercent = 0.0;
    notifyListeners();
  }

  void setLocations(String pickup, String drop) {
    _pickupLocation = pickup;
    _dropLocation = drop;
    notifyListeners();
  }

  void setDates(DateTime start, DateTime end) {
    _startDate = start;
    _endDate = end;
    notifyListeners();
  }

  void toggleExtra(int id, String name, double price) {
    final index = _selectedExtras.indexWhere((e) => e.id == id);
    if (index >= 0) {
      _selectedExtras.removeAt(index);
    } else {
      _selectedExtras.add(BookingItemExtra(id: id, name: name, price: price));
    }
    notifyListeners();
  }

  bool isExtraSelected(int id) {
    return _selectedExtras.any((e) => e.id == id);
  }

  bool applyCoupon(String code) {
    final clean = code.trim().toUpperCase();
    if (AppData.couponCodes.containsKey(clean)) {
      _couponCode = clean;
      _discountPercent = AppData.couponCodes[clean]!;
      notifyListeners();
      return true;
    }
    return false;
  }

  void removeCoupon() {
    _couponCode = null;
    _discountPercent = 0.0;
    notifyListeners();
  }

  int get totalDays {
    final diff = _endDate.difference(_startDate).inDays;
    return diff > 0 ? diff : 1;
  }

  double get baseRate {
    if (_selectedCar == null) return 0.0;
    return _selectedCar!.pricePerDay * totalDays;
  }

  double get extrasTotal {
    double total = 0.0;
    for (var extra in _selectedExtras) {
      total += extra.price * totalDays;
    }
    return total;
  }

  double get discountAmount {
    return (baseRate + extrasTotal) * _discountPercent;
  }

  double get taxAmount {
    final subtotal = (baseRate + extrasTotal) - discountAmount;
    return subtotal * 0.18; // 18% GST standard
  }

  double get grandTotal {
    return (baseRate + extrasTotal - discountAmount) + taxAmount;
  }

  Booking confirmBooking({
    required int userId,
    required String driverName,
    required String driverPhone,
    required String driverEmail,
    required String licenseNumber,
    required String paymentMethod,
  }) {
    final car = _selectedCar ?? AppData.initialCars.first;
    final bookingId = "DL-${DateTime.now().year}-${1000 + _bookings.length + 1}";

    final newBooking = Booking(
      id: bookingId,
      userId: userId,
      car: car,
      pickupLocation: _pickupLocation,
      dropLocation: _dropLocation,
      startDate: _startDate,
      endDate: _endDate,
      totalDays: totalDays,
      baseRate: baseRate,
      extras: List.from(_selectedExtras),
      extrasTotal: extrasTotal,
      couponCode: _couponCode,
      discountAmount: discountAmount,
      tax: taxAmount,
      deposit: car.deposit,
      grandTotal: grandTotal,
      status: "Upcoming",
      paymentMethod: paymentMethod,
      paymentStatus: "Paid",
      driverName: driverName,
      driverPhone: driverPhone,
      driverEmail: driverEmail,
      licenseNumber: licenseNumber,
      createdAt: DateTime.now(),
    );

    _bookings.insert(0, newBooking);
    notifyListeners();
    return newBooking;
  }
}
