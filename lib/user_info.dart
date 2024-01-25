class Users {
  String name, bankName;
  String aadhar, mobile, amount;

  Users(this.name, this.bankName, this.aadhar, this.mobile, this.amount);

  // Json to Object
  Users.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        bankName = json['bankName'],
        aadhar = json['aadhar'],
        mobile = json['mobile'],
        amount = json['amount'];

  // Object to Json
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'bankName': bankName,
      'aadhar': aadhar,
      'mobile': mobile,
      'amount': amount,
    };
  }
}
