import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_exception.dart';
import '../../data/models/restaurant.dart';
import '../../data/models/restaurant_detail.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<List<Restaurant>> getRestaurantList() async {
    final response = await http.get(Uri.parse("$_baseUrl/list"));
    if (response.statusCode == 200) {
      final List<dynamic> restaurantsJson = json.decode(
        response.body,
      )['restaurants'];
      return restaurantsJson.map((json) => Restaurant.fromJson(json)).toList();
    } else {
      switch (response.statusCode) {
        case 404:
          throw ApiException('errorNotFound');
        case 500:
          throw ApiException('errorInternalServer');
        default:
          throw ApiException('errorGeneral');
      }
    }
  }

  Future<RestaurantDetail> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));
    if (response.statusCode == 200) {
      final dynamic restaurantJson = json.decode(response.body)['restaurant'];
      return RestaurantDetail.fromJson(restaurantJson);
    } else {
      switch (response.statusCode) {
        case 404:
          throw ApiException('errorNotFound');
        case 500:
          throw ApiException('errorInternalServer');
        default:
          throw ApiException('errorGeneral');
      }
    }
  }
}
