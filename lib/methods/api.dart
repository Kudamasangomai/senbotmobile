import 'dart:convert';

// import 'package:helpers/helpers.dart';
import '../helper/constants.dart';
import 'package:http/http.dart' as http;

class API {
  postRequest({
    required String route,
    required Map<String, String> data,
  }) async {
    String url = apiUrl + route;
    // try {
      return  http.post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: _header(),
      );
  }


   getRequest({
    required String route,
    required Map<String, String> data,
  }) async {
    String url = apiUrl + route;
    // try {
      return  http.get(
        Uri.parse(url),
        headers: _header(),
      );
 
  }

  _header() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
}
