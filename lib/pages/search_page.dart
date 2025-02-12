import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: const [
            TextField(
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.blue,
                      size: 25,
                    ), // border: InputBorder.none,
                    hintText: 'Search Here',
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                         Radius.circular(20.0) ),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        )),
                              focusedBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.all(
                         Radius.circular(20.0) ),
                      borderSide: BorderSide(
                        color: Colors.blue
                        
                      )

                      ),
                  
                  
                    contentPadding: EdgeInsets.all(20))),
          ]
          )
          ),
    );
  }
}
