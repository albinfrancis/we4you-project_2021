import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



class CurdMethods {
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> addUser(collection, docId, data) async {
    FirebaseFirestore.instance.collection(collection).doc(docId).set(data);
  }

}