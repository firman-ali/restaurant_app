import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api/common/constant.dart';
import 'package:restaurant_app_api/data/api/api_service.dart';
import 'package:restaurant_app_api/data/model/detail_page_argument.dart';
import 'package:restaurant_app_api/helper/result_state_helper.dart';
import 'package:restaurant_app_api/provider/favorite_status_provider.dart';
import 'package:restaurant_app_api/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app_api/widget/custom_back_button.dart';
import 'package:restaurant_app_api/widget/custom_scroll_view.dart';
import 'package:restaurant_app_api/widget/favorite_button.dart';
import 'package:restaurant_app_api/widget/restaurant_review.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail_page';

  final DetailPageArguments args;
  const DetailPage({Key? key, required this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantDetailProvider>(
          create: (_) => RestaurantDetailProvider(
              apiService: ApiService(baseUrl: Network.BASE_URL),
              restaurantId: args.restaurantId),
        ),
        ChangeNotifierProvider<FavoriteStatusProvider>(
          create: (_) => FavoriteStatusProvider(
              restaurantId: args.restaurantId, context: context),
        ),
      ],
      child: Scaffold(
          body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Hero(
              tag: args.pictureId,
              child: CachedNetworkImage(
                imageUrl: Network.IMAGE_URL + args.pictureId,
                placeholder: (context, url) => Container(
                  color: Colors.black12,
                ),
                height: size.height * 0.4,
                width: size.width,
                fit: BoxFit.cover,
              ),
            ),
            SafeArea(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    backButton(context),
                    Consumer<RestaurantDetailProvider>(
                        builder: (context, data, child) {
                      if (data.detailState == ResultState.hasData) {
                        return FavoriteButtonWidget(
                          restaurantData: data.resultDetail,
                        );
                      } else {
                        return Container(color: Colors.transparent);
                      }
                    }),
                  ],
                ),
              ),
            ),
            Consumer<RestaurantDetailProvider>(builder: (context, data, child) {
              if (data.detailState == ResultState.hasData) {
                final restaurant = data.resultDetail;
                return DefaultTabController(
                  length: 2,
                  child: Positioned(
                    bottom: 0,
                    child: FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.7,
                        decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            restaurant.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                CupertinoIcons.location_solid,
                                                size: 20,
                                              ),
                                              Text(
                                                restaurant.city,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1,
                                              ),
                                              const SizedBox(width: 5.0),
                                              Text(
                                                '(' + restaurant.address + ')',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          size: 24,
                                        ),
                                        Text(restaurant.rating.toString())
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              TabBar(
                                labelColor: Theme.of(context).primaryColor,
                                labelStyle:
                                    Theme.of(context).textTheme.headline4,
                                tabs: const [
                                  Tab(
                                    text: DataString.overviewBarTitle,
                                  ),
                                  Tab(
                                    text: DataString.reviewBarTitle,
                                  )
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Expanded(
                                child: TabBarView(
                                  children: [
                                    CustomScrollViewWidget(
                                        restaurant: restaurant),
                                    RestaurantReviewWidget(
                                        restaurantId: restaurant.id),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              } else if (data.detailState == ResultState.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return errorMessage(context);
              }
            })
          ],
        ),
      )),
    );
  }

  Widget errorMessage(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error,
            size: 100,
          ),
          const SizedBox(height: 10.0),
          Text(
            DataString.messageNoData,
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(DataString.back),
          )
        ],
      ),
    );
  }
}
