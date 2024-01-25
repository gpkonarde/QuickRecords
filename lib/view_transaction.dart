import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quickrecord/widget/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewTransaction extends StatefulWidget {
  const ViewTransaction({Key? key}) : super(key: key);

  @override
  _ViewTransactionState createState() => _ViewTransactionState();
}

class _ViewTransactionState extends State<ViewTransaction> {
  late SharedPreferences sharedPreferences;
  List<Map<String, dynamic>> transactionHistory = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String? transactionHistoryString =
    sharedPreferences.getString('transactionHistory');

    if (transactionHistoryString != null) {
      transactionHistory =
      List<Map<String, dynamic>>.from(jsonDecode(transactionHistoryString));
      setState(() {});
    }
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
                            padding: EdgeInsets.all(8), child: Text('Aadhar'))),
                    TableCell(
                        child: Padding(
                            padding: EdgeInsets.all(8), child: Text('Name'))),
                    TableCell(
                        child: Padding(
                            padding: EdgeInsets.all(8), child: Text('Mobile'))),
                    TableCell(
                        child: Padding(
                            padding: EdgeInsets.all(8), child: Text('Bank'))),
                    TableCell(
                        child: Padding(
                            padding: EdgeInsets.all(8), child: Text('Amount'))),
                  ],
                ),
                for (Map<String, dynamic> transaction in transactionHistory)
                  TableRow(
                    children: [
                      TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(transaction['aadhar'] ?? 'N/A'),
                          )),
                      TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(transaction['name'] ?? 'N/A'),
                          )),
                      TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(transaction['mobile'] ?? 'N/A'),
                          )),
                      TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(transaction['bank'] ?? 'N/A'),
                          )),
                      TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(transaction['amount'] ?? 'N/A'),
                          )),
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
