import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:wallet_f/model/wallet.dart';




class DatabaseHelper{
  static DatabaseHelper _databaseHelper;     //Singleton DatabaseHelper
  static Database _database;     //Singleton Database

  String walletTable = 'wallet_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colPriority = 'priority';
  String colDate = 'date';
  String colSum = 'sum';


  DatabaseHelper._createInstance();  // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper(){
    if(_databaseHelper == null){
      _databaseHelper =  DatabaseHelper._createInstance(); //This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {

    if(_database == null){
      _database = await initializeDatabase();

    }
    return _database;
  }

  Future<Database> initializeDatabase() async {

    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'wallets.db';

    // Open/create the database at a given path

    var walletsDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return walletsDatabase;


  }

  void _createDb(Database db, int newVersion) async {

    await db.execute('CREATE TABLE $walletTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
        '$colDescription TEXT, $colPriority INTEGER, $colDate TEXT, $colSum INTEGER)');
  }

  // Fetch Operation: Get all note objects from database

  Future<List<Map<String,dynamic>>> getWalletMapList() async {
    Database db = await this.database;
    //var result = await db.rawQuery('SELECT * FROM $walletTable order by $colPriority ASC' );
    var result = await db.query(walletTable, orderBy: '$colPriority ASC');
    return result;

  }

  // Insert Operation: Insert a Wallet object to database

  Future<int> insertWallet(Wallet wallet) async {
    var db = await this.database;
    var result = await db.insert(walletTable, wallet.toMap());
    return result;
  }


  // Update Operation: Update a Wallet object and save it to database
  Future<int> updateWallet(Wallet wallet) async {
    var db = await this.database;
    var result = await db.update(walletTable, wallet.toMap(), where:'$colId =?', whereArgs: [wallet.id]);
    return result;
  }

  // Delete Operation: Delete a Wallet object from database
  Future<int> deleteWallet(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $walletTable WHERE $colId = $id');
    return result;
  }

// Get number of Wallet objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $walletTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }



  // Get the 'Map List' [ List<Map> ] and convert it to 'Wallet List' [ List<Wallet> ]
  Future<List<Wallet>> getWalletList() async {

    var walletMapList = await getWalletMapList(); // Get 'Map List' from database

    int count = walletMapList.length;         // Count the number of map entries in db table

    List<Wallet> walletList = List<Wallet>();

    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      walletList.add(Wallet.fromMapObject(walletMapList[i]));
    }

    return walletList;
  }


}