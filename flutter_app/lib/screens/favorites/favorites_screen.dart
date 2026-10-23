import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../providers/car_provider.dart';
import '../../widgets/car_card.dart';
import '../fleet/car_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final carProvider = Provider.of<CarProvider>(context);
    final favCars = carProvider.favoriteCars;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Collection', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      ),
      body: favCars.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppTheme.card,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppTheme.border),
                    ),
                    child: const Icon(Icons.favorite_border, size: 48, color: AppTheme.textMuted),
                  ),
                  const SizedBox(height: 16),
                  const Text('No saved vehicles yet', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 6),
                  const Text('Tap the heart icon on any car to save it here.', style: TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favCars.length,
              itemBuilder: (context, index) {
                final car = favCars[index];
                return CarCard(
                  car: car,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CarDetailScreen(car: car),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
