import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/common/api_state.dart';
import 'package:restaurant_app/data/models/restaurant_detail.dart';
import 'package:restaurant_app/providers/restaurant_detail_provider.dart';

import 'api_service_test.mocks.dart';

void main() {
  group('RestaurantDetailProvider Test', () {
    late MockApiService mockApiService;
    const testId = 'rqdv5juczeskfw1e867';

    final fakeRestaurantDetail = RestaurantDetail(
      id: testId,
      name: 'Melting Pot',
      description: 'Lorem ipsum dolor sit amet.',
      city: 'Medan',
      address: 'Jln. Pandu No. 13',
      pictureId: '14',
      rating: 4.2,
      menus: Menus(foods: [], drinks: []),
    );

    setUp(() {
      mockApiService = MockApiService();
    });

    test('should change state to ApiSuccess when detail fetching is successful', () async {
      // ARRANGE
      when(mockApiService.getRestaurantDetail(testId))
          .thenAnswer((_) async => fakeRestaurantDetail);

      // ACT
      final provider = RestaurantDetailProvider(
        apiService: mockApiService,
        restaurantId: testId,
      );

      // ASSERT
      await untilCalled(mockApiService.getRestaurantDetail(testId));

      expect(provider.state, isA<ApiSuccess>());
      expect((provider.state as ApiSuccess).data.id, testId);
      verify(mockApiService.getRestaurantDetail(testId)).called(1);
    });

    test('should change state to ApiError when detail fetching fails', () async {
      // ARRANGE
      when(mockApiService.getRestaurantDetail(testId))
          .thenThrow(Exception('Gagal memuat detail'));

      // ACT
      final provider = RestaurantDetailProvider(
        apiService: mockApiService,
        restaurantId: testId,
      );

      // ASSERT
      await untilCalled(mockApiService.getRestaurantDetail(testId));

      expect(provider.state, isA<ApiError>());
      verify(mockApiService.getRestaurantDetail(testId)).called(1);
    });
  });
}