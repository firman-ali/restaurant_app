import 'package:flutter_test/flutter_test.dart';
import 'package:mock_web_server/mock_web_server.dart';
import 'package:restaurant_app_api/common/constant.dart';
import 'package:restaurant_app_api/data/api/api_service.dart';
import 'package:restaurant_app_api/data/model/detail_restaurant.dart';
import 'package:restaurant_app_api/data/model/list_restaurant.dart';
import 'package:restaurant_app_api/data/model/search_restaurnat.dart';
import 'package:restaurant_app_api/helper/json_helper.dart';

void main() {
  MockWebServer _server = MockWebServer();
  late ApiService _service;

  setUp(() async {
    await _server.start();
    _service = ApiService(baseUrl: _server.url);
  });

  tearDown(() {
    _server.shutdown();
  });

  group("Getting All List Restaurant Testing", () {
    test("get all restaurant should be success", () async {
      var dataState = ListRestaurants.fromJson(restaurantListJson);
      var expectedState = dataState;
      _server.enqueue(
          body: JsonHelper().restaurantsConvertJson(dataState), httpCode: 200);

      var actualState = await _service.getRestaurant() as ListRestaurants;

      expect(actualState.error, false);
      expect(
          actualState.restaurants[0].name, expectedState.restaurants[0].name);
      expect(actualState.restaurants.length, expectedState.restaurants.length);
    });

    test("get all restaurant should be success but restaurant is empty",
        () async {
      var dataState = ListRestaurants.fromJson(emptyRestaurantListJson);
      _server.enqueue(
          body: JsonHelper().restaurantsConvertJson(dataState), httpCode: 200);

      var actualState = await _service.getRestaurant() as ListRestaurants;

      expect(actualState.error, false);
      expect(actualState.count, 0);
      expect(actualState.restaurants.isEmpty, true);
    });

    test("get all restaurant should be error", () async {
      _server.enqueue(httpCode: 404);

      try {
        var actualState = await _service.getRestaurant() as ListRestaurants;
        expect(actualState.error, true);
      } catch (e) {
        expect(
            e.toString() ==
                'Exception: Failed to load list restaurant data from url',
            true);
      }
    });
  });

  group("Getting Detail Restaurant Testing", () {
    test("get detail restaurant data should be success", () async {
      var dataState = Restaurants.fromJson(detailDataJson);
      var expectedState = dataState;
      _server.enqueue(
          body: JsonHelper().detailConvertJson(dataState), httpCode: 200);

      var actualState = await _service.detailRestaurant(dataState.restaurant.id)
          as Restaurants;

      expect(actualState.error, false);
      expect(actualState.restaurant.name, expectedState.restaurant.name);
    });

    test("get detail restaurant data should be error", () async {
      _server.enqueue(httpCode: 404);

      try {
        var actualState = await _service.detailRestaurant('') as Restaurants;
        expect(actualState.error, true);
      } catch (e) {
        expect(
            e.toString() ==
                'Exception: Failed to load restaurant data from url',
            true);
      }
    });
  });

  group("Getting Query Search Restaurant Testing", () {
    test("get all search list restaurant data should be success", () async {
      var dataState = RestaurantsQuery.fromJson(searchQueryJson);
      var expectedState = dataState;
      _server.enqueue(
          body: JsonHelper().searchConvertJson(dataState), httpCode: 200);

      var actualState =
          await _service.findRestaurant('makan') as RestaurantsQuery;

      expect(actualState.error, false);
      expect(
          actualState.restaurants[0].name, expectedState.restaurants[0].name);
    });

    test("get all search list restaurant should be error", () async {
      _server.enqueue(httpCode: 404);
      try {
        var actualState =
            await _service.findRestaurant('makan') as RestaurantsQuery;
        expect(actualState.error, true);
      } catch (e) {
        expect(
            e.toString() ==
                'Exception: Failed to load search list restaurnat data from url',
            true);
      }
    });
  });
}
