import 'dart:convert';

import 'package:http/http.dart' as http;



Future<List<dynamic>> fetchrepairs() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/repairs'));
  
  if (response.statusCode == 200) {
    final List<dynamic> repairs = json.decode(response.body)['data'];
    return repairs;
  } else {
    throw Exception('Failed to fetch repairs');
  }
}