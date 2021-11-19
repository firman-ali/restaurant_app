import 'dart:math';
import 'dart:ui';
import 'dart:isolate';

import 'package:restaurant_app_api/common/constant.dart';
import 'package:restaurant_app_api/data/api/api_service.dart';
import 'package:restaurant_app_api/data/model/list_restaurant.dart';
import 'package:restaurant_app_api/helper/notification_helper.dart';
import 'package:restaurant_app_api/main.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _service;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _service = this;
  }

  factory BackgroundService() => _service ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    final NotificationHelper _notificationHelper = NotificationHelper();
    var resultApi = await ApiService(baseUrl: Network.BASE_URL).getRestaurant()
        as ListRestaurants;
    final _random = Random();
    var _restaurantData =
        resultApi.restaurants[_random.nextInt(resultApi.restaurants.length)];
    await _notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, _restaurantData);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
