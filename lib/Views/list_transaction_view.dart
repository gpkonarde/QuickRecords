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
  Set<String> uniqueAadharNumbers = Set();

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
        updateUniqueAadharNumbers();
      });
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  // Update the uniqueAadharNumbers set with all Aadhar numbers in usersList
  void updateUniqueAadharNumbers() {
    uniqueAadharNumbers.clear();
    for (Users user in usersList) {
      uniqueAadharNumbers.add(user.aadhar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Transaction List',
      ),
      body: ListView.builder(
        itemCount: uniqueAadharNumbers.length,
        itemBuilder: (context, index) {
          String aadhar = uniqueAadharNumbers.elementAt(index);
          Users user = usersList.firstWhere((u) => u.aadhar == aadhar);

          return Padding(
            padding: EdgeInsets.only(top: 10, bottom: 8, left: 8, right: 8),
            child: ListTile(
              title: Text(user.name),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              subtitle: Text('ID: xxxxxxxx$aadhar'),
              trailing: Text('${user.type}: ${user.amount}'),
              tileColor: Color(0xFFE0E0E0),
              onTap: () async {
                String tappedAadhar = aadhar ?? '';
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
        },
      ),
    );
  }
}
