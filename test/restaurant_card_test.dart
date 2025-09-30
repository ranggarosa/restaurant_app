import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:restaurant_app/data/models/restaurant.dart';
import 'package:restaurant_app/ui/widgets/restaurant_card.dart';

void main() {
  testWidgets('RestaurantCard should display restaurant information', (WidgetTester tester) async {
    final restaurant = Restaurant(
      id: '1',
      name: 'Warung Tegal',
      city: 'Jakarta',
      pictureId: '123',
      rating: 4.8,
    );

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RestaurantCard(restaurant: restaurant),
          ),
        ),
      );
    });

    expect(find.text('Warung Tegal'), findsOneWidget);
    expect(find.text('Jakarta'), findsOneWidget);
    expect(find.text('4.8'), findsOneWidget);
    expect(find.byType(Hero), findsOneWidget);
  });
}