import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api/common/constant.dart';
import 'package:restaurant_app_api/data/model/detail_restaurant.dart';
import 'package:restaurant_app_api/helper/result_state_helper.dart';
import 'package:restaurant_app_api/provider/favorite_status_provider.dart';
import 'package:restaurant_app_api/widget/show_snack_bar.dart';

class FavoriteButtonWidget extends StatelessWidget {
  const FavoriteButtonWidget({Key? key, required this.restaurantData})
      : super(key: key);

  final RestaurantElement restaurantData;

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteStatusProvider>(builder: (context, data, chill) {
      return Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.6),
            borderRadius: BorderRadius.circular(100)),
        child: IconButton(
          onPressed: () async {
            if (data.favoriteState == ResultState.noData) {
              ScaffoldMessenger.of(context).showSnackBar(
                showSnackBar(DataString.favoriteAddMessage),
              );
              data.addFavorite(restaurantData);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                showSnackBar(DataString.favoriteRemoveMessage),
              );
              data.deleteFavorite();
            }
          },
          icon: Icon(
            data.icon,
            color: Colors.red,
            size: 25,
          ),
        ),
      );
    });
  }
}
