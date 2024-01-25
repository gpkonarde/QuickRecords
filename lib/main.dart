import 'package:flutter/material.dart';
import 'package:quickrecord/view_transaction.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'home',
      routes: {
        'home':(context) => Home(),
        'view':(context) => ViewTransaction()
      },
      title: 'QuickRecords',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white, // Set the background color here
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

