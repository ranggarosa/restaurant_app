import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/models/restaurant.dart';
import 'package:restaurant_app/common/api_state.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantListProvider({required this.apiService}) {
    fetchAllRestaurants();
  }

  late ApiState<List<Restaurant>> _state;

  ApiState<List<Restaurant>> get state => _state;

  Future<void> fetchAllRestaurants() async {
    _state = const ApiLoading();
    notifyListeners();
    try {
      final result = await apiService.getRestaurantList();
      if (result.isEmpty) {
        _state = const ApiSuccess([]);
      } else {
        _state = ApiSuccess(result);
      }
    } catch (e) {
      _state = ApiError('Error --> $e');
    }
    notifyListeners();
  }
}
