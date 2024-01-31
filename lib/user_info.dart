import 'package:intl/intl.dart';

class Users {
  String aadhar, name, mobile, bankName, type, amount, transactionDate;

  Users(this.aadhar, this.name, this.mobile, this.bankName, this.type, this.amount)
      : transactionDate = DateTime.now().toIso8601String();

  // Json to Object
  Users.fromJson(Map<String, dynamic> json)
      : aadhar = json['aadhar'],
        name = json['name'],
        mobile = json['mobile'],
        bankName = json['bankName'],
        type = json['type'],
        amount = json['amount'],
        transactionDate = json['transactionDate'];

  // Object to Json
  Map<String, dynamic> toJson() {
    return {
      'aadhar': aadhar,
      'name': name,
      'mobile': mobile,
      'bankName': bankName,
      'type': type,
      'amount': amount,
      'transactionDate': transactionDate,
    };
  }
}
