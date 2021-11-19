import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api/interface/detail_page.dart';
import 'package:restaurant_app_api/provider/search_provider.dart';
import 'package:restaurant_app_api/helper/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/constant.dart';
import 'data/api/api_service.dart';
import 'data/model/detail_page_argument.dart';
import 'interface/splash_screen.dart';
import 'provider/favorite_provider.dart';
import 'utils/page_router.dart';
import 'helper/preference_helper.dart';
import 'provider/preference_provider.dart';
import 'provider/restaurant_list_provider.dart';
import 'utils/background_service.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantListProvider>(
          create: (_) => RestaurantListProvider(
              apiService: ApiService(baseUrl: Network.BASE_URL)),
        ),
        ChangeNotifierProvider<SearchProvider>(
          create: (_) =>
              SearchProvider(apiService: ApiService(baseUrl: Network.BASE_URL)),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
      ],
      child: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            title: DataString.applicationTitle,
            theme: provider.themeData,
            initialRoute: SplashScreen.routeName,
            routes: {
              SplashScreen.routeName: (context) => const SplashScreen(),
              PageRouter.routeName: (context) => const PageRouter(),
              DetailPage.routeName: (context) => DetailPage(
                  args: ModalRoute.of(context)?.settings.arguments
                      as DetailPageArguments)
            },
          );
        },
      ),
    );
  }
}
