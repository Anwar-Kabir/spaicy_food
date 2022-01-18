import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spaicy_food/signin_signup/signin.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {

  final FirebaseAuth _auth = FirebaseAuth.instance;


 /* @override
  void initState() {
    super.initState();

    if(_auth.currentUser!() != null){

      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Account()
      ));
    }

  }*/




  @override
  Widget build(BuildContext context) {
    return Container();/*FutureBuilder<FirebaseUser>(
        future: _auth.currentUser(),
        builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot){
          if (snapshot.hasData){
            FirebaseUser user = snapshot.data; // this is your user instance
            /// is because there is user already logged
            return Account();
          }
          /// other way there is no user logged.
          return Signin();
        }
    );*/
  }
}