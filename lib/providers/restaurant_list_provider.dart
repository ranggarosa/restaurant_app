import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/models/restaurant.dart';
import 'package:restaurant_app/common/state_enum.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantListProvider({required this.apiService}) {
    fetchAllRestaurants();
  }

  late List<Restaurant> _restaurants;
  late ResultState _state;
  String _message = '';

  List<Restaurant> get restaurants => _restaurants;
  ResultState get state => _state;
  String get message => _message;

  Future<void> fetchAllRestaurants() async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final result = await apiService.getRestaurantList();
      if (result.isEmpty) {
        _state = ResultState.noData;
        _message = 'Data restoran kosong';
      } else {
        _state = ResultState.hasData;
        _restaurants = result;
      }
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error --> $e';
    } finally {
      notifyListeners();
    }
  }
}