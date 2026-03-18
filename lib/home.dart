import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/functions/database_functions.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        elevation: 4,
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('pets').snapshots(),

          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            final pets = snapshot.data!.docs;

            return Container(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: pets.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: const Color.fromARGB(221, 2, 54, 66),
                            child: ListTile(
                              title: Text(
                                pets[index]['name'],
                                style: TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(pets[index]['animal']),
                            ),
                          );
                        },
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 30,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            create(
                              collName: 'pets',
                              docName: 'tom',
                              name: 'tommy',
                              animal: 'dog',
                              age: 12,
                            );
                          },
                          child: Text('Create'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            update(
                              collName: 'pets',
                              docName: 'tom',
                              field: 'age',
                              value: 20,
                            );
                          },
                          child: Text('Update'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            delete(collName: 'pets', docName: 'tom');
                          },
                          child: Text('Delete'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
