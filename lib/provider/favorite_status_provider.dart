import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api/data/model/detail_restaurant.dart';
import 'package:restaurant_app_api/helper/database_helper.dart';
import 'package:restaurant_app_api/helper/result_state_helper.dart';
import 'package:restaurant_app_api/provider/favorite_provider.dart';

class FavoriteStatusProvider extends ChangeNotifier {
  String restaurantId;
  BuildContext context;
  FavoriteStatusProvider({required this.restaurantId, required this.context}) {
    _dbHelper = DatabaseHelper();
    _getFavoriteById();
  }

  late DatabaseHelper _dbHelper;
  late ResultState _favoriteState;
  IconData _icon = Icons.favorite_outline;

  IconData get icon => _icon;

  ResultState get favoriteState => _favoriteState;

  Future _getFavoriteById() async {
    try {
      final result = await _dbHelper.getFavoriteById(restaurantId);
      if (result != null) {
        _favoriteState = ResultState.hasData;
        _icon = Icons.favorite;
        notifyListeners();
      } else {
        _favoriteState = ResultState.noData;
        _icon = Icons.favorite_outline;
        notifyListeners();
      }
    } catch (e) {
      _favoriteState = ResultState.isError;
      notifyListeners();
    }
  }

  Future<void> addFavorite(RestaurantElement restaurantData) async {
    await _dbHelper.insertFavorite(restaurantData);
    Provider.of<FavoriteProvider>(context, listen: false).refreshData();
    _getFavoriteById();
  }

  Future<void> deleteFavorite() async {
    await _dbHelper.deleteFavorite(restaurantId);
    Provider.of<FavoriteProvider>(context, listen: false).refreshData();
    _getFavoriteById();
  }
}
