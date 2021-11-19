import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app_api/data/model/favorite_restaurant.dart';
import 'package:restaurant_app_api/helper/database_helper.dart';
import 'package:restaurant_app_api/helper/result_state_helper.dart';

class FavoriteProvider extends ChangeNotifier {
  FavoriteProvider() {
    _dbHelper = DatabaseHelper();
    _getAllFavorite();
  }

  late DatabaseHelper _dbHelper;
  List<FavoriteRestaurant> _favorite = [];
  late ResultState _state;
  late ResultState _favoriteState;
  final IconData _icon = Icons.favorite_outline;

  List<FavoriteRestaurant> get favorite => _favorite;

  IconData get icon => _icon;

  ResultState get state => _state;

  ResultState get favoriteState => _favoriteState;

  void _getAllFavorite() async {
    _state = ResultState.isLoading;
    notifyListeners();
    try {
      final results = await _dbHelper.getFavorit();
      if (results.isNotEmpty) {
        _favorite = results;
        _state = ResultState.hasData;
        notifyListeners();
      } else {
        _state = ResultState.noData;
        _favorite.clear();
        notifyListeners();
      }
    } catch (e) {
      _state = ResultState.isError;
      notifyListeners();
    }
  }

  void refreshData() {
    _getAllFavorite();
  }
}
