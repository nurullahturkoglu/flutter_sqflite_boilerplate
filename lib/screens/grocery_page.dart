import 'package:flutter/material.dart';
import 'package:flutter_sqflite_example/database/database_helper.dart';
import '../models/grocery.dart';

class GroceryPage extends StatefulWidget {
  const GroceryPage({super.key});

  @override
  State<GroceryPage> createState() => _GroceryPageState();
}

class _GroceryPageState extends State<GroceryPage> {
  TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    Grocery item = Grocery(name: nameController.text);
                    await DatabaseHelper.instance.insert(item.toMap());
                    setState(() {
                      nameController.clear();
                    });
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Grocery>>(
              future: DatabaseHelper.instance.getContacts(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Grocery>> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return snapshot.data!.isEmpty
                      ? const Center(child: Text('No grocery items found'))
                      : ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            Grocery item = snapshot.data![index];
                            return ListTile(
                              title: Text(item.name),
                              subtitle: Text(item.id.toString()),
                            );
                          },
                        );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
