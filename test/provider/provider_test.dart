import 'package:flutter_test/flutter_test.dart';
import 'package:mock_web_server/mock_web_server.dart';
import 'package:restaurant_app_api/common/constant.dart';
import 'package:restaurant_app_api/data/api/api_service.dart';
import 'package:restaurant_app_api/data/model/list_restaurant.dart';
import 'package:restaurant_app_api/helper/json_helper.dart';
import 'package:restaurant_app_api/helper/result_state_helper.dart';
import 'package:restaurant_app_api/provider/restaurant_list_provider.dart';

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

  group("Getting All Restaurant Testing", () {
    test("get all restaurant should be success", () async {
      var dataState = ListRestaurants.fromJson(restaurantListJson);
      var expectedValue = dataState;
      RestaurantListProvider listProvider =
          RestaurantListProvider(apiService: _service);

      _server.defaultResponse = MockResponse()
        ..body = JsonHelper().restaurantsConvertJson(dataState)
        ..httpCode = 200;

      await listProvider.fetchAllRestaurant();

      expect(listProvider.state == ResultState.hasData, true);
      expect(listProvider.result.restaurants.length,
          expectedValue.restaurants.length);
    });

    test("get all restaurant should be success but restaurant is empty",
        () async {
      var dataState = ListRestaurants.fromJson(emptyRestaurantListJson);
      RestaurantListProvider listProvider =
          RestaurantListProvider(apiService: _service);

      _server.defaultResponse = MockResponse()
        ..body = JsonHelper().restaurantsConvertJson(dataState)
        ..httpCode = 200;

      await listProvider.fetchAllRestaurant();

      expect(listProvider.state == ResultState.noData, true);
    });

    test("get all restaurant should be fail", () async {
      RestaurantListProvider pageProvider =
          RestaurantListProvider(apiService: _service);

      _server.defaultResponse = MockResponse()..httpCode = 404;

      expect(pageProvider.state != ResultState.isError, true);
    });
  });
}
