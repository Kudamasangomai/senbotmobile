import 'package:flutter/material.dart';
import 'package:senbot/pages/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/basepage.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
            future: SharedPreferences.getInstance(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Text('error');
              } else if (snapshot.hasData) {
                final String ? token = snapshot.data!.getString('token');
                if (token != null) {
                  return const BasePage();
                } else {
                  return const LoginPage();
                  
                }
              } else {
                return const LoginPage();
              }
            })));
  }
}
