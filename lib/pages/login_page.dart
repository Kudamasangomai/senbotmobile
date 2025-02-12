import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../methods/api.dart';
import 'basepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  bool isLoading = false;
  late Timer _timer;
   
  Future<void> loginUser(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
       _timer = Timer(const Duration(seconds: 60), () {
  if (mounted) {
    setState(() {
      isLoading = false;
    });

    // Display an error message or prompt the user to try again
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        title: const Text('Timeout'),
        content: const Text('The login process took too long. Please try again.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
});

    final data = {
      'email': email.text.toString(),
      'password': password.text.toString(),
    };

    final result = await API().postRequest(route: '/login', data: data);
    final response = json.decode(result.body);

    if (response['status'] == 200) {
      // String token= response['token'];
      // String user = response['user'];
      // String message = response['message'];
      // String email = response["email"];
      // int isAdmin = response["is_admin"];
      SharedPreferences preferences = await SharedPreferences.getInstance();

      await preferences.setString('name',response['user']);
      await preferences.setString('email',response['email']);
      await preferences.setString('token', response['token']);
      // await preferences.setInt('isAdmin',response['isAdmin']);
      if (context.mounted) {
        debugPrint(response['message']);
        ScaffoldMessenger.of(context).showSnackBar(
          
          SnackBar(
            
            margin: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
            behavior: SnackBarBehavior.floating,

            content: Text(
              response['message'],
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const BasePage()));
      }
    } else {
      String message = response['message'];

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            behavior: SnackBarBehavior.floating,
            dismissDirection: DismissDirection.horizontal,
            content: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            backgroundColor: Colors.red,
          ),
        );
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 120),
            ),
            const SizedBox(height: 20),
            const Text(
              'SenBot',
              style: TextStyle(
                  fontSize: 20, letterSpacing: 4, fontWeight: FontWeight.w500),
           
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  'images/sendem-logo.png', // Replace with your image path
                  width: 150,
                  height: 100,
                ),
              ],
            ),
            const SizedBox(height: 40),
            TextField(
              controller: email,
              decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.email_outlined,
                    color: Colors.blue,
                    size: 30,
                  ),
                  border: InputBorder.none,
                  hintText: 'Enter Email',
                  hintStyle: TextStyle(
                    color: Colors.black54,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.blue)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.blue)),
                  fillColor: Colors.transparent,
                  filled: true,
                  contentPadding: EdgeInsets.all(20)),
            ),
            const SizedBox(height: 40),
            TextField(
              obscureText: true,
              controller: password,
              decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.lock_outline,
                    color: Colors.blue,
                    size: 30,
           
                   
                      
                  ), // border: InputBorder.none,
                  hintText: 'Enter Password',
                  hintStyle: TextStyle(
                    color: Colors.black54,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                        color: Colors.blue,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.blue)),
                  contentPadding: EdgeInsets.all(20)),
            ),
                const SizedBox(height:20 ),
        

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                 Text(
                  "Forgot Password",
                 
                  style: TextStyle(
                    fontStyle: FontStyle.normal,
                    color: Colors.blue,
                    fontSize: 18,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                loginUser(context);
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                   if (!isLoading)
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(1, 1),
                        ),
                      ],
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                      shape: BoxShape.rectangle,
                      border: Border.all(color: Colors.white),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            letterSpacing: 2,
                            fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width:15), // Add spacing between the icon and the text
                        Icon(
                          Icons.login_outlined,
                          color: Colors.white,
                          size: 30,
                         
                        ),
                      ],
                    ),
                  ),
                  if (isLoading)
                    const CupertinoActivityIndicator(
                      // valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      color: Colors.blue,
                      radius: 30.0,
                    ),

                    // const LinearProgressIndicator(color: Colors.blue,),
                ],
              ),
            ),
        
          ],
        ),
      ),
    );
  }
}
