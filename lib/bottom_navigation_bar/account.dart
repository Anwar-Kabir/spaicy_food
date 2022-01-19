import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:spaicy_food/my_home_page.dart';
import 'package:spaicy_food/signin_signup/signin.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  bool currentuser = false;

  @override
  void initState() {
    // TODO: implement initState
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        Get.off(Signin());
      } else {
        print('User is signed in!');
        Get.off(MyHomePage());
      }
    });
  }



  signOut() async {
    await FirebaseAuth.instance.signOut();
    Get.off(MyHomePage());
    Get.snackbar(
      "hitaishi-food",
      "User Sign out Successful",
      // icon: Icon(Icons.person, color: Colors.red),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Center(child: Text("No Account")),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
          //Text('User email: ${FirebaseAuth.instance.currentUser!.email}'),

          SizedBox(
            height: 10,
          ),

          Center(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // background
                  onPrimary: Colors.yellow, // foreground
                ),
                onPressed: () {
                  signOut();
                },
                child: Text("Sign out")),
          ),
        ],
      ),
    );
  }
}
