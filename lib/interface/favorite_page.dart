import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api/common/constant.dart';
import 'package:restaurant_app_api/helper/result_state_helper.dart';
import 'package:restaurant_app_api/provider/favorite_provider.dart';
import 'package:restaurant_app_api/widget/favorit_list_view.dart';
import 'package:restaurant_app_api/widget/show_message.dart';

class FovouritePage extends StatelessWidget {
  const FovouritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 30),
          SafeArea(
            child: Center(
              child: Text(
                DataString.favoriteBarTitle,
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
          Expanded(
            child: Consumer<FavoriteProvider>(builder: (context, data, child) {
              if (data.state == ResultState.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (data.state == ResultState.hasData) {
                return ListView.builder(
                  itemCount: data.favorite.length,
                  itemBuilder: (context, index) {
                    return FavoritListViewWidget(
                        restaurant: data.favorite[index], maxHeight: 75);
                  },
                );
              } else {
                return showMessage(context, DataString.favoriteNoDataMessage);
              }
            }),
          )
        ],
      ),
    );
  }
}
