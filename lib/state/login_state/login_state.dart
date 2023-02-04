import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pomodolo/data/firebase/firestore.dart';
import 'package:pomodolo/data/model/user_model.dart';
import 'package:pomodolo/data/sharedpreference/sharedPreferencesData.dart';
import 'package:pomodolo/screen/lounge_screen.dart';

import '../../data/firebase/auth.dart';
import '../../screen/widgets/widgets.dart';
import '../../shared/enum.dart';

part 'login_state.freezed.dart';

// final userDataProvider = StateProvider<UserModel>((ref) {
//   return UserModel();
// });

final loginStateProvider =
    StateNotifierProvider<LoginStateNotifier, LoginState>(
  (ref) => LoginStateNotifier(),
);

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default(false) bool isLoading,
    @Default('') String password,
    UserModel? userModel,
    SharedPreferencesData? sharedPreferencesData,
    Auth? auth,
  }) = _LoginState;
}

class LoginStateNotifier extends StateNotifier<LoginState> {
  LoginStateNotifier() : super(const LoginState());

  Future<void> example() async {
    state = state.copyWith(isLoading: true);
    // なんかの処理する
    state = state.copyWith(isLoading: false);
  }

  void getEmail(String email) {
    state = state.copyWith(userModel: UserModel(email: email));
    print(state);
  }

  void getPassword(String password) {
    state = state.copyWith(password: password);
    print(state);
  }

  Future<void> login(
    BuildContext context,
    GlobalKey<FormState>? formKey,
    String email,
    String password,
  ) async {
    if (formKey!.currentState!.validate()) {
      state = state.copyWith(isLoading: true);
      final EmailLogInResults emailLogInResults =
          await Auth().logInUserWithEmailandPassword(
        email,
        password,
      );
      String message = '';
      if (emailLogInResults == EmailLogInResults.LogInCompleted) {
        QuerySnapshot snapshot =
            await FireStore(uid: FirebaseAuth.instance.currentUser!.uid)
                .gettingUserData(email);
        await SharedPreferencesData().saveUserLoggedInStatus(true);
        await SharedPreferencesData().saveUserEmailSF(email);
        await SharedPreferencesData()
            .saveUserNameSF(snapshot.docs[0]['name']); //naze
        print(snapshot.docs[0]['name']);
        nextScreenReplacement(context, const LoungeScreen());
      } else if (emailLogInResults == EmailLogInResults.EmailNotVerified) {
        message =
            'メールアドレスが確認されませんでした \nユーザー登録をしてください';
      } else if (emailLogInResults == EmailLogInResults.EmailPasswordInvalid) {
        message = 'メールアドレスかパスワードが違います';
      } else
        message = 'ログインに失敗しました';

      if (message != '')
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message)));
      state = state.copyWith(isLoading: false);
    } else {
      print('not Validated');
    }
  }
}
