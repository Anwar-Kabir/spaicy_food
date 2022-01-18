import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/route_manager.dart';
import 'package:spaicy_food/admin/image_upload/image_upload_home.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  late String password;
  late String email;
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        Get.off(AdminLogin());
      } else {
        print('User is signed in!');
        Get.off(Home());
      }
    });
  }

  adminsignin(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(userCredential.user!.uid);

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
        Get.off(Home());
        Get.snackbar(
          "hitaishi-food",
          "Admin sign in successfull.",
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

  void validate() {
    if (formkey.currentState!.validate()) {
      adminsignin(email, password);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed. Sign in unsuccessful'),
        backgroundColor: Colors.red,
      ));
    }
  }

  String? validatepass(value) {
    if (value!.isEmpty) {
      return "Required";
    } else if (value.length < 6) {
      return ("Should be at least 6 characters");
    } else if (value.length > 15) {
      return ("Shouldn't more then 10 characters");
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Signin"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
            key: formkey,
            child: Column(
              children: [
                const Text('Admin Sign in'),
                const SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  onChanged: (value) => email = value,
                  validator: MultiValidator([
                    RequiredValidator(errorText: "Required"),
                    EmailValidator(errorText: "Not A Valid Email"),
                  ]),
                  decoration: const InputDecoration(
                      label: Text('Email'),
                      hintText: 'abc@gmail.com',
                      border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  onChanged: (value) => password = value,
                  controller: _pass,
                  keyboardType: TextInputType.text,
                  obscureText: _isObscure,
                  validator: validatepass,
                  decoration: InputDecoration(
                    label: const Text('Enter your password'),
                    hintText: "24688642",
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                        icon: Icon(_isObscure
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        }),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                ElevatedButton(
                  onPressed: validate,
                  child: const Text(
                    'Admin Sign in',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
              ],
            )),
      ),
    );
  }
}
