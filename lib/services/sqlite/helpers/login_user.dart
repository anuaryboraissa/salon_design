

import '../../../hairSalon/model/login_user.dart';
import '../db/login_user.dart';

class LoginUserHelper {
  final LoginUserDBHelper _dbHelper = LoginUserDBHelper();

  Future<int> insert(LoginUser user) async {
    return _dbHelper.insert(toMap(user));
  }

  Future<LoginUser?> queryById(int id) async {
    return fromMap(await _dbHelper.queryById(id));
  }
  
  Future<int> update(LoginUser user,int id) async {
    return _dbHelper.update(toMap(user),id);
  }


  Future<List<LoginUser?>> queryAll() async {
    List<Map<String, dynamic>> reportMapList = await _dbHelper.queryAll();
    return reportMapList.map((e) => fromMap(e)).toList();
  }

  Future<int> delete(int id) async {
    return _dbHelper.delete(id);
  }

  Map<String, dynamic> toMap(LoginUser user) {
    return {
      LoginUserDBHelper.columnEmail: user.email,
      LoginUserDBHelper.columnFirstname: user.firstName,
      LoginUserDBHelper.columnLastname: user.lastName,
      LoginUserDBHelper.columnType: user.type,
      LoginUserDBHelper.columnId: user.id,
    };
  }

  LoginUser? fromMap(Map<String, dynamic>? map) {
    return map == null
        ? null
        : LoginUser(
            email: map[LoginUserDBHelper.columnEmail],
            firstName: map[LoginUserDBHelper.columnFirstname],
            lastName: map[LoginUserDBHelper.columnLastname],
            id: map[LoginUserDBHelper.columnId],
            type: map[LoginUserDBHelper.columnType],
          );
  }
}