import 'package:flutter/material.dart';
import '../models/car_model.dart';
import '../data/app_data.dart';

class CarProvider extends ChangeNotifier {
  final List<Car> _cars = List.from(AppData.initialCars);
  final Set<int> _favoriteCarIds = {1, 19}; // Pre-favorite Thar and Porsche
  String _selectedCategory = 'All';
  String _searchQuery = '';
  String _sortBy = 'popular'; // popular, price_low, price_high, rating

  List<Car> get allCars => _cars;
  Set<int> get favoriteCarIds => _favoriteCarIds;
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;
  String get sortBy => _sortBy;

  List<Car> get featuredCars => _cars.where((c) => c.featured).toList();

  List<Car> get favoriteCars => _cars.where((c) => _favoriteCarIds.contains(c.id)).toList();

  List<Car> get filteredCars {
    return _cars.where((car) {
      final matchesCategory = _selectedCategory == 'All' || car.type.toLowerCase() == _selectedCategory.toLowerCase();
      final matchesSearch = _searchQuery.isEmpty ||
          car.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          car.brand.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList()
      ..sort((a, b) {
        if (_sortBy == 'price_low') {
          return a.pricePerDay.compareTo(b.pricePerDay);
        } else if (_sortBy == 'price_high') {
          return b.pricePerDay.compareTo(a.pricePerDay);
        } else if (_sortBy == 'rating') {
          return b.rating.compareTo(a.rating);
        }
        return b.reviewsCount.compareTo(a.reviewsCount);
      });
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setSortBy(String sort) {
    _sortBy = sort;
    notifyListeners();
  }

  void toggleFavorite(int carId) {
    if (_favoriteCarIds.contains(carId)) {
      _favoriteCarIds.remove(carId);
    } else {
      _favoriteCarIds.add(carId);
    }
    notifyListeners();
  }

  bool isFavorite(int carId) {
    return _favoriteCarIds.contains(carId);
  }

  void addHostCar(Car newCar) {
    _cars.insert(0, newCar);
    notifyListeners();
  }
}
