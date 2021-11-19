import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api/common/constant.dart';
import 'package:restaurant_app_api/helper/responsive_helper.dart';
import 'package:restaurant_app_api/helper/result_state_helper.dart';
import 'package:restaurant_app_api/provider/search_provider.dart';
import 'package:restaurant_app_api/widget/search_list_view.dart';
import 'package:restaurant_app_api/widget/search_view.dart';
import 'package:restaurant_app_api/widget/show_message.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              SafeArea(
                child: Text(
                  DataString.searchMessageTitle,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              const SizedBox(height: 20),
              const SearchView(),
              Expanded(
                child: Consumer<SearchProvider>(
                  builder: (context, data, child) {
                    if (data.state == ResultState.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (data.state == ResultState.hasData &&
                        data.result.founded > 0) {
                      return Center(
                        child: ResponsiveWidget(
                          mobile: ListViewWidget(
                              restaurant: data.result, maxHeight: 75),
                          tab: ListViewWidget(
                              restaurant: data.result, maxHeight: 100),
                        ),
                      );
                    } else if (data.state == ResultState.noData) {
                      return Center(
                        child: showMessage(context, DataString.searchNotFound),
                      );
                    } else if (data.state == ResultState.isError) {
                      return Center(
                        child: showMessage(context, DataString.connectionError),
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.search, size: 100),
                          Text(
                            DataString.searchMessage,
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ],
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
