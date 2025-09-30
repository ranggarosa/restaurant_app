import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:restaurant_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Full app flow: Tap restaurant and see detail', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 3));

    final firstRestaurantCard = find.byType(Card).first;
    expect(firstRestaurantCard, findsOneWidget);

    await tester.tap(firstRestaurantCard);

    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.text('Deskripsi'), findsOneWidget);
    expect(find.text('Makanan'), findsOneWidget);
    expect(find.text('Minuman'), findsOneWidget);
  });
}