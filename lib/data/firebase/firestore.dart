import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pomodolo/data/model/user_model.dart';

class FireStore {
  final String? uid;
  FireStore({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future savingUserData(String name, String email) async {
    var user = UserModel(
      uid: uid!,
      name: name,
      email: email,
      profilePic: '',
      objective: '',
      goalPomo: 0,
      currentNumOfPomo: 0,
      isOnline: false,
      totalPomo: 0,
    );
    //await userCollection.doc(uid).set(user.toFirestore());
    return await userCollection.doc(uid).set({
      'uid': user.uid,
      'name': user.name,
      'email': user.email,
      'profilePic': user.profilePic,
      'objective': user.objective,
      'goalPomo': user.goalPomo,
      'currentNumOfPomo': user.currentNumOfPomo,
      'isOnline': user.isOnline,
      'totalPomo': user.totalPomo,
    });
  }

  Future gettingUserData(String email) async {
    QuerySnapshot querySnapshot =
        await userCollection.where('email', isEqualTo: email).get();
    return querySnapshot;
  }

  getCurrentPomo(String uid) async {
    final currentPomo = await userCollection.doc(uid).get();
    return currentPomo;
  }

  startTimer(int goalPomo, String objectve, String uid) {
    userCollection.doc(uid).update({
      'goalPomo': goalPomo,
      'isOnline': true,
      'objective': objectve,
      'currentNumOfPomo': 0,
    });
  }

  toggleOnline(bool present) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'isOnline': present,
    });
  }
}
