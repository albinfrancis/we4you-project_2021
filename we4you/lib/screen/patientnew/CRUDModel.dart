import 'dart:async';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:we4you/screen/patientnew/MedicineModel.dart';
import 'package:we4you/screen/patientnew/api.dart';
import 'package:we4you/screen/patientnew/locator.dart';

class CRUDModel extends ChangeNotifier {
  Apiz _api = locator<Apiz>();

  Stream<QuerySnapshot> fetchProductsAsStream() {
    return _api.streamDataCollection();
  }
}
