import 'dart:convert' as convert;  // Added import statement
import 'package:http/http.dart' as http;  // Added import statement
import 'package:quickrecord/user_info.dart';

class DataController {
  static String url =
      'https://script.google.com/macros/s/AKfycbw-SDwX1owGtlD3zrNjEXnBihpwUAK80I2ENl6QUMt9Bz0RZ7lSqVfOWSzBwrMZHzMt/exec';

  static const STATUS_SUCCESS = 'SUCCESS';

  void submitForm(Users users, void Function(String) callback) async {

    // print(users.toJson());
    try {
      await http.post(Uri.parse(url), body: users.toJson()).then((response) async {
        if (response.statusCode == 302) {
          var url = response.headers['location'];
          await http.get(Uri.parse(url!)).then((response) {
            callback(convert.jsonDecode(response.body)['Status']);
          });
        } else {
          callback(convert.jsonDecode(response.body)['Status']);
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
