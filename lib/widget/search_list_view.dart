import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app_api/common/constant.dart';
import 'package:restaurant_app_api/data/model/detail_page_argument.dart';
import 'package:restaurant_app_api/data/model/search_restaurnat.dart';
import 'package:restaurant_app_api/interface/detail_page.dart';

class ListViewWidget extends StatelessWidget {
  final RestaurantsQuery restaurant;
  final double maxHeight;
  const ListViewWidget({
    Key? key,
    required this.restaurant,
    required this.maxHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: restaurant.founded,
      itemBuilder: (context, index) {
        final restaurants = restaurant.restaurants[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () async {
              Navigator.pushNamed(
                context,
                DetailPage.routeName,
                arguments: DetailPageArguments(
                    pictureId: restaurants.pictureId,
                    restaurantId: restaurants.id),
              );
            },
            child: Card(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Hero(
                      tag: restaurants.pictureId,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.network(
                          Network.IMAGE_URL + restaurants.pictureId,
                          height: maxHeight,
                          scale: 5,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FadeIn(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    restaurants.name,
                                    style: Theme.of(context).textTheme.headline2,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.star),
                                    Text(restaurants.rating.toString())
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              children: [
                                const Icon(CupertinoIcons.location_solid),
                                Text(
                                  restaurants.city,
                                  style: Theme.of(context).textTheme.headline4,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
