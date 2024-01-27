import 'dart:convert';
import 'package:quickrecord/user_info.dart';  // Assuming Users class is defined here
import 'package:shared_preferences/shared_preferences.dart';

class UserDataStorage {
  static Future<void> saveUserData(List<Users> userDataList) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList(
      'userDataList',
      userDataList.map((user) => user.toJson()).toList().map((json) => jsonEncode(json)).toList(),
    );
  }

  static Future<List<Users>> loadUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String>? userListString = sharedPreferences.getStringList('userDataList');
    List<Users> loadedUserDataList = [];

    if (userListString != null) {
      loadedUserDataList = userListString
          .map((jsonString) => Users.fromJson(jsonDecode(jsonString)))
          .toList();
    }

    return loadedUserDataList;
  }
}
