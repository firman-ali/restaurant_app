class FavoriteRestaurant {
  final String id;
  final String name;
  final String city;
  final String pictureId;
  final double rating;

  FavoriteRestaurant({
    required this.id,
    required this.name,
    required this.city,
    required this.pictureId,
    required this.rating,
  });

  factory FavoriteRestaurant.fromJson(Map<String, dynamic> json) =>
      FavoriteRestaurant(
        id: json["id"],
        name: json["name"],
        city: json["city"],
        pictureId: json["pictureId"],
        rating: json["rating"].toDouble(),
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'city': city,
      'pictureId': pictureId,
      'rating': rating
    };
  }
}
