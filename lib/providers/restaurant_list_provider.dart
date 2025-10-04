import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import '../data/api/api_exception.dart';
import '../data/api/api_service.dart';
import '../data/models/restaurant.dart';
import '../common/api_state.dart';

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
      _state = result.isEmpty ? const ApiSuccess([]) : ApiSuccess(result);
    } on SocketException {
      _state = const ApiError('errorNoInternet');
    } on ClientException {
      _state = const ApiError('errorNoInternet');
    } on ApiException catch (e) {
      _state = ApiError(e.messageKey);
    } catch (e) {
      _state = const ApiError('errorGeneral');
    }
    notifyListeners();
  }
}
