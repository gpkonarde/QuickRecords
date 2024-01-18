import 'package:flutter/material.dart';

final _formKey = GlobalKey<FormState>();

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final TextEditingController _aadharFieldController = TextEditingController();
  final TextEditingController _nameFieldController = TextEditingController();
  final TextEditingController _mobileFieldController = TextEditingController();
  final TextEditingController _amountFieldController = TextEditingController();
  String? selectBank;


  void onReset(){
    setState(() {
      selectBank = null;
    });
    _aadharFieldController.clear();
    _nameFieldController.clear();
    _mobileFieldController.clear();
    _amountFieldController.clear();
  }

  @override
  Widget build(BuildContext context) {
    // Return a Scaffold widget with your desired structure
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0.8,
        title: Text(
          'QuickRecords',
          style: TextStyle(
            color: Colors.white,
          ),
        ), //TODO : Implement CustomAppBar class
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(12),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _aadharFieldController,
                    decoration: InputDecoration(hintText: 'Aadhar'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Something';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _nameFieldController,
                    decoration: InputDecoration(hintText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter something';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _mobileFieldController,
                    decoration: InputDecoration(hintText: 'Mobile No'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter something';
                      }
                      return null;
                    },
                  ),

                  // DropDown to choose bank

                  DropdownButtonFormField(
                    value: selectBank,
                      items: [
                        DropdownMenuItem(value: 'Home',child: Text('Home')),
                        DropdownMenuItem(value: 'Other',child: Text('Other')),
                      ],
                      validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Choose a Bank';
                      }
                      return null;
                      },
                      decoration: InputDecoration(
                        hintText: '--Select Bank--',
                      ),
                      onChanged: (newValue){
                      setState(() {
                        selectBank = newValue as String?;
                      });
                      }
                  ),

                  TextFormField(
                    controller: _amountFieldController,
                    decoration: InputDecoration(hintText: 'Amount'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter something';
                      }
                      return null;
                    },
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16.0), // Adjust margin as needed
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton(
                          onPressed: () {},
                          child: Text('Save'),
                        ),
                        SizedBox(width: 16),
                        FloatingActionButton(
                          onPressed: onReset,
                          child: Text('Reset'),
                        ),
                      ],
                    ),
                  )

                ],
              ),
            )),
      ),
    );
  }
}
