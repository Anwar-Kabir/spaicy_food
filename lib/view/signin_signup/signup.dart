import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/route_manager.dart';
import 'package:spaicy_food/view/my_home_page.dart';
import 'package:spaicy_food/view/signin_signup/firebase_reg.dart';
import 'package:spaicy_food/view/signin_signup/signin.dart';
import 'package:spaicy_food/view/terms_conditions.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController _pass = TextEditingController();
  TextEditingController _confirmPass = TextEditingController();
  late String password;
  late String email;
  bool _isObscure = true;
  bool _isObscureConfirm = true;
  bool agree = false;

  void validate() {
    if (formkey.currentState!.validate()) {
      signup(email, password);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed. Sign up unsuccessful'),
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
                        ? MediaQuery.of(context).size.width - 400
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
                    child: Column(children: [
                      InkWell(
                        child: Container(
                          child: const Align(
                            alignment: Alignment.topLeft,
                            child: const Icon(
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
                                height: 30.0,
                              ),
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Create Account,',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Sign up to get Started!',
                                    style: TextStyle(color: Colors.black45),
                                  )),
                              const SizedBox(
                                height: 30.0,
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
                              TextFormField(
                                keyboardType: TextInputType.text,
                                controller: _confirmPass,
                                validator: (val) {
                                  if (val!.isEmpty) return 'Required';
                                  if (val != _pass.text)
                                    return 'Confirm password Not Match';
                                  return null;
                                },
                                obscureText: _isObscureConfirm,
                                decoration: InputDecoration(
                                    label: const Text('Re-Enter your password'),
                                    hintText: "24688642",
                                    suffixIcon: IconButton(
                                        icon: Icon(_isObscureConfirm
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                        onPressed: () {
                                          setState(() {
                                            _isObscureConfirm =
                                                !_isObscureConfirm;
                                          });
                                        }),
                                    border: const OutlineInputBorder()),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),


                              Row(
                                children: [
                                  Material(
                                    child: Checkbox(
                                      value: agree,
                                      onChanged: (value) {
                                        setState(() {
                                          agree = value ?? false;
                                        });
                                      },
                                    ),
                                  ),
                                  /*const Text(
                                    'I have read and accept terms and conditions',
                                    overflow: TextOverflow.ellipsis,
                                  )*/
                                  RichText(
                                    text: TextSpan(
                                      style: const TextStyle(color: Colors.black,
                                        overflow: TextOverflow.ellipsis,),
                                      text: 'I have read and accept',

                                      children: [
                                        TextSpan(
                                            text: ' terms and conditions',
                                            style: const TextStyle(
                                              color: Colors.blue,
                                              /*fontSize: 18,
                                              letterSpacing: 2.0,
                                              wordSpacing: 2.0,*/
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                        const TermsConditions()));
                                              })
                                      ],
                                    ),
                                  )
                                ],
                              ),



                              ElevatedButton(
                                onPressed: agree ? validate : null,
                                child: const Text(
                                  'Sign up',
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
                                      style: const TextStyle(color: Colors.black),
                                      text: 'All ready have an account',
                                      children: [
                                    TextSpan(
                                        text: ' Sign in here',
                                        style:
                                            const TextStyle(color: Colors.blue),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const Signin()));
                                          })
                                  ]))
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ])
            ])));
  }
}
