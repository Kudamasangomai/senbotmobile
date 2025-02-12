import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/repair.dart';
import 'detailedrepair.dart';

class RepairsPage extends StatefulWidget {
  const RepairsPage({super.key});

  @override
  State<RepairsPage> createState() => _RepairsPageState();
}

class _RepairsPageState extends State<RepairsPage> {
  late SharedPreferences preferences;
  bool isLoading = false;
  bool isUnauthorized = false;

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

  final List<Repair> repairs = [];
  Future getRepairs() async {
    var token = preferences.getString('token');
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      var response = (await http.get(
        Uri.https('senbot.co.zw', '/api/repairs'),
        // Uri.http('10.0.2.2:8000', '/api/repairs'),
        headers: headers,
      ));

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body) as Map<String, dynamic>;
        var jsondata = responseData['data'] as List<dynamic>;

        for (var eachrepair in jsondata) {
          final repair = Repair(
            jobnumber: eachrepair['jobnumber'],
            fleetId: eachrepair['fleet_id'],
            fleetNo: eachrepair['fleet']['fleetno'],
            name: eachrepair['fault']['name'],
            status: eachrepair['status'],
            username: eachrepair['user']['name'],
          );

          repairs.add(repair);
        }
      } else if (response.statusCode == 401) {
        setState(() {
          isUnauthorized = true;
        });
      } else {
        // print('Error: ${response.statusCode}');

        return [];
      }
    } catch (e) {
      // print(e);
    }
  }
    Color _getStatus(String status) {
    if (status == 'Completed') {
      return Colors.green;
    } else if (status == 'Work In Progress') {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (isUnauthorized) {
      // Show unauthorized error widget
      return const Center(
        child: Text(
          'Unauthorized!',
          style: TextStyle(fontSize: 16),
        ),
      );
    } else {
      return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.blue,
            child: const Icon(Icons.add_task),
          ),
          body: FutureBuilder(
            future: getRepairs(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemCount: repairs.length,
                  itemBuilder: (context, index) {
                    final repair = repairs[index];
                    // var repair = repairs[index];
                    // var fleetNo = repair.fleetNo;
                    return Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.transparent,
                              spreadRadius: 1,
                              blurRadius: 1,
                            )
                          ],
                        ),
                        child: GestureDetector(
                          child: Card(
                            color: const Color.fromARGB(255, 118, 187, 243),
                            //  color: const Color.fromARGB(255, 194, 222, 245),
                            elevation: 20, // Elevation for the 3D effect
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  1), // Rounded corners for the Card
                            ),
                            child: ListTile(

                                //  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                leading: Container(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              width: 1.0,
                                              color: Colors.white))),
                                  child: const Icon(
                                    Icons.car_repair,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    size: 40,
                                  ),
                                ),
                                title: Text(
                                  repairs[index].fleetNo,
                                  style: const TextStyle(color: Colors.black),
                                ),
                                subtitle: Row(
                                  children: [
                                    // Container(
                                     
                                    //   width: 20,
                                    //   height: 10,
                                    //   decoration: const BoxDecoration(
                                    //     shape: BoxShape.circle,
                                    //     color: Colors.red,
                                    //       //  color: _getStatus( repairs[index].status),
                                    //   ),
                                    // ), 
                                    Text(repairs[index].name),
                                 
                                  ],
                                ),
                                trailing: const Icon(Icons.keyboard_arrow_right,
                                    color: Colors.white, size: 30.0)),
                          ),
                          onTap: () {
                            // detailedrepair(
                            //     context, repairs[index].jobnumber, index);
                            // debugPrint(repairs[index].fleetNo);
                            {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => DetailedRepair(
                                      jobnumber: repair.jobnumber,
                                      repairobj: repairs[index]),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ));
    }
  }
}
