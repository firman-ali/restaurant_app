import 'dart:convert';

import 'package:restaurant_app_api/data/model/detail_restaurant.dart';
import 'package:restaurant_app_api/data/model/favorite_restaurant.dart';
import 'package:restaurant_app_api/data/model/list_restaurant.dart';
import 'package:restaurant_app_api/data/model/search_restaurnat.dart';

class JsonHelper {
  Restaurants detailParsingJson(String str) =>
      Restaurants.fromJson(json.decode(str));

  String detailConvertJson(Restaurants data) => json.encode(data.toJson());

  FavoriteRestaurant favoriteParsingJson(String str) =>
      FavoriteRestaurant.fromJson(json.decode(str));

  String favoriteConvertJson(FavoriteRestaurant data) =>
      json.encode(data.toJson());

  ListRestaurants listRestaurantsParsingJson(String str) =>
      ListRestaurants.fromJson(json.decode(str));

  String restaurantsConvertJson(ListRestaurants data) =>
      json.encode(data.toJson());

  RestaurantsQuery searchParsingJson(String str) =>
      RestaurantsQuery.fromJson(json.decode(str));

  String searchConvertJson(RestaurantsQuery data) => json.encode(data.toJson());
}
