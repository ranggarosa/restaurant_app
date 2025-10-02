import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/api_state.dart';
import '../../data/api/api_service.dart';
import '../../data/models/restaurant_detail.dart';
import '../../providers/restaurant_detail_provider.dart';

class DetailPage extends StatelessWidget {
  final String restaurantId;

  const DetailPage({Key? key, required this.restaurantId}) : super(key: key);

  static const String _imageUrl =
      'https://restaurant-api.dicoding.dev/images/medium/';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (_) => RestaurantDetailProvider(
        apiService: ApiService(),
        restaurantId: restaurantId,
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text('Detail Restoran')),
        body: Consumer<RestaurantDetailProvider>(
          builder: (context, provider, _) {
            final state = provider.state;
            return switch (state) {
              ApiLoading() => const Center(child: CircularProgressIndicator()),
              ApiError(:final message) => Center(child: Text(message)),
              ApiSuccess(:final data) => _buildDetailContent(context, data),
            };
          },
        ),
      ),
    );
  }

  Widget _buildDetailContent(
    BuildContext context,
    RestaurantDetail restaurant,
  ) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Hero(
            tag: restaurant.id,
            child: Image.network(_imageUrl + restaurant.pictureId),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16),
                    const SizedBox(width: 4),
                    Text('${restaurant.address}, ${restaurant.city}'),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(restaurant.rating.toString()),
                  ],
                ),
                const Divider(height: 32),
                Text(
                  'Deskripsi',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  restaurant.description,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Divider(height: 32),
                _buildMenuSection(context, 'Makanan', restaurant.menus.foods),
                const SizedBox(height: 16),
                _buildMenuSection(context, 'Minuman', restaurant.menus.drinks),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(
    BuildContext context,
    String title,
    List<MenuItem> items,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: items.map((item) {
            return Chip(
              avatar: Icon(
                title == 'Makanan'
                    ? Icons.fastfood_outlined
                    : Icons.local_cafe_outlined,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              label: Text(item.name),
              backgroundColor: Theme.of(context).colorScheme.primary,
              labelStyle: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
