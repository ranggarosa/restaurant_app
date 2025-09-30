import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/restaurant_list_provider.dart';
import '../../common/state_enum.dart';
import '../widgets/restaurant_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Restoran'),
      ),
      body: Consumer<RestaurantListProvider>(
        builder: (context, provider, _) {
          switch (provider.state) {
            case ResultState.loading:
              return const Center(child: CircularProgressIndicator());
            case ResultState.hasData:
              return ListView.builder(
                itemCount: provider.restaurants.length,
                itemBuilder: (context, index) {
                  final restaurant = provider.restaurants[index];
                  return RestaurantCard(restaurant: restaurant);
                },
              );
            case ResultState.error:
              return Center(child: Text(provider.message));
            case ResultState.noData:
              return Center(child: Text(provider.message));
          }
        },
      ),
    );
  }
}