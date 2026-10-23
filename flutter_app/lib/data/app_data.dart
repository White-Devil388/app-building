import '../models/car_model.dart';
import '../models/user_model.dart';

class LocationHub {
  final int id;
  final String name;
  final String city;
  final String address;
  final String image;

  LocationHub({
    required this.id,
    required this.name,
    required this.city,
    required this.address,
    required this.image,
  });
}

class AppData {
  static final List<Car> initialCars = [
    Car(
      id: 1,
      slug: "mahindra-thar-4x4-hardtop",
      name: "Mahindra Thar 4x4 Hard Top",
      brand: "Mahindra",
      type: "SUV",
      year: 2024,
      pricePerHour: 35,
      pricePerDay: 75,
      pricePerWeek: 450,
      pricePerMonth: 1600,
      deposit: 200,
      kmLimitPerDay: 300,
      extraKmCharge: 0.20,
      transmission: "Automatic",
      fuel: "Diesel",
      seats: 4,
      doors: 3,
      luggage: 2,
      mileage: "15.2 km/l",
      engine: "2.2L mHawk 130 Turbo Diesel",
      power: "130 HP",
      color: "Napoli Black",
      rating: 4.9,
      reviewsCount: 218,
      status: "Available",
      featured: true,
      features: [
        "4x4 Shift-On-The-Fly",
        "Removable Hardtop Panels",
        "Adventure Telemetry Display",
        "7-inch Apple CarPlay",
        "Electronic Roll Mitigation",
        "All-Terrain Tyres"
      ],
      images: [
        "assets/images/thar.jpg",
        "assets/images/interior.jpg"
      ],
      description: "India's most iconic 4x4 lifestyle off-roader. Conquer the sands of Rajasthan, Himalayan passes, or cruise the Goa coastline with commanding road presence.",
      ownerName: "Vikram Singhania",
      ownerPhone: "+91 98100 77654",
    ),
    Car(
      id: 2,
      slug: "tata-safari-dark-edition",
      name: "Tata Safari Dark Edition",
      brand: "Tata Motors",
      type: "SUV",
      year: 2024,
      pricePerHour: 40,
      pricePerDay: 90,
      pricePerWeek: 540,
      pricePerMonth: 1950,
      deposit: 250,
      kmLimitPerDay: 300,
      extraKmCharge: 0.22,
      transmission: "Automatic",
      fuel: "Diesel",
      seats: 7,
      doors: 5,
      luggage: 4,
      mileage: "14.8 km/l",
      engine: "2.0L Kryotec Turbocharged Diesel",
      power: "170 HP",
      color: "Oberon Black",
      rating: 4.9,
      reviewsCount: 164,
      status: "Available",
      featured: true,
      features: [
        "Panoramic Sunroof",
        "Ventilated Captain Seats",
        "JBL 10-Speaker Audio",
        "Level 2 ADAS Suite",
        "360-Degree 3D Camera"
      ],
      images: [
        "assets/images/safari.jpg",
        "assets/images/interior.jpg"
      ],
      description: "Tata's majestic flagship 7-seater luxury SUV draped in all-black Obsidian trim with Land Rover D8 pedigree.",
      ownerName: "Vikram Singhania",
      ownerPhone: "+91 98100 77654",
    ),
    Car(
      id: 3,
      slug: "toyota-fortuner-legender",
      name: "Toyota Fortuner Legender 4x4",
      brand: "Toyota",
      type: "SUV",
      year: 2024,
      pricePerHour: 60,
      pricePerDay: 160,
      pricePerWeek: 980,
      pricePerMonth: 3500,
      deposit: 450,
      kmLimitPerDay: 300,
      extraKmCharge: 0.35,
      transmission: "Automatic",
      fuel: "Diesel",
      seats: 7,
      doors: 5,
      luggage: 4,
      mileage: "14.2 km/l",
      engine: "2.8L 4-Cylinder Turbo Diesel",
      power: "204 HP / 500 Nm",
      color: "Platinum White & Black",
      rating: 4.9,
      reviewsCount: 310,
      status: "Available",
      featured: true,
      features: [
        "Bi-Beam LED DRLs",
        "Sequential Turn Indicators",
        "Kick-Sensor Tailgate",
        "JBL 11-Speaker Audio",
        "Wireless Charger"
      ],
      images: [
        "assets/images/fortuner.jpg",
        "assets/images/interior.jpg"
      ],
      description: "The undisputed status symbol on Indian asphalt. Muscle, reliability, and 500 Nm torque built for highway kings.",
      ownerName: "Vikram Singhania",
      ownerPhone: "+91 98100 77654",
    ),
    Car(
      id: 15,
      slug: "range-rover-autobiography-lwb",
      name: "Range Rover Autobiography LWB",
      brand: "Land Rover",
      type: "Luxury",
      year: 2024,
      pricePerHour: 260,
      pricePerDay: 880,
      pricePerWeek: 5400,
      pricePerMonth: 19500,
      deposit: 2200,
      kmLimitPerDay: 200,
      extraKmCharge: 1.10,
      transmission: "Automatic",
      fuel: "Diesel",
      seats: 5,
      doors: 5,
      luggage: 4,
      mileage: "13.1 km/l",
      engine: "3.0L Turbocharged Inline-6 MHEV",
      power: "350 HP / 700 Nm",
      color: "Santorini Black Metallic",
      rating: 5.0,
      reviewsCount: 140,
      status: "Available",
      featured: true,
      features: [
        "Executive Rear Seats with Hot Stone Massage",
        "Active Noise Cancellation in Headrests",
        "Meridian 35-Speaker 1600W Audio",
        "Electronic Air Suspension"
      ],
      images: [
        "assets/images/rangerover.jpg",
        "assets/images/interior.jpg"
      ],
      description: "The royal standard of British motoring. Loved by heads of state and industrial royalty. Unsurpassed serenity.",
      ownerName: "Vikram Singhania",
      ownerPhone: "+91 98100 77654",
    ),
    Car(
      id: 16,
      slug: "bmw-3-series-gran-limousine",
      name: "BMW 3 Series Gran Limousine",
      brand: "BMW",
      type: "Sedan",
      year: 2024,
      pricePerHour: 95,
      pricePerDay: 260,
      pricePerWeek: 1600,
      pricePerMonth: 5600,
      deposit: 650,
      kmLimitPerDay: 250,
      extraKmCharge: 0.45,
      transmission: "Automatic",
      fuel: "Petrol",
      seats: 5,
      doors: 4,
      luggage: 3,
      mileage: "15.3 km/l",
      engine: "2.0L TwinPower Turbo 4-Cylinder",
      power: "258 HP / 400 Nm",
      color: "Portimao Blue Metallic",
      rating: 4.9,
      reviewsCount: 205,
      status: "Available",
      featured: true,
      features: [
        "110mm Stretched Wheelbase",
        "BMW Curved Display",
        "Harman Kardon 16-Speaker Sound",
        "Panoramic Glass Sunroof"
      ],
      images: [
        "assets/images/bmw.jpg",
        "assets/images/interior.jpg"
      ],
      description: "The bestselling luxury sedan in India. Combining 110mm of extra rear legroom with iconic BMW rear-wheel athleticism.",
      ownerName: "DriveLux Host",
      ownerPhone: "+91 98100 77654",
    ),
    Car(
      id: 19,
      slug: "porsche-911-carrera-s",
      name: "Porsche 911 Carrera S (992)",
      brand: "Porsche",
      type: "Sports",
      year: 2024,
      pricePerHour: 320,
      pricePerDay: 920,
      pricePerWeek: 5800,
      pricePerMonth: 21000,
      deposit: 2500,
      kmLimitPerDay: 150,
      extraKmCharge: 1.50,
      transmission: "Automatic",
      fuel: "Petrol",
      seats: 2,
      doors: 2,
      luggage: 1,
      mileage: "11.1 km/l",
      engine: "3.0L Twin-Turbo Boxer-6",
      power: "450 HP / 530 Nm (0-100 in 3.5s)",
      color: "Guards Red",
      rating: 5.0,
      reviewsCount: 96,
      status: "Available",
      featured: true,
      features: [
        "Sport Chrono Package with Mode Switch",
        "Sport Exhaust System with Black Tailpipes",
        "Bose Surround Sound System",
        "Porsche Active Suspension (PASM)"
      ],
      images: [
        "assets/images/porsche.jpg",
        "assets/images/interior.jpg"
      ],
      description: "The gold standard of sports cars. Blistering 3.5-second acceleration, symphonic flat-six exhaust, and legendary German balance.",
      ownerName: "DriveLux VIP Elite",
      ownerPhone: "+91 98100 77654",
    ),
  ];

