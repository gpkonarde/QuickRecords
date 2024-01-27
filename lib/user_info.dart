class Users {
  String aadhar, name, mobile, bankName, type, amount;

  Users(this.aadhar, this.name, this.mobile, this.bankName, this.type, this.amount);

  // Json to Object
  Users.fromJson(Map<String, dynamic> json)
      : aadhar = json['aadhar'],
        name = json['name'],
        mobile = json['mobile'],
        bankName = json['bankName'],
        type = json['type'],
        amount = json['amount'];

  // Object to Json
  Map<String, dynamic> toJson() {
    return {
      'aadhar': aadhar,
      'name': name,
      'mobile': mobile,
      'bankName': bankName,
      'type': type,
      'amount': amount,
    };
  }
}

