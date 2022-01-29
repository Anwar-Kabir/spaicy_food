import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:spaicy_food/signin_signup/signup.dart';

class TermsConditions extends StatefulWidget {
  const TermsConditions({Key? key}) : super(key: key);

  @override
  _TermsConditionsState createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
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
                Get.off(const Signup());
              },
            ),
            const Text("Terms & Condition"),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.03,
            ),
            const Text('''Last modified: December 29, 2015

Welcome to Hitaishi. Hitaishi.com provides website features and other products and services to you when you visit or shop at hitaishi.com.

By using Hitaishi Services, you agree to these conditions. Please read them carefully.

By subscribing to or using any of our services you agree that you have read, understood and are bound by the Terms, regardless of how you subscribe to or use the 
services. In these Terms, references to "you", "User" shall mean the user end, "Service Providers" mean independent third party service providers, and "we", "us" 
and "our" shall mean hitaishi.com & begumbazar.com, its franchisor, affiliates and partners. '''),
      ],
    ),
          ),
        ));
  }
}
