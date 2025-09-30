import 'package:flutter/foundation.dart';
import '../data/api/api_service.dart';
import '../data/models/restaurant_detail.dart';
import '../common/state_enum.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String restaurantId;

  RestaurantDetailProvider({required this.apiService, required this.restaurantId}) {
    _fetchDetail(restaurantId);
  }

  late RestaurantDetail _restaurantDetail;
  late ResultState _state;
  String _message = '';

  RestaurantDetail get result => _restaurantDetail;
  ResultState get state => _state;
  String get message => _message;

  Future<void> _fetchDetail(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final result = await apiService.getRestaurantDetail(id);
      _state = ResultState.hasData;
      _restaurantDetail = result;

    } catch (e) {
      _state = ResultState.error;
      _message = 'Error --> $e';
    } finally {
      notifyListeners();
    }
  }
}