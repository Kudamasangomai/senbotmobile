import 'package:flutter/material.dart';

class BaseAppbAr extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const BaseAppbAr({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      title: const Text("Senbot"),
      
    );
    
  }
}
