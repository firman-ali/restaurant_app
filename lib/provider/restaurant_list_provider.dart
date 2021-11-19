import 'package:flutter/material.dart';
import 'package:restaurant_app_api/data/api/api_service.dart';
import 'package:restaurant_app_api/data/model/list_restaurant.dart';
import 'package:restaurant_app_api/helper/result_state_helper.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantListProvider({required this.apiService}) {
    fetchAllRestaurant();
  }

  late ListRestaurants _restaurantResult;
  late List<ListRestaurantElement> _restaurantPopulerResult;
  ResultState _state = ResultState.isLoading;

  ResultState get state => _state;

  ListRestaurants get result => _restaurantResult;

  List<ListRestaurantElement> get resultPopuler => _restaurantPopulerResult;

  Future fetchAllRestaurant() async {
    _state = ResultState.isLoading;
    notifyListeners();
    try {
      final ListRestaurants restaurant =
          await apiService.getRestaurant() as ListRestaurants;
      final ListRestaurants _resultData =
          await apiService.getRestaurant() as ListRestaurants;
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
      } else if (restaurant.restaurants.isNotEmpty) {
        _resultData.restaurants.sort((a, b) => a.rating.compareTo(b.rating));
        final restaurantData = _resultData.restaurants.reversed.toList();
        _restaurantPopulerResult = restaurantData;
        _restaurantResult = restaurant;
        _state = ResultState.hasData;
        notifyListeners();
      } else {
        _state = ResultState.isError;
        notifyListeners();
      }
    } catch (e) {
      _state = ResultState.isError;
      notifyListeners();
    }
  }
}
