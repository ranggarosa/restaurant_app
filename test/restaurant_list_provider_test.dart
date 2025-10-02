import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/common/api_state.dart';
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

    test('should change state to ApiSuccess when successful', () async {
      // Arrange
      when(mockApiService.getRestaurantList())
          .thenAnswer((_) async => fakeRestaurantList);
      // Act
      final provider = RestaurantListProvider(apiService: mockApiService);
      // Assert
      await untilCalled(mockApiService.getRestaurantList());

      // Verifikasi bahwa state adalah instance dari ApiSuccess
      expect(provider.state, isA<ApiSuccess>());
      // Verifikasi datanya
      expect((provider.state as ApiSuccess).data, fakeRestaurantList);
    });

    test('should cchange state to ApiError when fetching fails', () async {
      // Arrange
      when(mockApiService.getRestaurantList())
          .thenThrow(Exception('Gagal'));
      // Act
      final provider = RestaurantListProvider(apiService: mockApiService);
      // Assert
      await untilCalled(mockApiService.getRestaurantList());

      // Verifikasi bahwa state adalah instance dari ApiError
      expect(provider.state, isA<ApiError>());
    });
  });
}