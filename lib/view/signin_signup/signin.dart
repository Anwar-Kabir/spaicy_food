import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/route_manager.dart';
import 'package:spaicy_food/view/my_home_page.dart';
import 'package:spaicy_food/view/signin_signup/firebase_reg.dart';
import 'package:spaicy_food/view/signin_signup/forget_password.dart';
import 'package:spaicy_food/view/signin_signup/signup.dart';


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
        Get.off(const Signin());
      } else {
        print('User is signed in!');
        Get.off(const MyHomePage());
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
    var currentWidth = MediaQuery.of(context).size.width;
    var small = currentWidth > 1201;
    var extraSmall = currentWidth > 1025;

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              height: extraSmall ? MediaQuery.of(context).size.height : 0.0,
              width: small
                  ? MediaQuery.of(context).size.width * 0.72
                  : extraSmall
                      ? MediaQuery.of(context).size.width - 500
                      : 0.0,
              color: Colors.indigo[200],
              child: Image.network(
                'https://cdn.pixabay.com/photo/2021/10/11/13/12/website-6700615_960_720.png',
                fit: BoxFit.cover,
              ),
            ),
            Stack(alignment: Alignment.topRight, children: [
              SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: small ? MediaQuery.of(context).size.width * 0.28 : 410,
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: Column(
                    children: [
                      InkWell(
                        child: Container(
                          child: const Align(
                            alignment: Alignment.topLeft,
                            child: Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        onTap: () {
                          Get.off(const MyHomePage());
                        },
                      ),
                      Container(
                        padding: const EdgeInsets.all(40.0),
                        child: Form(
                            key: formkey,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20.0,
                                ),
                                const Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Welcome',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                const Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Sign in to continue!',
                                      style: TextStyle(color: Colors.black45),
                                    )),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                GestureDetector(
                                  onTap: (){
                                    FocusScopeNode currentFocus = FocusScope.of(context);
                                    if(!currentFocus.hasPrimaryFocus){
                                      FocusManager.instance.primaryFocus!.unfocus();
                                    }
                                    },
                                  child: TextFormField(
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
                                  height: 25.0,
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
                                  height: 20.0,
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: 'Forget password?',
                                      style: const TextStyle(
                                          color: Colors.black,),
                                      children: [
                                        TextSpan(
                                            text: ' Click here',
                                            style: const TextStyle(
                                              color: Colors.blue,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Get.to(const ForgetPassword());
                                              })
                                      ]),
                                ),
                                const SizedBox(height: 20),
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(color: Colors.black),
                                    text: 'don\'t have an account?',
                                    children: [
                                      TextSpan(
                                          text: ' Sign up',
                                          style: const TextStyle(
                                            color: Colors.blue,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Signup()));
                                            })
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              )
            ])
          ])),
    );
  }
}


