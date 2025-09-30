import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/common/state_enum.dart';
import 'package:restaurant_app/data/models/restaurant.dart';
import 'package:restaurant_app/providers/restaurant_list_provider.dart';

import 'api_service_test.mocks.dart';

void main() {
  group('RestaurantListProvider Test', () {
    late MockApiService mockApiService;

    setUp(() {
      mockApiService = MockApiService();
    });

    final fakeRestaurant = Restaurant(id: '1', name: 'Resto A', city: 'City A', pictureId: '1', rating: 4.5);
    final fakeRestaurantList = [fakeRestaurant];

    test('should get restaurant list and change state to hasData when successful', () async {
      when(mockApiService.getRestaurantList())
          .thenAnswer((_) async => fakeRestaurantList);

      final provider = RestaurantListProvider(apiService: mockApiService);

      await untilCalled(mockApiService.getRestaurantList());

      expect(provider.state, ResultState.hasData);
      expect(provider.restaurants, fakeRestaurantList);

      verify(mockApiService.getRestaurantList()).called(1);
    });

    test('should change state to error when fetching data fails', () async {
      when(mockApiService.getRestaurantList())
          .thenThrow(Exception('Gagal memuat data'));

      final provider = RestaurantListProvider(apiService: mockApiService);

      await untilCalled(mockApiService.getRestaurantList());

      expect(provider.state, ResultState.error);
      expect(provider.message, contains('Error -->'));

      verify(mockApiService.getRestaurantList()).called(1);
    });
  });
}