import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quickrecord/Views/list_transaction_view.dart';
import 'package:quickrecord/database/data_functions.dart';
import 'package:quickrecord/user_info.dart';
import 'package:quickrecord/widget/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewTransaction extends StatefulWidget {
  const ViewTransaction({Key? key}) : super(key: key);

  @override
  _ViewTransactionState createState() => _ViewTransactionState();
}

class _ViewTransactionState extends State<ViewTransaction> {
  late SharedPreferences sharedPreferences;
  var usersDataList = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    usersDataList = await UserDataStorage.loadUserData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Transaction History',
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Table(
              border: TableBorder.all(
                color: Colors.black,
              ),
              defaultVerticalAlignment: TableCellVerticalAlignment.top,
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Colors.blueAccent),
                  children: [
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('Aadhar'),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('Name'),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('Mobile'),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('Bank'),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('Transaction Type'),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('Amount'),
                      ),
                    ),
                  ],
                ),
                for (Users user in usersDataList)
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(user.aadhar ?? 'N/A'),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(user.name ?? 'N/A'),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(user.mobile ?? 'N/A'),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(user.bankName ?? 'N/A'),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(user.type ?? 'N/A'),
                        ),
                      ),
                      TableCell(
                        child: Container(
                            color: user.type == 'Withdraw'
                                ? Colors.red
                                : (user.type == 'Credit' ? Colors.green : null),
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(user.amount ?? 'N/A'),
                            )),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
