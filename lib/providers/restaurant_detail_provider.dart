import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import '../data/api/api_exception.dart';
import '../data/api/api_service.dart';
import '../data/models/restaurant_detail.dart';
import '../common/api_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String restaurantId;

  RestaurantDetailProvider({
    required this.apiService,
    required this.restaurantId,
  }) {
    fetchDetail(restaurantId);
  }

  late ApiState<RestaurantDetail> _state;

  ApiState<RestaurantDetail> get state => _state;

  Future<void> fetchDetail(String id) async {
    _state = const ApiLoading();
    notifyListeners();
    try {
      final result = await apiService.getRestaurantDetail(id);
      _state = ApiSuccess(result);
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
