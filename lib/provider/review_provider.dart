import 'package:flutter/material.dart';
import 'package:restaurant_app_api/common/constant.dart';
import 'package:restaurant_app_api/data/api/api_service.dart';
import 'package:restaurant_app_api/data/model/detail_restaurant.dart';
import 'package:restaurant_app_api/helper/result_state_helper.dart';

class ReviewProvider extends ChangeNotifier {
  final ApiService apiService;
  final String restaurantId;

  ReviewProvider({required this.apiService, required this.restaurantId}) {
    _fetchAllReview();
  }

  late List<CustomerReview> _reviewResult;
  late ResultState _getState;
  late ResultState _postState;
  String _message = '';

  String get message => _message;

  List<CustomerReview> get result => _reviewResult;

  ResultState get getState => _getState;

  ResultState get postState => _postState;

  Future<dynamic> _fetchAllReview() async {
    try {
      _getState = ResultState.isLoading;
      notifyListeners();
      final restaurant =
          await apiService.detailRestaurant(restaurantId) as Restaurants;
      if (restaurant.error) {
        _getState = ResultState.noData;
        notifyListeners();
        return _message = DataString.emptyData;
      } else {
        _getState = ResultState.hasData;
        notifyListeners();
        return _reviewResult = restaurant.restaurant.customerReviews;
      }
    } catch (e) {
      _getState = ResultState.isError;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future postReview(String name, String review) async {
    _postState = ResultState.isLoading;
    notifyListeners();
    try {
      final restaurant = await apiService.addReview(restaurantId, name, review);
      if (restaurant.statusCode == 201) {
        _fetchAllReview();
        _postState = ResultState.isSuccess;
        notifyListeners();
      } else {
        _postState = ResultState.isError;
        notifyListeners();
      }
    } catch (e) {
      _postState = ResultState.isError;
      notifyListeners();
    }
  }
}
