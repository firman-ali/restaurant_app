import 'package:animate_do/animate_do.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:restaurant_app_api/common/constant.dart';
import 'package:restaurant_app_api/helper/notification_helper.dart';
import 'package:restaurant_app_api/interface/favorite_page.dart';
import 'package:restaurant_app_api/interface/home_page.dart';
import 'package:restaurant_app_api/interface/search_page.dart';
import 'package:restaurant_app_api/interface/setting_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class PageRouter extends StatefulWidget {
  const PageRouter({Key? key}) : super(key: key);

  static const routeName = '/page_route';

  @override
  State<PageRouter> createState() => _PageRouterState();
}

class _PageRouterState extends State<PageRouter> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  final List<Widget> _pages = [
    FadeInDown(child: const HomePage()),
    FadeInDown(child: const FovouritePage()),
    FadeInDown(child: const SearchPage()),
    FadeInDown(child: const SettingPage())
  ];
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPage],
      bottomNavigationBar: SalomonBottomBar(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        currentIndex: _currentPage,
        onTap: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        items: [
          SalomonBottomBarItem(
              icon: const Icon(Icons.home),
              title: const Text(DataString.homeBarTitle)),
          SalomonBottomBarItem(
              icon: const Icon(Icons.favorite),
              title: const Text(DataString.favoriteBarTitle)),
          SalomonBottomBarItem(
              icon: const Icon(Icons.search),
              title: const Text(DataString.searchBarTitle)),
          SalomonBottomBarItem(
              icon: const Icon(Icons.settings),
              title: const Text(DataString.settingBarTitle))
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectNotificationSubject(context);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }
}
