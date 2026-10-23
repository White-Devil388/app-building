class AppUser {
  final int id;
  final String name;
  final String email;
  final String password;
  final String role; // customer, host, admin
  final String avatar;
  final String phone;
  final String licenseNumber;
  final int loyaltyPoints;
  final String membershipTier;

  AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.avatar,
    required this.phone,
    required this.licenseNumber,
    required this.loyaltyPoints,
    required this.membershipTier,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      role: json['role'] ?? 'customer',
      avatar: json['avatar'] ?? 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=80',
      phone: json['phone'] ?? '',
      licenseNumber: json['licenseNumber'] ?? '',
      loyaltyPoints: json['loyaltyPoints'] ?? 0,
      membershipTier: json['membershipTier'] ?? 'Member',
    );
  }
}
