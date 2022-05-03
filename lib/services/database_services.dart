//TODO fazer os services de comunicação com banco de dados

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../model/buy.dart';

class DatabaseServices {
  CollectionReference checkListCollection =
      FirebaseFirestore.instance.collection("CheckList");

  Future createNewBuy(String title) async {
    return await checkListCollection.add({
      "title": title,
      "isBuy": false,
    });
  }

  Future completeBuy(uuid) async {
    return await checkListCollection.doc(uuid).update({"isBuy": true});
  }

  List<Buy> buysFromFirestore(QuerySnapshot snapshot) {
    if (snapshot != null) {
      return snapshot.docs.map((e) {
        return Buy(
            isBuy: (e.data() as dynamic)["isBuy"],
            title: (e.data() as dynamic)["title"],
            uuid: e.id);
      }).toList();
    } else {
      return [];
    }
  }

  Stream<List<Buy>> listBuys() {
    return checkListCollection.snapshots().map(buysFromFirestore);
  }
}
