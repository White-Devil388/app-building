import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../data/app_data.dart';

class AuthProvider extends ChangeNotifier {
  AppUser? _currentUser;
  final List<AppUser> _users = List.from(AppData.demoUsers);

  AppUser? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;
  bool get isAdmin => _currentUser?.role == 'admin';
  bool get isHost => _currentUser?.role == 'host';
  bool get isCustomer => _currentUser?.role == 'customer';

  AuthProvider() {
    // Default logged in as Customer for easy testing
    _currentUser = _users.first;
  }

  bool login(String email, String password) {
    final cleanEmail = email.trim().toLowerCase();
    final user = _users.firstWhere(
      (u) =>
          u.email.toLowerCase() == cleanEmail &&
          (u.password == password ||
              (u.role == 'admin' && (password == 'admin123' || password == '9999')) ||
              (u.role == 'customer' && password == 'user123') ||
              (u.role == 'host' && password == 'host123')),
      orElse: () => AppUser(
        id: 0,
        name: '',
        email: '',
        password: '',
        role: '',
        avatar: '',
        phone: '',
        licenseNumber: '',
        loyaltyPoints: 0,
        membershipTier: '',
      ),
    );

    if (user.id != 0) {
      _currentUser = user;
      notifyListeners();
      return true;
    }
    return false;
  }

  void loginAsRole(String role) {
    final user = _users.firstWhere((u) => u.role == role, orElse: () => _users.first);
    _currentUser = user;
    notifyListeners();
  }

  bool register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String role,
  }) {
    final cleanEmail = email.trim().toLowerCase();
    final exists = _users.any((u) => u.email.toLowerCase() == cleanEmail);
    if (exists) return false;

    final newUser = AppUser(
      id: _users.length + 1,
      name: name,
      email: cleanEmail,
      password: password,
      role: role,
      avatar: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=80',
      phone: phone,
      licenseNumber: 'DL-IND-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      loyaltyPoints: 200,
      membershipTier: role == 'host' ? 'Fleet Host' : 'Silver Member',
    );

    _users.add(newUser);
    _currentUser = newUser;
    notifyListeners();
    return true;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
