import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:spaicy_food/my_home_page.dart';
import 'package:spaicy_food/signin_signup/signin.dart';

signup(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    print("..........sign up success......");
    Get.snackbar(
      "hitaishi-food",
      "sign up successfull. Now Log in",
      // icon: Icon(Icons.person, color: Colors.red),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3),
    );

    print(userCredential.user!.emailVerified);
    if (userCredential.user!.emailVerified == false) {
      User? user = FirebaseAuth.instance.currentUser;
      await user!.sendEmailVerification();
    }
    Get.off(const Signin());
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
      Get.snackbar(
        "hitaishi-food",
        "The password provided is too weak.",
        //icon: Icon(Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 4),
      );
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
      Get.snackbar(
        "hitaishi-food",
        "The account already exists for that email.",
        //icon: Icon(Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 4),
      );
    }
  } catch (e) {
    print(e);
  }
}

signin(String email, String password) async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    print("..........sign in success......");

    if (userCredential.user!.emailVerified == false) {
      User? user = FirebaseAuth.instance.currentUser;
      // await user!.sendEmailVerification();
      Get.snackbar(
        "hitaishi-food",
        "Email Verification Fail. Please Verify your Email",
        // icon: Icon(Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      );
    } else {
      Get.off(const MyHomePage());
      Get.snackbar(
        "hitaishi-food",
        "sign in successfull.",
        // icon: Icon(Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      );
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
      Get.snackbar(
        "hitaishi-food",
        "No user found for that email.",
        // icon: Icon(Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 4),
      );
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
      Get.snackbar(
        "hitaishi-food",
        "Wrong password provided for that user.",
        //icon: Icon(Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 4),
      );
    }
  }
}
