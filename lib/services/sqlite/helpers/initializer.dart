import 'package:flutter_hair_salon_app_main/services/sqlite/db/login_user.dart';
import 'package:sqflite/sqflite.dart';

class DBInitializer{
 static inializeTables()async{
    Database? db=await LoginUserDBHelper().database;
    LoginUserDBHelper().tableCreate(db);
 }
}