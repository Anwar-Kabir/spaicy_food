import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/route_manager.dart';
import 'package:spaicy_food/view/signin_signup/signin.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController email = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  /*void validate() {
    if (formkey.currentState!.validate()) {
      //signin(email, password);
      FirebaseAuth.instance.sendPasswordResetEmail(email: email.text).then((value) =>
          Get.to( const Signin()));
      Get.snackbar(
        "hitaishi-food",
        "reset password was send your Email. Now Sign in with new password",
        // icon: Icon(Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        duration: Duration(seconds: 6),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed. reset password'),
        backgroundColor: Colors.red,
      ));
    }
  }*/

  /*await auth.sendPasswordResetEmail(email: email.text).then((value) =>
          Get.to( const Signin()));
      Get.snackbar(
        "hitaishi-food",
        "reset password was send your Email. Now Sign in with new password",
        // icon: Icon(Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        duration: Duration(seconds: 6),
      );*/

  FirebaseAuth auth = FirebaseAuth.instance;

  void forget() async {
    try {
      if (formkey.currentState!.validate()) {
        await auth
            .sendPasswordResetEmail(email: email.text)
            .then((value) => Get.to(const Signin()));
        Get.snackbar(
          "hitaishi-food",
          "reset password was send your Email. Now Sign in with new password",
          // icon: Icon(Icons.person, color: Colors.red),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          duration: Duration(seconds: 6),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Failed. reset password'),
          backgroundColor: Colors.red,
        ));
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
      }
      print(e.code);
      print(e.message);
// show the snackbar here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forget Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Forget Password'),
            SizedBox(
              height: MediaQuery.of(context).size.height * .03,
            ),
            Form(
              key: formkey,
              child: TextFormField(
                onChanged: (value) => email = value as TextEditingController,
                //validator: validatepass,
                validator: MultiValidator([
                  RequiredValidator(errorText: "Required"),
                  EmailValidator(errorText: "Not A Valid Email"),
                ]),
                controller: email,
                decoration: const InputDecoration(
                  label: Text('Reset Password'),
                  hintText: 'Enter your Email',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .03,
            ),
            ElevatedButton(onPressed: forget, child: const Text('get recover'))
          ],
        ),
      ),
    );
  }
}
