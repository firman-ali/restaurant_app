import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app_api/common/constant.dart';
import 'package:restaurant_app_api/data/model/detail_restaurant.dart';

class CustomScrollViewWidget extends StatelessWidget {
  const CustomScrollViewWidget({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final RestaurantElement restaurant;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      CupertinoIcons.doc_append,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      DataString.descriptionDetail,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ExpandableText(
                  restaurant.description,
                  style: Theme.of(context).textTheme.bodyText1,
                  expandText: DataString.expandableTextMore,
                  collapseText: DataString.expandableTextLess,
                  maxLines: 5,
                  linkColor: Colors.blue,
                )
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(top: 20, bottom: 5),
              child: Row(
                children: [
                  const Icon(Icons.fastfood),
                  const SizedBox(width: 5),
                  Text(
                    DataString.menuTitleDetail,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Text(
              DataString.menuFoodTitle,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      restaurant.menus.foods[index].name,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                );
              },
              childCount: restaurant.menus.foods.length,
            ),
          ),
          SliverToBoxAdapter(
            child: Text(
              DataString.menuDrinkTitle,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      restaurant.menus.drinks[index].name,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                );
              },
              childCount: restaurant.menus.drinks.length,
            ),
          ),
        ],
      ),
    );
  }
}
