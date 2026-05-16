import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/product.dart';
import '../data/mock_data.dart';

class ComboDeal {
  final String title;
  final String description;
  final List<String> productIds;
  final double discountPercent;
  final Color accentColor;
  final IconData icon;

  const ComboDeal({
    required this.title,
    required this.description,
    required this.productIds,
    required this.discountPercent,
    required this.accentColor,
    required this.icon,
  });
}

final List<ComboDeal> comboDeals = [
  ComboDeal(
    title: 'Pro Audio Bundle',
    description: 'Get the ultimate streaming setup with a premium headset and studio mic at 15% off!',
    productIds: ['5', '4'],
    discountPercent: 15,
    accentColor: Colors.amber,
    icon: Icons.headphones,
  ),
  ComboDeal(
    title: 'Desktop Warrior Kit',
    description: 'Mouse + Keyboard + Desk Mat — everything you need to dominate. Save 20%!',
    productIds: ['1', '2', '6'],
    discountPercent: 20,
    accentColor: Colors.cyanAccent,
    icon: Icons.desktop_mac,
  ),
  ComboDeal(
    title: 'Full Neo Setup',
    description: 'The ultimate gaming rig: Monitor, Chair, Mouse, and Keyboard at a massive 25% off!',
    productIds: ['8', '3', '1', '2'],
    discountPercent: 25,
    accentColor: Colors.purpleAccent,
    icon: Icons.rocket_launch,
  ),
];

class ComboDealsScreen extends StatelessWidget {
  const ComboDealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('COMBO DEALS'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F0F13), Color(0xFF1A1A2E)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: comboDeals.length,
            itemBuilder: (context, index) {
              return _buildComboCard(context, comboDeals[index]);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildComboCard(BuildContext context, ComboDeal combo) {
    final products = combo.productIds
        .map((id) => mockProducts.firstWhere((p) => p.id == id))
        .toList();

    final originalTotal = products.fold<double>(0, (sum, p) => sum + p.price);
    final discountedTotal = originalTotal * (1 - combo.discountPercent / 100);

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: combo.accentColor.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        combo.accentColor.withValues(alpha: 0.2),
                        Colors.transparent,
                      ],
                    ),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: combo.accentColor.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(combo.icon, color: combo.accentColor, size: 28),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              combo.title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: combo.accentColor.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'SAVE ${combo.discountPercent.toInt()}%',
                                style: TextStyle(
                                  color: combo.accentColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Text(
                    combo.description,
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),

                // Product list
                ...products.map((product) => _buildProductRow(context, product)),

                // Pricing and Add to Cart
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\$${originalTotal.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          Text(
                            '\$${discountedTotal.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: combo.accentColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          final cartProvider = Provider.of<CartProvider>(context, listen: false);
                          for (final product in products) {
                            cartProvider.addItem(product);
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${combo.title} added to cart!'),
                              backgroundColor: combo.accentColor,
                              duration: const Duration(milliseconds: 1500),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        icon: const Icon(Icons.add_shopping_cart),
                        label: const Text('ADD BUNDLE'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: combo.accentColor,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductRow(BuildContext context, Product product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              product.imagePath,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              product.name,
              style: const TextStyle(fontSize: 15),
            ),
          ),
          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
