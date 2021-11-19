import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api/common/constant.dart';
import 'package:restaurant_app_api/provider/search_provider.dart';

class SearchView extends StatefulWidget {
  const SearchView({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<SearchProvider>(context, listen: false).resetState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade300, borderRadius: BorderRadius.circular(50)),
      child: TextField(
        controller: _searchController,
        onSubmitted: (searchText) {
          if (searchText.isNotEmpty) {
            Provider.of<SearchProvider>(context, listen: false)
                .searchRestaurant(searchText);
          } else {
            Provider.of<SearchProvider>(context, listen: false).resetState();
          }
        },
        onChanged: (searchText) {
          setState(() {});
        },
        style: Theme.of(context).textTheme.headline5,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.blue,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              if (_searchController.text.isNotEmpty) {
                setState(() {
                  _searchController.clear();
                  Provider.of<SearchProvider>(context, listen: false)
                      .resetState();
                });
              }
            },
            icon: _searchController.text.isNotEmpty
                ? const Icon(Icons.clear)
                : Container(),
            color: Colors.black,
          ),
          border: InputBorder.none,
          hintText: DataString.searchHint,
          hintStyle: Theme.of(context).textTheme.headline5,
        ),
      ),
    );
  }
}
