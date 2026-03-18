import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> create({
  required String collName,
  required String docName,
  required String name,
  required String animal,
  required int age,
}) async {
  await FirebaseFirestore.instance.collection(collName).doc(docName).set({
    "animal": animal,
    "age": 12,
    "name": name,
  });
}

Future<void> update({
  required String collName,
  required String docName,
  required String field,
  required var value,
}) async {
  await FirebaseFirestore.instance.collection(collName).doc(docName).update({
    field: value,
  });
}

Future<void> delete({required String collName, required String docName}) async {
  await FirebaseFirestore.instance.collection(collName).doc(docName).delete();
}
