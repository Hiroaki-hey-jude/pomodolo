import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pomodolo/data/firebase/firestore.dart';
import 'package:pomodolo/data/sharedpreference/sharedPreferencesData.dart';

import '../../shared/enum.dart';

class Auth {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //log in function
  Future<EmailLogInResults> logInUserWithEmailandPassword(
      String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;
      if (user != null) {
        return EmailLogInResults.LogInCompleted;
      } else {
        print('nani!!!');
        final bool logOutResponse = await signOut();
        if (logOutResponse) return EmailLogInResults.EmailNotVerified;
        return EmailLogInResults.UnexpectedError;
      }
    } on FirebaseAuthException catch (e) {
      print('kokodayone');
      print(e);
      return EmailLogInResults.EmailPasswordInvalid;
    }
  }

  //register
  Future<EmailSignResults> registerUserWithEmailandPassword(
      String name, String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        //call our database service to update the user data
        await FireStore(uid: user.uid).savingUserData(name, email);
        return EmailSignResults.SignUpCompleted;
      }
      return EmailSignResults.SignUpNotCompleted;
    } on FirebaseAuthException catch (e) {
      print(e);
      return EmailSignResults.EmailAlreadyPresent;
    }
  }

  //sign out
  Future signOut() async {
    try {
      await SharedPreferencesData().saveUserLoggedInStatus(false);
      await SharedPreferencesData().saveUserEmailSF('');
      await SharedPreferencesData().saveUserNameSF('');
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}
