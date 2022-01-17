import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:spaicy_food/signin_signup/firebase_reg.dart';
import 'package:spaicy_food/signin_signup/signin.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Singup"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                const Text('Sign up'),
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
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _confirmPass,
                  validator: (val) {
                    if (val!.isEmpty) return 'Required';
                    if (val != _pass.text) return 'Confirm password Not Match';
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
                              _isObscureConfirm = !_isObscureConfirm;
                            });
                          }),
                      border: const OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                ElevatedButton(
                  onPressed: validate,
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
                    text:
                        TextSpan(text: 'All ready have an account', children: [
                  TextSpan(
                      text: ' Sign in here',
                      style: const TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Signin()));
                        })
                ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
