import 'package:flutter/material.dart';
import 'package:senbot/pages/homepage.dart';
import 'package:senbot/pages/repairs.dart';


class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}




void _dashboardpage(BuildContext context) {
  // final currentRoute = ModalRoute.of(context)?.settings.name;

    const String homePageRoute = '/homepage';  
  // Get the current route
  final currentRoute = ModalRoute.of(context)?.settings.name;

  if (currentRoute != homePageRoute) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }
}

void _repairspage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const RepairsPage(),
    ),
  );
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: const BoxDecoration(
      //   // boxShadow: [
      //   // BoxShadow(color: Colors.white,spreadRadius: 1, blurRadius: 5)
      //   // ]
      // ),
      padding: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BottomNavigationBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          backgroundColor: Colors.blue,
          items: 
          const <BottomNavigationBarItem>
          [
            // BottomNavigationBarItem(icon: icon),
            BottomNavigationBarItem(
              icon: Icon(
                color: Colors.white,
                Icons.home,
              ),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.medical_services),
              label: 'Repairs',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          onTap: (int index) {
            // Handle the tap event for the bottom navigation bar
            if (index == 1) {
              // "Repairs" tab is tapped
              _repairspage(context);
            } else if (index == 0) {
              // _dashboardpage(context);
              _dashboardpage(context);
            }
          },
        ),
      ),
    );
  }
}
