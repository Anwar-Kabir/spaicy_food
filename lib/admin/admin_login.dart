import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/route_manager.dart';
import 'package:spaicy_food/admin/admin_slider.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  late String password;
  bool _isObscure = true;

  void validate() {
    if (formkey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Admin Sign in Successful'),
        backgroundColor: Colors.green,
      ));
      Get.off(const AdminSlider());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed. Admin Sign in unsuccessful'),
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
                                Navigator.pushNamed(
                                    context, '/forgetpassword');
                              })
                      ]),
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
