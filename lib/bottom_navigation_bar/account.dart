import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:spaicy_food/signin_signup/signin.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {




  signOut() async {
    await FirebaseAuth.instance.signOut();
    Get.to(Signin());
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
          Center(child: Text("No Account")),
          SizedBox(
            height: 10,
          ),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  Get.off(Signin());
                },
                child: Text("Sign in or Sign up")),
          ),
          SizedBox(
            height: 10,
          ),
          //Text('admin email: ${FirebaseAuth.instance.currentUser!.email}'),

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
