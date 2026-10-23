import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../models/car_model.dart';
import '../../providers/car_provider.dart';
import '../../providers/auth_provider.dart';

class HostCarScreen extends StatefulWidget {
  const HostCarScreen({super.key});

  @override
  State<HostCarScreen> createState() => _HostCarScreenState();
}

class _HostCarScreenState extends State<HostCarScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _brandController = TextEditingController();
  final _priceDayController = TextEditingController();
  final _depositController = TextEditingController();
  final _powerController = TextEditingController();
  final _imageController = TextEditingController(
    text: 'https://images.unsplash.com/photo-1555215695-3004980ad54e?auto=format&fit=crop&w=1200&q=85',
  );

  String _type = 'SUV';
  String _transmission = 'Automatic';
  String _fuel = 'Petrol';
  int _seats = 5;

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _priceDayController.dispose();
    _depositController.dispose();
    _powerController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final carProvider = Provider.of<CarProvider>(context, listen: false);
    final auth = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('List Your Car', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.card,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.border),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.monetization_on, color: AppTheme.accent, size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Earn Passive Income', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14)),
                          Text('Host with 100% insurance & verified VIP renters.', style: TextStyle(color: AppTheme.textMuted, fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              const Text('Vehicle Overview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
              const SizedBox(height: 10),
              TextFormField(
                controller: _brandController,
                decoration: const InputDecoration(labelText: 'Car Brand (e.g. BMW, Mercedes, Mahindra)'),
                validator: (v) => v!.isEmpty ? 'Brand required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Model Name (e.g. M4 Competition)'),
                validator: (v) => v!.isEmpty ? 'Model required' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _type,
                decoration: const InputDecoration(labelText: 'Vehicle Body Type'),
                dropdownColor: AppTheme.cardLight,
                items: ['SUV', 'Sedan', 'Luxury', 'Sports'].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                onChanged: (val) => setState(() => _type = val!),
              ),
              const SizedBox(height: 20),

              const Text('Rental Pricing & Deposit', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _priceDayController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Price Per Day (\$)'),
                      validator: (v) => v!.isEmpty ? 'Price required' : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _depositController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Security Deposit (\$)'),
                      validator: (v) => v!.isEmpty ? 'Deposit required' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              const Text('Specifications', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _transmission,
                      decoration: const InputDecoration(labelText: 'Transmission'),
                      dropdownColor: AppTheme.cardLight,
                      items: ['Automatic', 'Manual'].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                      onChanged: (val) => setState(() => _transmission = val!),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _fuel,
                      decoration: const InputDecoration(labelText: 'Fuel'),
                      dropdownColor: AppTheme.cardLight,
                      items: ['Petrol', 'Diesel', 'Hybrid', 'Electric'].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                      onChanged: (val) => setState(() => _fuel = val!),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _powerController,
                decoration: const InputDecoration(labelText: 'Engine Power (e.g. 250 HP)'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _imageController,
                decoration: const InputDecoration(labelText: 'Cover Image URL'),
              ),
              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final priceDay = double.tryParse(_priceDayController.text) ?? 100.0;
                      final deposit = double.tryParse(_depositController.text) ?? 300.0;

                      final newCar = Car(
                        id: DateTime.now().millisecondsSinceEpoch % 100000,
                        slug: _nameController.text.toLowerCase().replaceAll(' ', '-'),
                        name: _nameController.text,
                        brand: _brandController.text,
                        type: _type,
                        year: 2024,
                        pricePerHour: priceDay / 4,
                        pricePerDay: priceDay,
                        pricePerWeek: priceDay * 6,
                        pricePerMonth: priceDay * 22,
                        deposit: deposit,
                        kmLimitPerDay: 300,
                        extraKmCharge: 0.25,
                        transmission: _transmission,
                        fuel: _fuel,
                        seats: _seats,
                        doors: 4,
                        luggage: 3,
                        mileage: '15 km/l',
                        engine: '2.0L Turbo',
                        power: _powerController.text.isNotEmpty ? _powerController.text : '200 HP',
                        color: 'Black Metallic',
                        rating: 5.0,
                        reviewsCount: 1,
                        status: 'Available',
                        featured: true,
                        features: ['Air Conditioning', 'Bluetooth', 'Touchscreen', 'Reverse Camera'],
                        images: [_imageController.text],
                        description: 'Recently listed luxury vehicle in prime condition.',
                        ownerName: auth.currentUser?.name ?? 'DriveLux Host Partner',
                        ownerPhone: auth.currentUser?.phone ?? '+91 98100 77654',
                      );

                      carProvider.addHostCar(newCar);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: AppTheme.success,
                          content: Text('Vehicle listed successfully! Live on Fleet.'),
                        ),
                      );

                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text('Publish Car Listing', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
