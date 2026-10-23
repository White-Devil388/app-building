class Car {
  final int id;
  final String slug;
  final String name;
  final String brand;
  final String type; // SUV, Sedan, Luxury, Sports
  final int year;
  final double pricePerHour;
  final double pricePerDay;
  final double pricePerWeek;
  final double pricePerMonth;
  final double deposit;
  final int kmLimitPerDay;
  final double extraKmCharge;
  final String transmission;
  final String fuel;
  final int seats;
  final int doors;
  final int luggage;
  final String mileage;
  final String engine;
  final String power;
  final String color;
  final double rating;
  final int reviewsCount;
  final String status;
  final bool featured;
  final List<String> features;
  final List<String> images;
  final String description;
  final String ownerName;
  final String ownerPhone;

  Car({
    required this.id,
    required this.slug,
    required this.name,
    required this.brand,
    required this.type,
    required this.year,
    required this.pricePerHour,
    required this.pricePerDay,
    required this.pricePerWeek,
    required this.pricePerMonth,
    required this.deposit,
    required this.kmLimitPerDay,
    required this.extraKmCharge,
    required this.transmission,
    required this.fuel,
    required this.seats,
    required this.doors,
    required this.luggage,
    required this.mileage,
    required this.engine,
    required this.power,
    required this.color,
    required this.rating,
    required this.reviewsCount,
    required this.status,
    required this.featured,
    required this.features,
    required this.images,
    required this.description,
    required this.ownerName,
    required this.ownerPhone,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'] ?? 0,
      slug: json['slug'] ?? '',
      name: json['name'] ?? '',
      brand: json['brand'] ?? '',
      type: json['type'] ?? '',
      year: json['year'] ?? 2024,
      pricePerHour: (json['pricePerHour'] as num?)?.toDouble() ?? 0.0,
      pricePerDay: (json['pricePerDay'] as num?)?.toDouble() ?? 0.0,
      pricePerWeek: (json['pricePerWeek'] as num?)?.toDouble() ?? 0.0,
      pricePerMonth: (json['pricePerMonth'] as num?)?.toDouble() ?? 0.0,
      deposit: (json['deposit'] as num?)?.toDouble() ?? 0.0,
      kmLimitPerDay: json['kmLimitPerDay'] ?? 300,
      extraKmCharge: (json['extraKmCharge'] as num?)?.toDouble() ?? 0.20,
      transmission: json['transmission'] ?? 'Automatic',
      fuel: json['fuel'] ?? 'Petrol',
      seats: json['seats'] ?? 4,
      doors: json['doors'] ?? 4,
      luggage: json['luggage'] ?? 2,
      mileage: json['mileage'] ?? '',
      engine: json['engine'] ?? '',
      power: json['power'] ?? '',
      color: json['color'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 5.0,
      reviewsCount: json['reviewsCount'] ?? 0,
      status: json['status'] ?? 'Available',
      featured: json['featured'] ?? false,
      features: List<String>.from(json['features'] ?? []),
      images: List<String>.from(json['images'] ?? []),
      description: json['description'] ?? '',
      ownerName: json['ownerName'] ?? 'DriveLux Host',
      ownerPhone: json['ownerPhone'] ?? '+91 98100 77654',
    );
  }
}
