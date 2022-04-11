import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:spaicy_food/admin/image_upload/admin_home.dart';
import 'package:spaicy_food/view/search.dart';
import 'package:spaicy_food/view/bottom_navigation_bar/account.dart';
import 'package:spaicy_food/view/bottom_navigation_bar/bottom_home.dart';
import 'package:spaicy_food/view/bottom_navigation_bar/favorite.dart';
import 'package:spaicy_food/view/bottom_navigation_bar/order.dart';
import 'package:spaicy_food/view/bottom_navigation_bar/treding.dart';
import 'package:spaicy_food/view/contact_us.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  late String _title;
  final pages = [
    const BottomHome(),
    const Favorite(),
    const Treding(),
    const Order(),
    const Account()
  ];

  @override
  initState() {
    _title = 'Begum Bazar';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(_title),
            titleSpacing: 3.0,
            actions: [
              IconButton(
                onPressed: () {
                  Get.to(HomePage());
                },
                icon: const Icon(Icons.search),
              ),
              IconButton(
                  onPressed: () {
                    Get.to(ContactUs());
                  },
                  icon: const Icon(Icons.message_outlined)),
              IconButton(
                onPressed: () {
                  // Get.to(FMCNoti());
                },
                icon: Stack(
                  children: <Widget>[
                    new Icon(
                      Icons.notifications,
                      size: 25.5,
                    ),
                    Positioned(
                      right: -1.0,
                      top: -1.0,
                      child: Stack(
                        children: <Widget>[
                          Icon(
                            Icons.brightness_1,
                            size: 12.0,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.off(Home());
                },
                icon: const Icon(Icons.account_box),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
                switch (index) {
                  case 0:
                    {
                      _title = 'Hitaisi';
                    }
                    break;
                  case 1:
                    {
                      _title = 'Favorite';
                    }
                    break;
                  case 2:
                    {
                      _title = 'Treading';
                    }
                    break;
                  case 3:
                    {
                      _title = 'Order';
                    }
                    break;
                  case 4:
                    {
                      _title = 'Account';
                    }
                    break;
                }
              });
            },
            //backgroundColor: Colors.green,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                  backgroundColor: Colors.teal),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorite',
                  backgroundColor: Colors.teal),
              BottomNavigationBarItem(
                  icon: Icon(Icons.trending_up),
                  label: 'Treading',
                  backgroundColor: Colors.teal),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_shopping_cart),
                  label: 'Order',
                  backgroundColor: Colors.teal),
              BottomNavigationBarItem(
                  icon: Icon(Icons.people),
                  label: 'Account',
                  backgroundColor: Colors.teal),
            ],
          ),
          body: pages[_currentIndex]),
    );
  }
}
