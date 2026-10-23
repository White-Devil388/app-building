import 'car_model.dart';

class BookingItemExtra {
  final int id;
  final String name;
  final double price;

  BookingItemExtra({
    required this.id,
    required this.name,
    required this.price,
  });
}

class Booking {
  final String id;
  final int userId;
  final Car car;
  final String pickupLocation;
  final String dropLocation;
  final DateTime startDate;
  final DateTime endDate;
  final int totalDays;
  final double baseRate;
  final List<BookingItemExtra> extras;
  final double extrasTotal;
  final String? couponCode;
  final double discountAmount;
  final double tax;
  final double deposit;
  final double grandTotal;
  final String status; // Upcoming, Completed, Cancelled
  final String paymentMethod;
  final String paymentStatus;
  final String driverName;
  final String driverPhone;
  final String driverEmail;
  final String licenseNumber;
  final DateTime createdAt;

  Booking({
    required this.id,
    required this.userId,
    required this.car,
    required this.pickupLocation,
    required this.dropLocation,
    required this.startDate,
    required this.endDate,
    required this.totalDays,
    required this.baseRate,
    required this.extras,
    required this.extrasTotal,
    this.couponCode,
    required this.discountAmount,
    required this.tax,
    required this.deposit,
    required this.grandTotal,
    required this.status,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.driverName,
    required this.driverPhone,
    required this.driverEmail,
    required this.licenseNumber,
    required this.createdAt,
  });
}
