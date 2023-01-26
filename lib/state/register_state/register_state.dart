import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pomodolo/screen/lounge_screen.dart';

import '../../data/firebase/auth.dart';
import '../../data/model/user_model.dart';
import '../../data/sharedpreference/sharedPreferencesData.dart';
import '../../screen/widgets/widgets.dart';
import '../../shared/enum.dart';

part 'register_state.freezed.dart';

final registerStateProvider =
    StateNotifierProvider<RegisterStateNotifier, RegisterState>(
  (ref) => RegisterStateNotifier(),
);

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState({
    @Default(false) bool isLoading,
    @Default('') String password,
    UserModel? userModel,
  }) = _RegisterState;
}

class RegisterStateNotifier extends StateNotifier<RegisterState> {
  RegisterStateNotifier() : super(const RegisterState());

  // Future<void> example() async {
  //   // state = state.copyWith(isLoading: true);
  //   // // なんかの処理する
  //   // state = state.copyWith(isLoading: false);
  // }

  void getName(String userName) {
    print('hihi');
    state = state.copyWith(userModel: UserModel(userName: userName));
  }

  void getEmail(String email) {
    state = state.copyWith(userModel: UserModel(email: email));
  }

  void getPassword(String password) {
    state = state.copyWith(password: password);
    print(state);
  }

  Future<void> register(
    BuildContext context,
    GlobalKey<FormState>? formKey,
    String name,
    String email,
    String password,
  ) async {
    // if (state.formKey != null) {
    // if (formKey!.currentState!.validate()) {
      state = state.copyWith(isLoading: true);
      // state =
      //     state.copyWith(userModel: UserModel(userName: name, email: email));
      final EmailSignResults emailSignResults =
          await Auth().registerUserWithEmailandPassword(
        name,
        email,
        password,
      );
      String message = '';
      if (emailSignResults == EmailSignResults.SignUpCompleted) {
        print('ifの中');
        await SharedPreferencesData().saveUserLoggedInStatus(true);
        await SharedPreferencesData().saveUserEmailSF(email);
        await SharedPreferencesData().saveUserNameSF(name);
        nextScreenReplacement(context, const LoungeScreen());
      } else if (emailSignResults == EmailSignResults.SignUpNotCompleted) {
        message = 'Sign up not completed, try again';
      } else {
        message = 'Email alaready present';
      }
      if (message != '')
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message)));
      state = state.copyWith(isLoading: false);
    // } else {
    //   print('not Validated');
    // }
    // } else {
    //   print('not Validated');
    // }
  }
}
