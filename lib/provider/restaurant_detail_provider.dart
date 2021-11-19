import 'package:flutter/material.dart';
import 'package:restaurant_app_api/data/api/api_service.dart';
import 'package:restaurant_app_api/data/model/detail_restaurant.dart';
import 'package:restaurant_app_api/helper/result_state_helper.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String restaurantId;

  RestaurantDetailProvider(
      {required this.apiService, required this.restaurantId}) {
    _getRestaurantDetail();
  }

  late RestaurantElement _restaurantDetail;

  ResultState _stateDetail = ResultState.isLoading;

  ResultState get detailState => _stateDetail;

  RestaurantElement get resultDetail => _restaurantDetail;

  void _getRestaurantDetail() async {
    _stateDetail = ResultState.isLoading;
    notifyListeners();
    final result =
        await apiService.detailRestaurant(restaurantId) as Restaurants;
    if (result.error) {
      _stateDetail = ResultState.isError;
      notifyListeners();
    } else {
      _restaurantDetail = result.restaurant;
      _stateDetail = ResultState.hasData;
      notifyListeners();
    }
  }
}
