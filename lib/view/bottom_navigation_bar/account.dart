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
        Get.off(const Signin());
      } else {
        print('User is signed in!');
        Get.off(const MyHomePage());
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
    await Future.delayed(const Duration(seconds: 5), () {
      print(" This line is execute after 3 seconds");
      const CircularProgressIndicator();
      setState(() {
        loading = true;
      });
    });
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
    Get.off(const MyHomePage());
    Get.snackbar(
      "hitaishi-food",
      "User Sign out Successful",
      // icon: Icon(Icons.person, color: Colors.red),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 3),
    );
  }

  @override
  Widget build(BuildContext context) {
    //return  Center(child: CircularProgressIndicator());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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

            const ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(
                    "assets/images/nointernet.png"), // no matter how big it is, it won't overflow
              ),
              title: Text("Anwar Kabir"),
              subtitle: Text(
                "anwarkabir1994@gmail.com",
                style: TextStyle(color: Colors.black54),
              ),
            ),

            const ListTile(
                title: Text("My ordrs"),
                subtitle: Text(
                  "already have 12 orders",
                  style: TextStyle(color: Colors.black54),
                ),
                trailing: Icon(Icons.arrow_forward_ios)),

            const ListTile(
                title: Text("Shipping address"),
                subtitle: Text(
                  "already have 12 orders",
                  style: TextStyle(color: Colors.black54),
                ),
                trailing: Icon(Icons.arrow_forward_ios)),

            const ListTile(
                title: Text("Payment method"),
                subtitle: Text(
                  "visa **34",
                  style: TextStyle(color: Colors.black54),
                ),
                trailing: Icon(Icons.arrow_forward_ios)),

            const ListTile(
                title: Text("Promo codes"),
                subtitle: Text(
                  "You have specil promo code",
                  style: TextStyle(color: Colors.black54),
                ),
                trailing: Icon(Icons.arrow_forward_ios)),

            const ListTile(
                title: Text("My reviews"),
                subtitle: Text(
                  "Reviews for 4 items",
                  style: TextStyle(color: Colors.black54),
                ),
                trailing: Icon(Icons.arrow_forward_ios)),

            const ListTile(
                title: Text("Recently views product "),
                subtitle: Text(
                  "Recently views 9 items",
                  style: TextStyle(color: Colors.black54),
                ),
                trailing: Icon(Icons.arrow_forward_ios)),

            ListTile(
              title: Text("Night mood"),
              subtitle: const Text(
                "Active night mood",
                style: TextStyle(color: Colors.black54),
              ),
              trailing: Switch(
                  value: nightmood,
                  onChanged: (value) {
                    setState(() {
                      nightmood = value;
                      Get.isDarkMode
                          ? Get.changeTheme(ThemeData.light())
                          : Get.changeTheme(ThemeData.dark());
                    });
                  }),
            ),

            const ListTile(
                title: Text("Settings"),
                subtitle: Text(
                  "Notification, password",
                  style: TextStyle(color: Colors.black54),
                ),
                trailing: Icon(Icons.arrow_forward_ios)),

            ListTile(
                title: Text("Rate us"),
                subtitle: Text(
                  "On play store or App store",
                  style: TextStyle(color: Colors.black54),
                ),
                trailing: GestureDetector(
                    onTap: () {
                      const url = 'https://play.google.com/store';
                      launchURL(url);
                    },
                    child: Icon(Icons.rate_review))),

            ListTile(
                title: Text("Share this app"),
                subtitle: Text(
                  "With your family and friends",
                  style: TextStyle(color: Colors.black54),
                ),
                trailing:
                    GestureDetector(onTap: share, child: Icon(Icons.share))),

            ListTile(
                title: Text("Log out"),
                subtitle: Text(
                  "Click me to log out",
                  style: TextStyle(color: Colors.black54),
                ),
                trailing:
                    GestureDetector(onTap: signOut, child: Icon(Icons.logout,color: Colors.red,))),

            //Text('User email: ${FirebaseAuth.instance.currentUser!.email}'),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
          ],
        ),
      ),
    );
  }
}
