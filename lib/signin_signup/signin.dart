import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/route_manager.dart';
import 'package:spaicy_food/admin/admin_login.dart';
import 'package:spaicy_food/my_home_page.dart';
import 'package:spaicy_food/signin_signup/firebase_reg.dart';
import 'package:spaicy_food/signin_signup/forget_password.dart';
import 'package:spaicy_food/signin_signup/signup.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  late String password;
  late String email;
  bool _isObscure = true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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


  void validate() {
    if (formkey.currentState!.validate()) {
      signin(email, password);
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
        title: const Text("Sign In"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: formkey,
              child: Column(
                children: [
                  const Text('Sign in'),
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
                      'Sign in',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  RichText(
                    text: TextSpan(
                        text: 'Fotget password?',
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        children: [
                          TextSpan(
                              text: ' Click here',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                wordSpacing: 2.0,
                                letterSpacing: 2.0,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  /*Navigator.pushNamed(
                                      context, '/forgetpassword');*/
                                  Get.to(ForgetPassword());
                                })
                        ]),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .03,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'don\'t have an account? ',
                      children: [
                        TextSpan(
                            text: 'Sign up',
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              letterSpacing: 2.0,
                              wordSpacing: 2.0,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Signup()));
                              })
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .03,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
