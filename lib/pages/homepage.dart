import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences preferences;
  bool isLoading = false;
  int totalRepairs = 0;
  int statusOpen = 0;
  int workInProgress = 0;
  int repairCompleted = 0;

  @override
  void initState() {
    super.initState();
    initializePreferences();
    getTotals();
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

  Future getTotals() async {
    

    var response = (await http.get(
      Uri.http('10.0.2.2:8000', '/api/totals'),
      //  Uri.https('senbot.co.zw', '/api/totals'),
      headers: {
        'Charset': 'utf-8',
        'Accept': 'application/json',
        // 'Authorization':'Bearer ${preferences.getString('token').toString()}',
        
      },
    ));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);

      setState(() {
        totalRepairs = jsonResponse['totalrepairs'];
        statusOpen = jsonResponse['status_open'];
        workInProgress = jsonResponse['workinprogress'];
        repairCompleted = jsonResponse['repair_completed'];
      });
    } else {
      // print('Error: ${response.statusCode}');

      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return


        SingleChildScrollView(
      child: Column(
        children: [
          const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15, top: 15),
                child: Text(
                  'Dashboard',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )),
          // child: Text('name: ${preferences.getString('name').toString()}  ')),
          //  Center(child: Text('is Admin: ${preferences.getInt('isAdmin')}  ')),
           Center(child: Text('Token: ${preferences.getString('token').toString()}  ')),
          GridView.count(
            padding: const EdgeInsets.all(12),
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 1.5,
            shrinkWrap: true,
            children: [
              Card(
                elevation: 50,
                shadowColor: Colors.grey,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 194, 222, 245),
                    border: Border(
                        left: BorderSide(
                      width: 5.0,
                      color: Colors.blue,
                    )),
                    //  borderRadius: BorderRadius.only(
                    //    topLeft: Radius.circular(10.0),
                    //  ),
                  ),
                  padding: const EdgeInsets.all(10),
                  // color: const Color.fromARGB(255, 194, 222, 245),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Total Repairs',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(height: 15),
                          const Icon(
                                    Icons.car_repair,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    size: 40,
                                  ),
                                      const SizedBox(width: 5),
                          Text(
                            '$totalRepairs',
                            style: const TextStyle(
                              fontSize: 35,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 50,
                shadowColor: Colors.grey,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  // color: const Color.fromARGB(255, 194, 222, 245),

                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 194, 222, 245),
                      border: Border(
                          left: BorderSide(
                        width: 5.0,
                        color: Colors.red,
                      ))),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Not Assigned',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,

                        children: [
                          const SizedBox(height: 15),
                           const Icon(
                                    Icons.person_add_disabled_outlined,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    size: 40,

                                  ),
                                      const SizedBox(width: 5),
                          Text(
                            '$statusOpen',
                          
                            style: const TextStyle(
                              fontSize: 35,
                              color: Colors.black,

                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 50,
                shadowColor: Colors.grey,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 194, 222, 245),
                      border: Border(
                          left: BorderSide(
                        width: 5.0,
                        color: Colors.orange,
                      ))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Work In Progress',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(height: 15),
                           const Icon(
                                    Icons.timelapse_outlined,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                        size: 40,
                                  ),
                                      const SizedBox(width: 5),
                          Text(
                            '$workInProgress ',
                            style: const TextStyle(
                              fontSize: 35,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 50,
                shadowColor: Colors.grey,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 194, 222, 245),
                      border: Border(
                          left: BorderSide(
                        width: 5.0,
                        color: Colors.green,
                      ))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Completed',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(height: 15),
                            const Icon(
                                    Icons.task_alt_outlined,
                                    // color: Color.fromARGB(255, 0, 0, 0),
                                        size: 40,
                                  ),
                                  const SizedBox(width: 5),
                          Text(
                            '$repairCompleted',
                            style: const TextStyle(
                              fontSize: 35,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                child: Text(
                  'Latest Repairs',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
              )              ,
          Container(
            margin: const EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
            child: Table(
              defaultColumnWidth: const FixedColumnWidth(125.0),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              
              children: [
                TableRow(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(51, 61, 61,
                        61), // Set the background color for the header
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: const [
                          Text(
                            'Job #',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: const [
                          Text(
                            'Asset',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: const [
                          Text(
                            'Fault',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: const [
                        Text('2632457'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: const [
                        Text('955 Golf ABB 1025'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: const [
                        Text('GT Not Reporting'),
                      ],
                    ),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Column(
                      children: const [
                        Text('256398'),
                      ],
                    ),
                  ),
                  Column(
                    children: const [
                      Text('955 Golf ABB 1025'),
                    ],
                  ),
                  Column(
                    children: const [
                      Text('No Rpm'),
                    ],
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Column(
                      children: const [
                        Text('848322'),
                      ],
                    ),
                  ),
                  Column(
                    children: const [
                      Text('484 Delta AAZ 5656'),
                    ],
                  ),
                  Column(
                    children: const [
                      Text(
                        'Inspect Probe',
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ]),
           
              ],
            ),
          ),
        ],
      ),
    );
    // );
  }
}
