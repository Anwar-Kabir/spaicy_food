import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({Key? key}) : super(key: key);

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Check Out"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Shipping address",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )),
                const SizedBox(
                  height: 6,
                ),
                Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 5,
                  child: ListTile(
                    //leading: Icon(Icons.icecream),
                    title: const Text(
                      'Anwar Kabir',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black26),
                    ),
                    subtitle: const Text(
                      'Shukrabad, Dhanmondi 32, 1209, Dhaka',
                      style: TextStyle(color: Colors.black45),
                    ),
                    trailing: GestureDetector(
                      onTap: (){
                        Get.bottomSheet(
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: const [
                                    ListTile(title: Text("Option 1"),
                                      trailing: Icon(Icons.access_alarms),),
                                    ListTile(title: Text("Option 2"),
                                      trailing: Icon(Icons.ac_unit),),
                                    ListTile(title: Text("Option 3"),
                                      trailing: Icon(Icons.present_to_all_sharp),),
                                    ListTile(title: Text("Option 4"),
                                      trailing: Icon(Icons.keyboard),),
                                  ],
                                ),
                              ),
                            ),
                            elevation: 20.0,
                            enableDrag: false,
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0),
                                )
                            )

                        );
                      },
                      child: const Text(
                        'Change',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Payment",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )),
                const SizedBox(
                  height: 6,
                ),
                Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 5,
                  child: ListTile(
                    leading: const Icon(Icons.payment),
                    title: const Text(
                      'Anwar Kabir',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black26),
                    ),
                    subtitle: const Text(
                      '**** **** **** 6853',
                      style: TextStyle(color: Colors.black45),
                    ),
                    trailing: GestureDetector(
                      onTap: (){
                        Get.bottomSheet(
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: const [
                                    Center(child: Text("Option 1",style: TextStyle(fontWeight: FontWeight.bold),)),

                                    ListTile(title: Text("Option 1"),
                                      trailing: Icon(Icons.access_alarms),),
                                    ListTile(title: Text("Option 2"),
                                      trailing: Icon(Icons.ac_unit),),
                                    ListTile(title: Text("Option 3"),
                                      trailing: Icon(Icons.present_to_all_sharp),),
                                    ListTile(title: Text("Option 4"),
                                      trailing: Icon(Icons.keyboard),),
                                  ],
                                ),
                              ),
                            ),
                            elevation: 20.0,
                            enableDrag: true,
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0),
                                )
                            )

                        );
                      },
                      child: const Text(
                        'Change',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Delivery Method",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )),
                const SizedBox(
                  height: 6,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Card(
                        elevation: 2,
                        //color: Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SizedBox(
                          height: 70,
                          width: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: 50,
                                  width: 90,
                                  child: Image.asset('assets/images/paperfly.jpg',
                                      fit: BoxFit.cover)),
                              const Text('2-5 days', style: TextStyle()),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 2,
                        //color: Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SizedBox(
                          height: 70,
                          width: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: 50,
                                  width: 90,
                                  child: Image.asset('assets/images/redex.png',
                                      fit: BoxFit.cover)),
                              const Text('2-5 days', style: TextStyle()),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 2,
                        //color: Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SizedBox(
                          height: 70,
                          width: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: 50,
                                  width: 90,
                                  child: Image.asset(
                                      'assets/images/sundorbon.png',
                                      fit: BoxFit.cover)),
                              const Text('2-5 days', style: TextStyle()),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),
                const ListTile(
                  leading: Text("Amount  (4 items)"),
                  trailing: Text("\$ 363",style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                const ListTile(
                  leading: Text("Delivery"),
                  trailing: Text("\$ 9",style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                const ListTile(
                  leading: Text("Grand Amount"),
                  trailing: Text("\$ 372",style: TextStyle(fontWeight: FontWeight.bold),),
                ),

                Container(
                  height: 50,
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                    ),
                    onPressed: () {

                    },
                    child: Text(
                      "Placce Order".toUpperCase(),
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