  static final List<LocationHub> hubLocations = [
    LocationHub(
      id: 1,
      name: "Delhi Central Flagship Hub",
      city: "Delhi NCR",
      address: "Connaught Place Outer Circle, New Delhi",
      image: "assets/images/hub_delhi.jpg",
    ),
    LocationHub(
      id: 2,
      name: "Mumbai BKC Prestige Hub",
      city: "Mumbai",
      address: "Bandra Kurla Complex, Bandra East, Mumbai",
      image: "assets/images/hub_mumbai.jpg",
    ),
    LocationHub(
      id: 3,
      name: "Delhi IGI Airport (DEL T3 & T1)",
      city: "Delhi NCR",
      address: "Terminal 3 Arrival Forecourt, New Delhi",
      image: "assets/images/hub_delhi.jpg",
    ),
    LocationHub(
      id: 4,
      name: "Mumbai CSMIA Airport (BOM T2)",
      city: "Mumbai",
      address: "Airport T2 VIP Delivery Lounge, Mumbai",
      image: "assets/images/hub_mumbai.jpg",
    ),
  ];

  static final List<String> locations = [
    "Delhi Central Flagship Hub (Connaught Place)",
    "Delhi IGI Airport (DEL T3 & T1)",
    "Mumbai BKC Prestige Hub",
    "Mumbai CSMIA Airport (BOM T2)",
    "Bengaluru Indiranagar Hub",
    "Bengaluru Kempegowda Airport (BLR T1)",
    "Goa Dabolim Airport Hub (GOI)",
    "Goa Mopa Airport Hub (GOX)"
  ];

