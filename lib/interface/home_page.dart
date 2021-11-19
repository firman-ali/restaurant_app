import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api/common/constant.dart';
import 'package:restaurant_app_api/data/model/list_restaurant.dart';
import 'package:restaurant_app_api/helper/responsive_helper.dart';
import 'package:restaurant_app_api/helper/result_state_helper.dart';
import 'package:restaurant_app_api/provider/restaurant_list_provider.dart';
import 'package:restaurant_app_api/widget/main_grid_view.dart';
import 'package:restaurant_app_api/widget/profile_row.dart';
import 'package:restaurant_app_api/widget/show_message.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/restaurant_list';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: NestedScrollView(
            headerSliverBuilder: (context, value) {
              return [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10.0),
                      SafeArea(
                        child: profileRow(context),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        DataString.homeMessageTitle,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: SafeArea(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TabBar(
                      labelColor: Theme.of(context).primaryColor,
                      labelStyle: Theme.of(context).textTheme.headline2,
                      tabs: const [
                        Tab(text: DataString.exploreBarTitle),
                        Tab(text: DataString.populerBarTitle)
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    Expanded(
                      child: TabBarView(children: [
                        Consumer<RestaurantListProvider>(
                            builder: (context, provider, child) {
                          if (provider.state == ResultState.isLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (provider.state == ResultState.hasData) {
                            return _tabBarViewItem(
                                provider.result.restaurants, provider);
                          } else if (provider.state == ResultState.noData) {
                            return showMessage(
                                context, DataString.messageNoData);
                          } else {
                            return showMessage(
                              context,
                              DataString.connectionError,
                            );
                          }
                        }),
                        Consumer<RestaurantListProvider>(
                            builder: (context, provider, child) {
                          if (provider.state == ResultState.isLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (provider.state == ResultState.hasData) {
                            return _tabBarViewItem(
                                provider.resultPopuler, provider);
                          } else if (provider.state == ResultState.noData) {
                            return showMessage(
                                context, DataString.messageNoData);
                          } else {
                            return showMessage(
                              context,
                              DataString.connectionError,
                            );
                          }
                        }),
                      ]),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget _tabBarViewItem(
      List<ListRestaurantElement> data, RestaurantListProvider provider) {
    return ResponsiveWidget(
      mobile: GridViewWidget(
        maxGrid: 2,
        maxLenght: 150,
        provider: provider,
        restaurantData: data,
      ),
      tab: GridViewWidget(
        maxGrid: 4,
        maxLenght: 200,
        provider: provider,
        restaurantData: data,
      ),
    );
  }
}
