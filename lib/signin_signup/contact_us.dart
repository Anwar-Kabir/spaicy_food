import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Contact Us"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: ListView(
                    children: ListTile.divideTiles(context: context, tiles: [
                      const ListTile(
                        leading: Icon(Icons.phone),
                        title: const Text('Hotline'),
                        subtitle: Text('+880 1759 546853'),
                      ),
                      const ListTile(
                        leading: Icon(Icons.phone),
                        title: Text('Corporate Sales'),
                        subtitle: Text('+880 1778 603274'),
                      ),
                      const ListTile(
                        leading: const Icon(Icons.email),
                        title: Text('Email'),
                        subtitle: const Text('munnarahman1994@gmail.com'),
                      ),
                      const ListTile(
                        leading: Icon(Icons.home),
                        title: Text('Home'),
                        subtitle: const Text('Allardarga 7042, Daulatpur, Kushtia'),
                      ),
                    ]).toList(),
                  ),
                ),
              ),

              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      const Text("Stay Connected"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.facebook,
                            ),
                            color: Colors.green,
                            onPressed: () {
                              const url = 'https://www.facebook.com/';
                              launchURL(url);
                            },
                          ),
                          IconButton(
                            icon: const Icon(FontAwesomeIcons.twitter, size: 16.0),
                            color: Colors.green,
                            onPressed: () {
                              const url = 'https://twitter.com/home';
                              launchURL(url);
                            },
                          ),
                          IconButton(
                            icon: const Icon(FontAwesomeIcons.youtube, size: 16.0),
                            color: Colors.green,
                            onPressed: () {
                              const url = 'https://www.youtube.com/';
                              launchURL(url);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),



              Expanded(
                  flex: 2,
                  child: const Text("Develop by: anwarkabir1994@gmail.com")),
            ],
          ),
        ),
      ),
    );
  }
}