  static final List<Map<String, dynamic>> extraServices = [
    {
      'id': 1,
      'name': 'FASTag Preloaded Express Highway Pass',
      'price': 15.0,
      'unit': 'per trip',
      'icon': 'navigation'
    },
    {
      'id': 2,
      'name': 'Full Zero-Deductible Insurance Waiver',
      'price': 45.0,
      'unit': 'per day',
      'icon': 'shield'
    },
    {
      'id': 3,
      'name': 'Professional Uniformed Chauffeur',
      'price': 55.0,
      'unit': 'per day',
      'icon': 'person'
    },
    {
      'id': 4,
      'name': 'Child Safety Seat (All Ages)',
      'price': 18.0,
      'unit': 'per day',
      'icon': 'chair'
    },
  ];

  static final Map<String, double> couponCodes = {
    'WELCOME10': 0.10,
    'WEEKEND15': 0.15,
    'LUXURY20': 0.20,
    'FIRSTDRIVE': 0.15,
  };

  static final List<AppUser> demoUsers = [
    AppUser(
      id: 1,
      name: 'Aarav Sharma',
      email: 'user@drivelux.com',
      password: 'user123',
      role: 'customer',
      avatar: 'assets/images/user_avatar.jpg',
      phone: '+91 98765 43210',
      licenseNumber: 'DL-0420230098765',
      loyaltyPoints: 1250,
      membershipTier: 'Customer / VIP Renter',
    ),
    AppUser(
      id: 2,
      name: 'DriveLux Master Admin',
      email: 'admin@123.com',
      password: 'admin123',
      role: 'admin',
      avatar: 'assets/images/admin_avatar.jpg',
      phone: '+91 11 4975 1811',
      licenseNumber: 'ADMIN-DL-01',
      loyaltyPoints: 9999,
      membershipTier: 'Fleet & Platform Administrator',
    ),
    AppUser(
      id: 3,
      name: 'Vikram Singhania',
      email: 'host@drivelux.com',
      password: 'host123',
      role: 'host',
      avatar: 'assets/images/host_avatar.jpg',
      phone: '+91 98100 77654',
      licenseNumber: 'DL-HOST-099231',
      loyaltyPoints: 3400,
      membershipTier: 'Car Owner / Fleet Host Partner',
    ),
  ];
}
