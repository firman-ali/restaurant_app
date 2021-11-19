import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app_api/common/constant.dart';
import 'package:restaurant_app_api/data/model/detail_page_argument.dart';
import 'package:restaurant_app_api/data/model/list_restaurant.dart';
import 'package:restaurant_app_api/interface/detail_page.dart';
import 'package:restaurant_app_api/provider/restaurant_list_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({
    Key? key,
    required this.maxGrid,
    required this.maxLenght,
    required this.provider,
    required this.restaurantData,
  }) : super(key: key);

  final int maxGrid;
  final double maxLenght;
  final RestaurantListProvider provider;
  final List<ListRestaurantElement> restaurantData;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: restaurantData.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: maxGrid,
        crossAxisSpacing: 5,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return _buildGridItem(
          context,
          restaurantData[index],
          maxLenght,
          provider,
        );
      },
    );
  }
}

Widget _buildGridItem(BuildContext context, ListRestaurantElement restaurant,
    double maxLenght, RestaurantListProvider provider) {
  return InkWell(
    onTap: () async {
      Navigator.pushNamed(
        context,
        DetailPage.routeName,
        arguments: DetailPageArguments(
            pictureId: restaurant.pictureId, restaurantId: restaurant.id),
      );
    },
    child: Stack(
      children: [
        Hero(
          tag: restaurant.pictureId,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: CachedNetworkImage(
              imageUrl: Network.IMAGE_URL + restaurant.pictureId,
              placeholder: (context, url) => Container(
                color: Colors.black12,
              ),
              height: MediaQuery.of(context).size.height * 0.9,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              colors: [
                Colors.black.withOpacity(0.9),
                Colors.black.withOpacity(0.8),
                Colors.black.withOpacity(0.4),
                Colors.black.withOpacity(0.2)
              ],
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: FadeInDown(
            duration: const Duration(milliseconds: 500),
            child: Container(
              width: 60,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(Icons.star),
                  Text(restaurant.rating.toString())
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: FadeInDown(
            duration: const Duration(milliseconds: 500),
            child: Container(
              width: maxLenght,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 15,
                      ),
                      Text(
                        restaurant.city,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
