import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:spaicy_food/admin/admin_login.dart';

class AdminSignUp extends StatefulWidget {
  const AdminSignUp({Key? key}) : super(key: key);

  @override
  _AdminSignUpState createState() => _AdminSignUpState();
}

class _AdminSignUpState extends State<AdminSignUp> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  late String password;
  bool _isObscure = true;

  void validate() {
    if (formkey.currentState!.validate()) {
      print("Validate");
    } else {
      print("Not validate");
    }
  }

  String? validatepass(value) {
    if (value!.isEmpty) {
      return "Requried";
    } else if (value.length < 6) {
      return ("Should be at least 6 charecaters");
    } else if (value.length > 15) {
      return ("Shouldn't more then 15 charecaters");
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Singup"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formkey,
            // autovalidate: true,
            child: Column(
              children: [
                Text('Sign up'),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                TextFormField(
                  validator: MultiValidator([
                    RequiredValidator(errorText: "Requried"),
                    EmailValidator(errorText: "Not A Valid Email"),
                  ]),
                  decoration: const InputDecoration(
                      label: Text('Email'),
                      hintText: 'abc@gmail.com',
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                TextFormField(
                  onChanged: (value) => password = value,
                  keyboardType: TextInputType.text,
                  // maxLength: 8,
                  obscureText: _isObscure,
                  validator: validatepass,
                  decoration: InputDecoration(
                    label: const Text('Enter your password'),
                    hintText: "24688642",
                    border: OutlineInputBorder(),
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  // maxLength: 8,
                  validator: validatepass,
                  obscureText: _isObscure,

                  decoration: InputDecoration(
                      label: const Text('Re-Enter your password'),
                      hintText: "24688642",
                      suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          }),
                      border: const OutlineInputBorder()),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
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
                                  builder: (context) => AdminLogin()));
                          // Navigator.pop(context);
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
