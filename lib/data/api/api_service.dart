import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app_api/helper/json_helper.dart';

class ApiService {
  final String baseUrl;
  ApiService({required this.baseUrl});

  Future<Object> getRestaurant() async {
    final response = await http.get(Uri.parse(baseUrl + "list"));
    if (response.statusCode == 200) {
      return JsonHelper().listRestaurantsParsingJson(response.body);
    } else {
      throw Exception(
        'Failed to load list restaurant data from url',
      );
    }
  }

  Future<Object> detailRestaurant(String _id) async {
    final response = await http.get(Uri.parse(baseUrl + "detail/" + _id));
    if (response.statusCode == 200) {
      return JsonHelper().detailParsingJson(response.body);
    } else {
      throw Exception('Failed to load restaurant data from url');
    }
  }

  Future<Object> findRestaurant(String _query) async {
    final response = await http.get(Uri.parse(baseUrl + "search?q=" + _query));
    if (response.statusCode == 200) {
      return JsonHelper().searchParsingJson(response.body);
    } else {
      throw Exception('Failed to load search list restaurnat data from url');
    }
  }

  Future<http.Response> addReview(
      String _restaurantId, String _name, String _review) async {
    Map data = {"id": _restaurantId, "name": _name, "review": _review};
    var body = json.encode(data);
    final response = await http.post(Uri.parse(baseUrl + "review"),
        headers: {"Content-Type": "application/json"}, body: body);
    return response;
  }
}
