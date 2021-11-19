import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api/common/constant.dart';
import 'package:restaurant_app_api/data/api/api_service.dart';
import 'package:restaurant_app_api/helper/result_state_helper.dart';
import 'package:restaurant_app_api/provider/review_provider.dart';
import 'package:restaurant_app_api/widget/show_message.dart';
import 'package:restaurant_app_api/widget/show_snack_bar.dart';

class RestaurantReviewWidget extends StatelessWidget {
  final String restaurantId;

  const RestaurantReviewWidget({Key? key, required this.restaurantId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ReviewProvider>(
      create: (_) => ReviewProvider(
          apiService: ApiService(baseUrl: Network.BASE_URL),
          restaurantId: restaurantId),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Row(
              children: [
                const Icon(CupertinoIcons.doc_text_search),
                const SizedBox(width: 5),
                Text(
                  DataString.reviewTitle,
                  style: Theme.of(context).textTheme.headline2,
                ),
              ],
            ),
          ),
          Consumer<ReviewProvider>(
            builder: (context, result, _) {
              if (result.getState == ResultState.isLoading) {
                return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()));
              } else if (result.getState == ResultState.hasData) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      final review = result.result;
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                review[index].date,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              Text(
                                DataString.reviewFrom + review[index].name,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                DataString.reviewData + review[index].review,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: result.result.length,
                  ),
                );
              } else {
                return SliverToBoxAdapter(
                  child: showMessage(context, DataString.reviewErrorMessage),
                );
              }
            },
          ),
          const AddCommentWidget()
        ],
      ),
    );
  }
}

class AddCommentWidget extends StatefulWidget {
  const AddCommentWidget({Key? key}) : super(key: key);

  @override
  State<AddCommentWidget> createState() => _AddCommentWidgetState();
}

class _AddCommentWidgetState extends State<AddCommentWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.only(top: 20, bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.add_comment),
                const SizedBox(width: 5),
                Text(
                  DataString.addReviewTitle,
                  style: Theme.of(context).textTheme.headline2,
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                prefixIcon: const Icon(CupertinoIcons.person),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: DataString.nameReviewHint,
              ),
            ),
            const SizedBox(height: 5.0),
            TextField(
              maxLines: 5,
              maxLength: 100,
              controller: _reviewController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: DataString.addReviewHint,
              ),
            ),
            CupertinoButton(
              color: Colors.blue,
              child: const Text(DataString.send),
              onPressed: () {
                final provider =
                    Provider.of<ReviewProvider>(context, listen: false);
                provider.postReview(
                    _nameController.text, _reviewController.text);
                _nameController.text = '';
                _reviewController.text = '';

                ScaffoldMessenger.of(context).showSnackBar(
                  showSnackBar(DataString.addReviewMessage),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
