import 'package:cloud_firestore/cloud_firestore.dart';

class HomeService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> streamRecommendation() {
    CollectionReference data = firestore.collection("recommendation");
    return data.snapshots();
  }

  Stream<QuerySnapshot<Object?>> streamList() {
    CollectionReference data = firestore.collection("listbarbershop");
    return data.snapshots();
  }

  Future<DocumentSnapshot<Object?>> getByIDRecommendation(String id) async {
    DocumentReference docRef = firestore.collection("recommendation").doc(id);
    return docRef.get();
  }

  Future<DocumentSnapshot<Object?>> getByIDList(String id) {
    DocumentReference docRef = firestore.collection("listbarbershop").doc(id);
    return docRef.get();
  }
}
