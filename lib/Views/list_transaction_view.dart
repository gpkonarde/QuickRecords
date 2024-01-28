import 'package:flutter/material.dart';
import 'package:quickrecord/database/data_functions.dart';
import 'package:quickrecord/user_info.dart';
import 'package:quickrecord/view_transaction.dart';
import 'package:quickrecord/widget/widgets.dart';

class TransactionListView extends StatefulWidget {
  @override
  _TransactionListViewState createState() => _TransactionListViewState();
}

class _TransactionListViewState extends State<TransactionListView> {
  List<Users> usersList = [];

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    try {
      List<Users> loadedUserData = await UserDataStorage.loadUserData();
      setState(() {
        usersList = loadedUserData;
      });
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Set<String> uniqueAadharNumbers = Set();

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Transaction List',
      ),
      body: ListView.builder(
        itemCount: usersList.length,
        itemBuilder: (context, index) {
          Users user = usersList[index];

          if (!uniqueAadharNumbers.contains(user.aadhar)) {
            uniqueAadharNumbers.add(user.aadhar);

            return Padding(
              padding: EdgeInsets.only(top: 10, bottom: 8, left: 8, right: 8),
              child: ListTile(
                title: Text(user.name),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                subtitle: Text('ID: ${user.aadhar}'),
                trailing: Text('${user.type}: ${user.amount}'),
                tileColor: Color(0xFFE0E0E0),
                onTap: () async {
                  String tappedAadhar = user.aadhar ?? '';
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewTransaction(
                        aadharFilter: tappedAadhar,
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
