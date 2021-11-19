import 'package:path/path.dart';
import 'package:restaurant_app_api/data/model/detail_restaurant.dart';
import 'package:restaurant_app_api/data/model/favorite_restaurant.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static late Database _database;

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  static const String _tableName = 'restaurant';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      join(path, 'favorite_db.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tableName (
               id TEXT PRIMARY KEY,
               name TEXT, city TEXT, pictureId TEXT, rating REAL
             )''',
        );
      },
      version: 1,
    );
    return db;
  }

  Future<void> insertFavorite(RestaurantElement restaurantData) async {
    final Database db = await database;
    final favoriteRestaurant = FavoriteRestaurant(
      id: restaurantData.id,
      name: restaurantData.name,
      city: restaurantData.city,
      pictureId: restaurantData.pictureId,
      rating: restaurantData.rating,
    );

    await db.insert(_tableName, favoriteRestaurant.toJson());
  }

  Future<List<FavoriteRestaurant>> getFavorit() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableName);

    return results.map((res) => FavoriteRestaurant.fromJson(res)).toList();
  }

  Future<FavoriteRestaurant?> getFavoriteById(String id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.map((res) => FavoriteRestaurant.fromJson(res)).first;
    } else {
      return null;
    }
  }

  Future<void> deleteFavorite(String id) async {
    final db = await database;

    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
