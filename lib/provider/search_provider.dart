import 'package:flutter/material.dart';
import 'package:restaurant_app_api/data/api/api_service.dart';
import 'package:restaurant_app_api/data/model/search_restaurnat.dart';
import 'package:restaurant_app_api/helper/result_state_helper.dart';

class SearchProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchProvider({required this.apiService});

  late RestaurantsQuery _restaurantResult;
  ResultState _state = ResultState.isWaiting;

  ResultState get state => _state;
  RestaurantsQuery get result => _restaurantResult;

  searchRestaurant(String query) async {
    _state = ResultState.isLoading;
    notifyListeners();
    try {
      final restaurant =
          await apiService.findRestaurant(query) as RestaurantsQuery;
      if (restaurant.founded == 0) {
        _state = ResultState.noData;
        notifyListeners();
      } else {
        _restaurantResult = restaurant;
        _state = ResultState.hasData;
        notifyListeners();
      }
    } catch (e) {
      _state = ResultState.isError;
      notifyListeners();
    }
  }

  void resetState() {
    _state = ResultState.isWaiting;
    notifyListeners();
  }
}
