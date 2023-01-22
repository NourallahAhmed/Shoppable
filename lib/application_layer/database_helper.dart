import 'dart:io';

import 'package:Shoppable/application_layer/dependency_injection.dart';
import 'package:Shoppable/domain_layer/model/product_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' show join;

class DataBaseHelper {
  //singleton
  DataBaseHelper._instance();

  static final DataBaseHelper dataBaseHelper = DataBaseHelper._instance();

  // variables
  static const _dataBaseName = "AppDataBase.db";
  static const _tableName = "cart";
  static const _dataBaseVersion = 2;
  static const _idColumn = "id";
  static const _titleColumn = "title";
  static const _priceColumn = "price";
  static const _categoryColumn = "category";
  static const _imageColumn = "image";
  static const _descriptionColumn = "description";

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dataBaseName);
    return await openDatabase(path,
        version: _dataBaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $_tableName ($_idColumn INTEGER PRIMARY KEY , $_titleColumn TEXT NOT NULL, $_priceColumn REAL  NOT NULL, $_categoryColumn TEXT NOT NULL, $_descriptionColumn TEXT NOT NULL, $_imageColumn TEXT NOT NULL)');
  } // Helper methods

  Future<void> insertOrder(Product product) async {
    // var db =  instance<Database>();
    // row to insert
    Map<String, dynamic> row = {
      DataBaseHelper._idColumn: product.id,
      DataBaseHelper._titleColumn: product.title,
      DataBaseHelper._categoryColumn: product.category,
      DataBaseHelper._priceColumn: product.price,
      DataBaseHelper._imageColumn: product.image,
      DataBaseHelper._descriptionColumn: product.description,
    };
    // do the insert and get the id of the inserted row
    int? id = await instance<Database>().insert(DataBaseHelper._tableName, row);
    print("int = $id");
    // show the results: print all rows in the db
    print(await instance<Database>().query(DataBaseHelper._tableName));
  }

  Future<List<Product>> getAllOrder() async {
    List<Map<String, Object?>> results =
        await instance<Database>().rawQuery('SELECT * FROM $_tableName');

    print("results =  $results");
    List<Product> products = [];
    for (Map<String, dynamic> result in results) {
      var price =    result[_priceColumn];
      print(price.runtimeType);
      products.add(Product(
          result[_idColumn],
          result[_titleColumn],
          result[_priceColumn],
          result[_categoryColumn],
          result[_descriptionColumn],
          result[_imageColumn],
          Rating(0.0, 0)));
    }
    print("products = $products");
    return products;
  }

  Future deleteProductFromCart(Product product)  async{ 
    await instance<Database>().rawDelete('DELETE FROM $_tableName WHERE $_idColumn = ?', [product.id]);
  }
}
