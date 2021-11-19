import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app_api/common/constant.dart';
import 'package:restaurant_app_api/data/model/detail_page_argument.dart';
import 'package:restaurant_app_api/data/model/favorite_restaurant.dart';
import 'package:restaurant_app_api/interface/detail_page.dart';

class FavoritListViewWidget extends StatelessWidget {
  final FavoriteRestaurant restaurant;
  final double maxHeight;

  const FavoritListViewWidget({
    Key? key,
    required this.restaurant,
    required this.maxHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () async {
          Navigator.pushNamed(
            context,
            DetailPage.routeName,
            arguments: DetailPageArguments(
                pictureId: restaurant.pictureId, restaurantId: restaurant.id),
          );
        },
        child: Card(
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Hero(
                  tag: restaurant.pictureId,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.network(
                      Network.IMAGE_URL + restaurant.pictureId,
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
                                restaurant.name,
                                style: Theme.of(context).textTheme.headline2,
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.star),
                                Text(restaurant.rating.toString())
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            const Icon(CupertinoIcons.location_solid),
                            Text(
                              restaurant.city,
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
  }
}
