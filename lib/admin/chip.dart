import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminChip extends StatefulWidget {
  const AdminChip({Key? key}) : super(key: key);

  @override
  State<AdminChip> createState() => _AdminChipState();
}

class _AdminChipState extends State<AdminChip> {
  final TextEditingController _chipController = TextEditingController();

  final CollectionReference _chip =
      FirebaseFirestore.instance.collection('chip_treading');

  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _chipController.text = documentSnapshot['name'];
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
                controller: _chipController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Text(action == 'create' ? 'Create' : 'Update'),
                onPressed: () async {
                  final String? name = _chipController.text;

                  if (name != null) {
                    if (action == 'create') {
                      // Persist a new product to Firestore
                      await _chip.add({
                        "name": name,
                      });
                    }

                    if (action == 'update') {
                      // Update the product
                      await _chip.doc(documentSnapshot!.id).update({
                        "name": name,
                      });
                    }

                    // Clear the text fields
                    _chipController.text = '';

                    // Hide the bottom sheet
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }

  // Deleteing a product by id
  Future<void> _deleteProduct(String productId) async {
    await _chip.doc(productId).delete();

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a product')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chip Upload'),
      ),
      // Using StreamBuilder to display all products from Firestore in real-time
      body: StreamBuilder(
        stream: _chip.snapshots(),
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
                    title: Text(documentSnapshot['name']),
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
