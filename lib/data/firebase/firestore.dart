import 'package:cloud_firestore/cloud_firestore.dart';

class FireStore {
  final String? uid;
  FireStore({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future savingUserData(String name, String email) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'email': email,
      'profilePic': '',
      'uid': uid,
    });
  }
  
  Future gettingUserData(String email) async {
    QuerySnapshot querySnapshot =
        await userCollection.where('email', isEqualTo: email).get();
    return querySnapshot;
  }
}