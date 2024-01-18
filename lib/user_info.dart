import 'dart:convert';

import 'package:flutter/material.dart';

class Users{
  String name, bankName;
  String aadhar, mobile;

  Users(this.name, this.bankName, this.aadhar, this.mobile);

  // Json to Object
  Users.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        bankName = json['bankName'],
        aadhar = json['aadhar'],
        mobile = json['mobile'];

  // Object to Json
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'bankName': bankName,
      'aadhar': aadhar,
      'mobile': mobile,
    };
  }
}