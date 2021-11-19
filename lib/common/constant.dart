class Network {
  static const BASE_URL = 'https://restaurant-api.dicoding.dev/';
  static const IMAGE_URL = "https://restaurant-api.dicoding.dev/images/small/";
}

class DataString {
  static const applicationTitle = 'Restaurant';
  static const homeBarTitle = 'Home';
  static const favoriteBarTitle = 'Favorite';
  static const searchBarTitle = 'Search';
  static const settingBarTitle = 'Setting';
  static const searchHint = 'Search Restaurant';
  static const reviewTitle = 'Review';
  static const reviewFrom = 'from: ';
  static const reviewData = 'review: ';
  static const reviewErrorMessage = 'Sorry Failed to Load Review Data';
  static const addReviewTitle = 'Add Review';
  static const nameReviewHint = 'Write Your Name Here';
  static const addReviewHint = 'Write a Review About This Restaurant';
  static const send = 'Kirim';
  static const back = 'Back';
  static const addReviewMessage = 'Review Data Added';
  static const welcome = 'Welcome';
  static const userHome = 'User';
  static const favoriteAddMessage = 'Restaurant Added To Favorite';
  static const favoriteRemoveMessage = 'Restaurant Removed From Favorite';
  static const descriptionDetail = 'Description';
  static const expandableTextMore = 'show more';
  static const expandableTextLess = 'show less';
  static const menuTitleDetail = 'Menu';
  static const menuFoodTitle = 'Food';
  static const menuDrinkTitle = 'Drink';
  static const emptyData = 'Empty Data';
  static const settingPageTitle = 'Settings';
  static const preferenceSettingTitle = 'Preference Settings';
  static const darkThemeTitle = 'Dark Theme';
  static const themeMessageActive = 'Dark Theme Mode Activated';
  static const themeMessageCancle = 'Light Theme Mode Activated';
  static const scheduleNotificationTitle = 'Scheduling Notification';
  static const scheduleMessageActive = 'Scheduling Notification Activated';
  static const scheduleMessageCancle = 'Scheduling Notification Canceled';
  static const searchMessageTitle = 'Find the Restaurant You Want To Visit';
  static const searchNotFound =
      'Sorry, the restaurant you were looking for was not found';
  static const connectionError =
      'Sorry An Error Occurred, Please Check Internet Connection';
  static const searchMessage = 'Search Restaurant';
  static const homeMessageTitle =
      'Discover Restaurant with Delicious Menus';
  static const exploreBarTitle = 'Explore';
  static const populerBarTitle = 'Populer';
  static const messageNoData = 'Sorry No Data Found';
  static const favoriteNoDataMessage = 'No Favorite Data Added';
  static const overviewBarTitle = 'Overview';
  static const reviewBarTitle = 'Review';
}

final restaurantListJson = {
  "error": false,
  "message": "success",
  "count": 20,
  "restaurants": [
    {
      "id": "rqdv5juczeskfw1e867",
      "name": "Melting Pot",
      "description":
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
      "pictureId": "14",
      "city": "Medan",
      "rating": 4.2
    },
    {
      "id": "s1knt6za9kkfw1e867",
      "name": "Kafe Kita",
      "description":
          "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
      "pictureId": "25",
      "city": "Gorontalo",
      "rating": 4
    }
  ]
};

final emptyRestaurantListJson = {
  "error": false,
  "message": "success",
  "count": 0,
  "restaurants": []
};

final detailDataJson = {
  "error": false,
  "message": "success",
  "restaurant": {
    "id": "rqdv5juczeskfw1e867",
    "name": "Melting Pot",
    "description":
        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
    "city": "Medan",
    "address": "Jln. Pandeglang no 19",
    "pictureId": "14",
    "categories": [
      {"name": "Italia"},
      {"name": "Modern"}
    ],
    "menus": {
      "foods": [
        {"name": "Paket rosemary"},
        {"name": "Toastie salmon"}
      ],
      "drinks": [
        {"name": "Es krim"},
        {"name": "Sirup"}
      ]
    },
    "rating": 4.2,
    "customerReviews": [
      {
        "name": "Ahmad",
        "review": "Tidak rekomendasi untuk pelajar!",
        "date": "13 November 2019"
      }
    ]
  }
};

final searchQueryJson = {
  "error": false,
  "founded": 1,
  "restaurants": [
    {
      "id": "fnfn8mytkpmkfw1e867",
      "name": "Makan mudah",
      "description":
          "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, ...",
      "pictureId": "22",
      "city": "Medan",
      "rating": 3.7
    }
  ]
};

final emptySearchQueryJson = {"error": false, "founded": 0, "restaurants": []};

final favoriteDataJson = {
  'id': "rqdv5juczeskfw1e867",
  'name': "Melting Pot",
  'city': "Medan",
  'pictureId': '14',
  'rating': 4.2
};
