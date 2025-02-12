// import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';
import 'dart:convert';
import '../model/repair.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:senbot/pages/basepage.dart';

class DetailedRepair extends StatefulWidget {
  final int? jobnumber;
  const DetailedRepair(
      {Key? key, required this.repairobj, required this.jobnumber})
      : super(key: key);
  final Repair repairobj;
  @override
  State<DetailedRepair> createState() => _DetailedRepairState();
}

class _DetailedRepairState extends State<DetailedRepair> {
  late SharedPreferences preferences;
  bool isLoading = false;
  Map<String, dynamic>? repairData;

  @override
  void initState() {
    super.initState();
    initializeState();
    // fetchRepairData();
  }

  Future<void> initializeState() async {
    setState(() {
      isLoading = true;
    });
    await initializePreferences();
    await fetchRepairData();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> initializePreferences() async {
    preferences = await SharedPreferences.getInstance();
  }

  Future<void> fetchRepairData() async {
    var token = preferences.getString('token');
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
      

    try {
      final response = await http.get(
        Uri.https('senbot.co.zw', '/api/repairs/${widget.jobnumber}'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final reponseData = json.decode(response.body);

        setState(() {
          repairData = reponseData;
  

          print(repairData);
        });
      } else {
        debugPrint(' ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint('Error: $e');
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text("Senbot"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const BasePage(),
                ),
              );
            },
          ),
        ),
        body: repairData != null
                ? Column(children: [
              Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 250,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/jc2.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(children: [
                    BackdropFilter(
                      filter: ImageFilter.blur(
                          sigmaX: 0,
                          sigmaY:
                              0), // Adjust the sigma values for desired blur intensity
                      child: Container(
                        color: Colors.black.withOpacity(
                            0.7), // Set the desired color with opacity for the blurred background
                      ),
                    ),
                    Center(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Jobcard Details',
                              style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                  letterSpacing: 5.0),
                            ),
                            const SizedBox(height: 4.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //  SizedBox(width: 50.0),
                                Text(
                                  '#${repairData?['data'][0]['jobnumber']}',
                                  style: const TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                      letterSpacing: 5.0),
                                ),
                              ],
                            ),
                          ]),
                    ),
                  ])),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(top: 40, right: 14, left: 14),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Row(children: [
                            //   Text(
                            //     'Jobcard #',
                            //     style: TextStyle(
                            //       fontSize: 18,
                            //       color: Colors.black,
                            //     ),
                            //   ),
                            //   Text(
                            //     // repairobj.jobnumber.toString(),
                            //     widget.repairobj.jobnumber.toString(),
                            //     style: TextStyle(
                            //       fontSize: 18,
                            //       color: Colors.black,
                            //     ),
                            //   ),
                            // ]),
                            const SizedBox(height: 15),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Fleet No ',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '${repairData?['data'][0]['fleet']['fleetno']}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                //   Text(
                                //   '${repairData?['data'][0]['fault']['name']}',
                                //   style: TextStyle(
                                //      fontSize: 20,
                                //     fontWeight: FontWeight.w600,
                                //   ),
                                // ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Fault ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '${repairData?['data'][0]['fault']['name']}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Status ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '${repairData?['data'][0]['status']}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Techs ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'coming soon',
                                  // '${repairData?['data'][0]['users']['name']}',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
//                       Row(
//   mainAxisAlignment: MainAxisAlignment.start,
//   children: [
//     Text(
//       'Created @:',
//       style: TextStyle(
//         fontSize: 20,
//         fontWeight: FontWeight.w600,
//       ),
//     ),
//     Flexible(
//       child: Text(
//         '${repairData?['data'][0]['created_at']}',
//         style: TextStyle(
//           fontSize: 20,
//         ),
//       ),
//     ),
//   ],
// ),
                            const SizedBox(height: 15),
                            Container(
                              // height: MediaQuery.of(context).size.height * .35,
                              padding:
                                  const EdgeInsets.only(bottom: 30, top: 20),
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: Text(
                                'Other Repairs for ${repairData?['data'][0]['fleet']['fleetno']}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const Text(
                              'coming soon',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 150),
                            Text(
                              widget.repairobj.workdone.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: 100,
                        height: 5,
                        decoration: BoxDecoration(
                          color: _getStatus(repairData?['data'][0]['status']),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ])
        //     Column(
        //   children: [
        //     Text('Jobnumber: ${repairData?['data'][0]['jobnumber']}'),
        //     Text('Fleet Number: ${repairData?['data'][0]['fleet']['fleetno']}'),
        //     Text('Fault: ${repairData?['data'][0]['fault']['name']}'),
        //     Text('Status: ${repairData?['data'][0]['status']}'),
        //     Text('Solved: ${repairData?['data'][0]['solved']}'),
        //     Text('workDone: ${repairData?['data'][0]['workdone']}'),
        //     Text('Created At: ${repairData?['data'][0]['created_at']}'),

        //     // Add more details as needed
        //   ],
        // )
        : const Center(child: CircularProgressIndicator()),
        );
  }
}
