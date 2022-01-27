import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:spaicy_food/category.dart';
import 'package:spaicy_food/admin/image_upload/image_up/stroge.dart';
import 'package:spaicy_food/admin/product_upload.dart';
 import 'package:spaicy_food/my_home_page.dart';

import 'admin_slider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? image;
  Storage _storage = new Storage();
  FirebaseAuth auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(
              Icons.login,
              color: Colors.green,
            ),
            tooltip: 'Home',
            onPressed: () {
              Get.off(MyHomePage());
            },
          ),
        ],
        title: Text('Admin Dashbord'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(

              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                InkWell(
                  onTap: (){
                    Get.to(HomePage());
                  },
                  child: const Card  (
                    elevation: 5,
                    child: ListTile(
                      leading: Icon(Icons.image),
                      title: Text('Slider'),
                      subtitle: Text('Slider Image Upload'),
                      trailing: Icon(Icons.arrow_right),
                    ),
                  ),
                ),

                InkWell(
                  onTap: (){

                  },
                  child: const Card  (
                    elevation: 5,
                    child: ListTile(
                      leading: Icon(Icons.image),
                      title: Text('Image upload'),
                      subtitle: Text('Firebase image upload from web'),
                      trailing: Icon(Icons.arrow_right),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: (){
                    Get.to(Category());
                  },
                  child: const Card  (
                    elevation: 5,
                    child: ListTile(
                      leading: Icon(Icons.image),
                      title: Text('Category'),
                      subtitle: Text('Category Upload'),
                      trailing: Icon(Icons.arrow_right),
                    ),
                  ),
                ),



                GestureDetector(
                  onTap: (){
                    Get.to(AdminProductUpoad());
                  },
                  child: const Card  (
                    elevation: 5,
                    child: ListTile(
                      leading: Icon(Icons.image),
                      title: Text('Product'),
                      subtitle: Text('Product Upload'),
                      trailing: Icon(Icons.arrow_right),
                    ),
                  ),
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),

                const Text('Image Upload'),
                Container(
                    height: 140,
                    width: 180,
                    color: Colors.black12,
                    child: image == null
                        ? Icon(
                            Icons.image,
                            size: 50,
                          )
                        : Image.file(
                            image!,
                            fit: BoxFit.fill,
                          )),
                ElevatedButton(
                    child: Text('pick image'),
                    onPressed: () {
                      _storage.getImage(context).then((file) {
                        setState(() {
                          image = File(file.path);
                          print(file.path);
                        });
                      });
                    }),
                TextButton(
                    onPressed: () {
                      if (image != null)
                        _storage.uploadFile(image!, context);
                      else
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("No Image was selected")));
                    },
                    child: Text('Upload Image'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
