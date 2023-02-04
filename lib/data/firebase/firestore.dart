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
      blocks: null,
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
      'blocks': user.blocks,
    });
  }

  Future gettingUserData(String email) async {
    QuerySnapshot querySnapshot =
        await userCollection.where('email', isEqualTo: email).get();
    return querySnapshot;
  }

  // 現在ログインしているユーザのFirestore情報取得
  Future<UserModel> getCurrentUserModel() async {
    print('kokokitemasuka');
    final model =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final userModel = UserModel.fromSnapshot(model);
    return userModel;
  }

  getCurrentPomo(String uid) async {
    final currentPomo = await userCollection.doc(uid).get();
    return currentPomo;
  }

  Future<void> startTimer(int goalPomo, String objectve, String uid) async {
    await userCollection.doc(uid).update({
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

  report(String uid) async {
    await FirebaseFirestore.instance.collection('report').doc(uid).set({
      'uid': uid,
    });
  }

  block(String uid) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'blocks': FieldValue.arrayUnion([uid]),
    });
  }

  unBlock(String uid) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'blocks': FieldValue.arrayRemove([uid]),
    });
  }
}
