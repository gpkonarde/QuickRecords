import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quickrecord/Views/list_transaction_view.dart';
import 'package:quickrecord/controller/data_controller.dart';
import 'package:quickrecord/database/data_functions.dart';
import 'package:quickrecord/user_info.dart';
import 'package:quickrecord/view_transaction.dart';
import 'package:quickrecord/widget/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _formKey = GlobalKey<FormState>();

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FormControllers formControllers = FormControllers();
  String? selectBank;
  String? selectType;

  late SharedPreferences sharedPreferences;
  List<Users> usersList = [];

  @override
  void initState() {
    super.initState();
    initialGetSavedData();
  }

  void initialGetSavedData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String? usersListString = sharedPreferences.getString('usersList');
    if (usersListString != null) {
      List<Map<String, dynamic>> usersListMap =
      List<Map<String, dynamic>>.from(jsonDecode(usersListString));
      usersList =
          usersListMap.map((userMap) => Users.fromJson(userMap)).toList();
      setState(() {});
    }
  }

  void onPreview() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => TransactionListView()));
  }

  Future<void> onSave() async {
    if (_formKey.currentState!.validate() && _formKey.currentState != null) {
      Users user = Users(
        formControllers.aadharController.text,
        formControllers.nameController.text,
        formControllers.mobileController.text,
        selectBank ?? '',
        selectType ?? '',
        formControllers.amountController.text,
      );

      bool userExists = usersList.any((existingUser) =>
      existingUser.aadhar == user.aadhar &&
          existingUser.name == user.name &&
          existingUser.mobile == user.mobile &&
          existingUser.bankName == user.bankName &&
          existingUser.type == user.type &&
          existingUser.amount == user.amount);

      if (!userExists) {
        usersList.add(user);
        await UserDataStorage.saveUserData(usersList);


        DataController dataController = DataController();
        dataController.submitForm(user, (status) {
          if (status == DataController.STATUS_SUCCESS) {
            print('Data saved to Google Sheet');
          } else {
            print('Failed to save data to Google Sheet');
          }
        });
      }
    }
  }


  void onReset() {
    setState(() {
      selectBank = null;
      selectType = null;
    });
    formControllers.aadharController.clear();
    formControllers.nameController.clear();
    formControllers.mobileController.clear();
    formControllers.amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    // Return a Scaffold widget with your desired structure
    return Scaffold(
      appBar: CustomAppBar(
        title: 'QuickRecords',
        showBackButton: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: TextFormField(
                        controller: formControllers.aadharController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            labelText: 'Aadhar'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Something';
                          }
                          if (int.tryParse(value) == null ||
                              value.length != 4) {
                            return 'Enter Valid Aadhar';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: TextFormField(
                        controller: formControllers.nameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            labelText: 'FullName'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter something';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: TextFormField(
                        controller: formControllers.mobileController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            labelText: 'Mobile'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter something';
                          }
                          if (int.tryParse(value) == null ||
                              value.length != 10) {
                            return 'Enter Valid Contact Number';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: DropdownButtonFormField(
                          value: selectBank,
                          items: [
                            DropdownMenuItem(
                                value: 'SBI',
                                child: Text('State Bank of India')),
                            DropdownMenuItem(
                                value: 'PNB',
                                child: Text('Punjab National Bank')),
                            DropdownMenuItem(
                                value: 'BOB', child: Text('Bank of Baroda')),
                            DropdownMenuItem(
                                value: 'UBI',
                                child: Text('Union Bank of India')),
                            DropdownMenuItem(
                                value: 'BOI', child: Text('Bank of India')),
                            DropdownMenuItem(
                                value: 'Canara', child: Text('Canara Bank')),
                            DropdownMenuItem(
                                value: 'IOB',
                                child: Text('Indian Overseas Bank')),
                            DropdownMenuItem(
                                value: 'UCO', child: Text('UCO Bank')),
                            DropdownMenuItem(
                                value: 'IDBI', child: Text('IDBI Bank')),
                            DropdownMenuItem(
                                value: 'Bank Of Maharashtra',
                                child: Text('Bank Of Maharashtra')),
                            DropdownMenuItem(
                                value: 'Central',
                                child: Text('Central Bank of India')),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Choose a Bank';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              labelText: '--Select Bank--'),
                          onChanged: (newValue) {
                            setState(() {
                              selectBank = newValue as String?;
                            });
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: DropdownButtonFormField(
                          value: selectType,
                          items: [
                            DropdownMenuItem(
                                value: 'Withdraw',
                                child: Text('Withdrwa / Debit')),
                            DropdownMenuItem(
                                value: 'Credit',
                                child: Text('Credit')),
                            ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Choose a Transaction';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              labelText: '--Select Transaction--'),
                          onChanged: (newwValue) {
                            setState(() {
                              selectType = newwValue as String?;
                            });
                          }),
                    ),

                    Padding(
                      padding: EdgeInsets.all(8),
                      child: TextFormField(
                        controller: formControllers.amountController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            labelText: 'Amount'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter something';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Enter a valid amount';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(top: 16.0), // Adjust margin as needed
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FloatingActionButton(
                            heroTag:'btn1',
                            onPressed: () {
                              if (_formKey.currentState!.validate() &&
                                  _formKey.currentState != null) {
                                onSave();
                              }
                            },
                            child: Text('Save'),
                          ),
                          SizedBox(width: 16),
                          FloatingActionButton(
                            heroTag: 'btn2',
                            onPressed: onReset,
                            child: Text('Reset'),
                          ),
                          SizedBox(width: 16,),
                          FloatingActionButton(
                            heroTag: 'btn3',
                            onPressed: onPreview,
                            child: Text('Preview'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
