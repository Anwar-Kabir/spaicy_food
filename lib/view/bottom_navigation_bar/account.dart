import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/route_manager.dart';
import 'package:spaicy_food/view/my_home_page.dart';
import 'package:spaicy_food/view/signin_signup/signin.dart';
import 'package:url_launcher/url_launcher.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  bool nightmood = false;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    logincheck();
  }

  logincheck() {
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

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
  }

  delay() async {
    await Future.delayed(Duration(seconds: 5), () {
      print(" This line is execute after 3 seconds");
      CircularProgressIndicator();
      setState(() {
        loading = true;
      });
    });
  }



  signOut() async {
    await FirebaseAuth.instance.signOut();
    Get.off(MyHomePage());
    Get.snackbar(
      "hitaishi-food",
      "User Sign out Successful",
      // icon: Icon(Icons.person, color: Colors.red),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3),
    );
  }

  @override
  Widget build(BuildContext context) {
    //return  Center(child: CircularProgressIndicator());

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Center(child: Text("No Account")),

          /* FutureBuilder(
              future: delaymm(),
              builder: (context, snapshot) {
              if (loading == false) {
              return CircularProgressIndicator();
              } else {
              if (snapshot.hasData == false) {
              return CircularProgressIndicator();
              } else {
              return Expanded(
              child: Container()
              );
              }
              }
              });*/

         /* Container(
            child: loading ? delay() : logincheck(),

          ),*/

          Container(
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey,
              color: Colors.purple,
              strokeWidth: 10,
            ),
          ),

          SizedBox(
            height: 30,
          ),

          //Text('User email: ${FirebaseAuth.instance.currentUser!.email}'),

          Row(
            children: [
              const Text('Night Mood?'),
              Switch(
                  value: nightmood,
                  onChanged: (value) {
                    setState(() {
                      nightmood = value;
                      Get.isDarkMode
                          ? Get.changeTheme(ThemeData.light())
                          : Get.changeTheme(ThemeData.dark());
                    });
                  }),
            ],
          ),

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),

          ElevatedButton(
              onPressed: () {
                const url = 'https://play.google.com/store';
                launchURL(url);
              },
              child: Text("Review or  rate us on Play Stote or App Store")),

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),

          ElevatedButton(
              onPressed: share,
              child: Text("Share this app with your friends and family")),

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),

          Center(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // background
                  onPrimary: Colors.yellow, // foreground
                ),
                onPressed: () {
                  signOut();
                },
                child: Text("Sign out")),
          ),
        ],
      ),
    );
  }
}
