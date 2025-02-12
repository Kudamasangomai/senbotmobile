import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:senbot/pages/repairs.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  late SharedPreferences preferences;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initializePreferences();
  }

  Future<void> initializePreferences() async {
    setState(() {
      isLoading = true;
    });
    preferences = await SharedPreferences.getInstance();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> logoutUser(BuildContext context) async {
  
    // final url = Uri.parse('http://10.0.2.2:8000/api/logout');
     final url = Uri.parse('https://senbot.co.zw/api/logout');
    // final result = await http.post(url);

    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${preferences.getString('token').toString()}'
      },
    );
    final responsee = json.decode(response.body);
    if (response.statusCode == 200) {
        preferences.clear();
      debugPrint('Logout successful');
      if (context.mounted) {
        String message = responsee['message'];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            margin: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
            behavior: SnackBarBehavior.floating,
            content: Text(
              message,
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.remove('token');
      print('Logout successful');
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      }
    } else {
      print('Response: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // ignore: unrelated_type_equality_checks
    if (preferences == '') {
      return const Center(
        child: Text('Preferences not initialized'),
      );
    }
    return Drawer(
      elevation: 10,
      backgroundColor: Colors.blue,
      width: 240,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.black, // Set the desired background color

                    image: DecorationImage(
                      image: AssetImage('images/mori.jpg'),
                      fit: BoxFit.cover,
                      opacity: 0.5,
                    ),
                  ),
                  accountName: Text(
                    '${preferences.getString('name').toString()} ',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  accountEmail:
                      Text('${preferences.getString('email').toString()} '),
                  currentAccountPicture: const CircleAvatar(
                    child: Icon(
                      Icons.person_outline,
                      size: 60,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const ListTile(
                  leading: Icon(
                    Icons.home,
                    size: 30,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Dashboard',
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      color: Colors.white,
                      fontSize: 18,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const RepairsPage(),
                      ),
                    );
                  },
                  child: const ListTile(
                    leading: Icon(
                      Icons.medication,
                      size: 30,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Repairs',
                      style: TextStyle(
                        fontStyle: FontStyle.normal,
                        color: Colors.white,
                        fontSize: 18,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const ListTile(
                  leading: Icon(
                    Icons.person,
                    size: 30,
                    color: Colors.white,
                  ),
                  title: Text(
                    'MyRepairs',
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      color: Colors.white,
                      fontSize: 18,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const ListTile(
                  leading: Icon(
                    Icons.propane_tank_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Tanks',
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      color: Colors.white,
                      fontSize: 18,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const ListTile(
                  leading: Icon(
                    Icons.people,
                    size: 30,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Users',
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      color: Colors.white,
                      fontSize: 18,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              debugPrint('Logout tapped');
              logoutUser(context);
            },
            child: const ListTile(
              leading: Icon(
                Icons.logout_rounded,
                size: 30,
                color: Colors.white,
              ),
              title: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
