import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'image_upload/image_up/stroge.dart';

class AdminProduct extends StatefulWidget {
  const AdminProduct({Key? key}) : super(key: key);

  @override
  State<AdminProduct> createState() => _AdminProductState();
}

class _AdminProductState extends State<AdminProduct> {
  File? image;
  Storage _storage = new Storage();

// text fields' controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _skuController = TextEditingController();

  final CollectionReference _productss =
      FirebaseFirestore.instance.collection('product_home');

  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _nameController.text = documentSnapshot['name'];
      _priceController.text = documentSnapshot['price'].toString();
      _skuController.text = documentSnapshot['sku'];
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                // prevent the soft keyboard from covering text fields
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                  ),
                ),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'SkU'),
                ),
                Text("Image"),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      height: 30,
                      width: 50,
                      color: Colors.black12,
                      child: image == null
                          ? Icon(
                              Icons.image,
                              size: 50,
                            )
                          : Image.file(
                              image!,
                              fit: BoxFit.fill,
                            ),
                    ),
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
                  ],
                ),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    final String? name = _nameController.text;
                    final String? sku = _nameController.text;
                    final double? price =
                        double.tryParse(_priceController.text);
                    if (name != null && price != null && sku != null) {
                      if (action == 'create') {
                        // Persist a new product to Firestore
                        await _productss.add({
                          "name": name,
                          "price": price,
                          "sku": price,
                        });
                      }

                      if (action == 'update') {
                        // Update the product
                        await _productss.doc(documentSnapshot!.id).update({
                          "name": name,
                          "price": price,
                          "sku": price,
                        });
                      }

                      // Clear the text fields
                      _nameController.text = '';

                      // Hide the bottom sheet
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  // Deleteing a product by id
  Future<void> _deleteProduct(String productId) async {
    await _productss.doc(productId).delete();

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a product')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Upload'),
      ),
      // Using StreamBuilder to display all products from Firestore in real-time
      body: StreamBuilder(
        stream: _productss.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 15,
                      child: FittedBox(
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            documentSnapshot['img1'].toString(),
                          ),
                          radius: 15,
                        ),
                      ),
                    ),
                    title: Text(documentSnapshot['name']),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Price: ${documentSnapshot['price'].toString()}"),
                        Text("SKU: ${documentSnapshot['sku'].toString()}"),
                        //Text(documentSnapshot['sku'].toString()),
                      ],
                    ),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          // Press this button to edit a single product
                          IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () =>
                                  _createOrUpdate(documentSnapshot)),
                          // This icon button is used to delete a single product
                          IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () =>
                                  _deleteProduct(documentSnapshot.id)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      // Add new product
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createOrUpdate(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
