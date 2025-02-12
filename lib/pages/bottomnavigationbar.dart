import 'package:flutter/material.dart';
import 'package:senbot/pages/homepage.dart';
import 'package:senbot/pages/repairs.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

// void _dashboardpage(BuildContext context) {
//   // final currentRoute = ModalRoute.of(context)?.settings.name;

//   const String homePageRoute = '/homepage';
//   // Get the current route
//   final currentRoute = ModalRoute.of(context)?.settings.name;

//   if (currentRoute != homePageRoute) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const HomePage(),
//       ),
//     );
//   }
// }

// void _repairspage(BuildContext context) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => const RepairsPage(),
//     ),
//   );
// }

class _BottomNavBarState extends State<BottomNavBar> {
  List pages = const [HomePage(), RepairsPage()];
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
    
      bottomNavigationBar: BottomNavigationBar(
        
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          backgroundColor: Colors.blue,
          items: const [
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
        ),
      );
  }
}
