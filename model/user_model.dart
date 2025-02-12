import 'dart:convert';

// final data = json[0]['id'];

List<Welcome> welcomeFromJson(String str) =>
    List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));
    
    class Welcome {
      static fromJson(x) {}
    }
