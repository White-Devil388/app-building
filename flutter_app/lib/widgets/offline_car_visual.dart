import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class OfflineCarVisual extends StatelessWidget {
  final String imageUrl;
  final String brand;
  final String name;
  final String type;
  final double height;
  final BorderRadius? borderRadius;

  const OfflineCarVisual({
    super.key,
    required this.imageUrl,
    required this.brand,
    required this.name,
    required this.type,
    this.height = 180,
    this.borderRadius,
  });

  String? _getLocalAsset() {
    final query = '$name $brand'.toLowerCase();
    if (query.contains('thar')) return 'assets/images/thar.jpg';
    if (query.contains('safari')) return 'assets/images/safari.jpg';
    if (query.contains('fortuner')) return 'assets/images/fortuner.jpg';
    if (query.contains('range') || query.contains('rover') || query.contains('defender')) {
      return 'assets/images/rangerover.jpg';
    }
    if (query.contains('bmw')) return 'assets/images/bmw.jpg';
    if (query.contains('porsche')) return 'assets/images/porsche.jpg';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final br = borderRadius ?? const BorderRadius.vertical(top: Radius.circular(22));
    final String? chosenAsset = (imageUrl.isNotEmpty && imageUrl.startsWith('assets/'))
        ? imageUrl
        : _getLocalAsset();

    return ClipRRect(
      borderRadius: br,
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: _getGradientForType(type),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // 1. If local bundled asset photo exists, show it directly (0 internet needed)
            if (chosenAsset != null)
              Image.asset(
                chosenAsset,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => _buildNetworkOrPlaceholder(),
              )
            else
              _buildNetworkOrPlaceholder(),

            // Dark gradient overlay for contrast and text clarity
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.35),
                      Colors.transparent,
                      Colors.black.withOpacity(0.75),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNetworkOrPlaceholder() {
    if (imageUrl.isNotEmpty) {
      if (imageUrl.startsWith('assets/')) {
        return Image.asset(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _buildOfflinePlaceholder(),
        );
      } else if (imageUrl.startsWith('http')) {
        return Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _buildOfflinePlaceholder(),
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return _buildOfflinePlaceholder();
          },
        );
      }
    }
    return _buildOfflinePlaceholder();
  }

  LinearGradient _getGradientForType(String carType) {
    switch (carType.toLowerCase()) {
      case 'sports':
        return const LinearGradient(
          colors: [Color(0xFF4A0E17), Color(0xFF1F090D), Color(0xFF0D0D15)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'luxury':
        return const LinearGradient(
          colors: [Color(0xFF382E11), Color(0xFF1D1708), Color(0xFF0D0D15)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'suv':
        return const LinearGradient(
          colors: [Color(0xFF1B2838), Color(0xFF0F1722), Color(0xFF0B0B0F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      default:
        return const LinearGradient(
          colors: [Color(0xFF232338), Color(0xFF151522), Color(0xFF0B0B0F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
  }

  IconData _getIconForType(String carType) {
    switch (carType.toLowerCase()) {
      case 'sports':
        return Icons.sports_motorsports;
      case 'suv':
        return Icons.terrain;
      case 'luxury':
        return Icons.stars;
      default:
        return Icons.directions_car;
    }
  }

  Widget _buildOfflinePlaceholder() {
    return Container(
      decoration: BoxDecoration(gradient: _getGradientForType(type)),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _getIconForType(type),
            size: 40,
            color: type.toLowerCase() == 'luxury' ? AppTheme.accent : AppTheme.primary,
          ),
          const SizedBox(height: 6),
          Text(
            brand.toUpperCase(),
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              color: AppTheme.textSecondary,
            ),
          ),
          Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
