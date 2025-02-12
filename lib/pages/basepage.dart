import 'package:flutter/material.dart';
import 'package:senbot/pages/homepage.dart';
import 'package:senbot/pages/notifications.dart';
import 'package:senbot/pages/repairs.dart';
import 'package:senbot/pages/search_page.dart';
import 'baseappbar.dart';
import 'sidebar.dart';

class BasePage extends StatefulWidget {
  const BasePage( {super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  List pages = const [HomePage(), RepairsPage(), SearchPage() , Notifications()];
  int currentpage = 0;
  void ontap(int index) {
    setState(() {
      currentpage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppbAr(),
      drawer: const SideBar(),
      body: pages[currentpage],
      bottomNavigationBar: BottomNavigationBar(
        
        onTap: ontap,
        currentIndex: currentpage,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.3),
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        backgroundColor: Colors.blue,
        elevation: 10,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.apps,
            ),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services),
            label: 'Repairs',
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
        ],
      ),
    );
  }
}
