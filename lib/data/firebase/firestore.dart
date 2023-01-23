import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pomodolo/data/model/user_model.dart';

class FireStore {
  final String? uid;
  FireStore({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future savingUserData(String name, String email) async {
    var user = UserModel(
      uid: uid!,
      userName: name,
      email: email,
      iconUrl: '',
      objective: '',
      goalPomo: 0,
      currentNumOfPomo: 0,
      isOnline: false,
    );
    //await userCollection.doc(uid).set(user.toFirestore());
    return await userCollection.doc(uid).set({
      'uid': user.uid,
      'name': user.userName,
      'email': user.email,
      'profilePic': user.iconUrl,
      'objective': user.objective,
      'goalPomo': user.goalPomo,
      'currentNumOfPomo': user.currentNumOfPomo,
      'isOnline': user.isOnline,
    });
  }

  Future gettingUserData(String email) async {
    QuerySnapshot querySnapshot =
        await userCollection.where('email', isEqualTo: email).get();
    return querySnapshot;
  }

  searchOnlinePeople() {
    return userCollection.where('isOnline', isEqualTo: true).snapshots();
  }
}
