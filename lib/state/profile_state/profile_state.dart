import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pomodolo/data/model/user_model.dart';
import 'package:pomodolo/data/sharedpreference/sharedPreferencesData.dart';

part 'profile_state.freezed.dart';

final profileStateProvider =
    StateNotifierProvider<ProfileStateNotifier, ProfileState>(
  (ref) => ProfileStateNotifier(),
);

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(false) bool isLoading,
    required UserModel userModel,
    File? imageFile,
  }) = _ProfileState;
}

class ProfileStateNotifier extends StateNotifier<ProfileState> {
  ProfileStateNotifier() : super(const ProfileState(userModel: UserModel())) {
    getUserData();
  }
  String imgURL =
      'https://images.unsplash.com/flagged/photo-1572392640988-ba48d1a74457?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=928&q=80';

  final picker = ImagePicker();
  String? changedUserName;
  Future<void> example() async {
    state = state.copyWith(isLoading: true);
    // なんかの処理する
    state = state.copyWith(isLoading: false);
  }

  getUserData() async {
    await SharedPreferencesData().getUserEmailFromSF().then((value) {
      state = state.copyWith(userModel: UserModel(email: value!));
    });
    await SharedPreferencesData().getUserNameFromSF().then((value) {
      state = state.copyWith(userModel: UserModel(userName: value!));
    });
  }

  Future<void> pickImage() async {
    print('picked fileに入った');
    //ライブラリを開いて選択
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 600,
      maxWidth: 600,
    );

    // 画像が選択されなかった場合はスキップ
    if (pickedFile == null) {
      print('まさかここ？');
      return;
    }

    //選択した画像ファイルを代入
    state = state.copyWith(imageFile: File(pickedFile.path));
  }

  Future updateProfilePic() async {
    state = state.copyWith(isLoading: true);
    final DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (state.imageFile != null && changedUserName != null) {
      state = state.copyWith(userModel: UserModel(userName: changedUserName!));
      print('kokokitemasuka');
      print(state.userModel.userName);
      final ref = FirebaseStorage.instance
          .ref()
          .child('profileimages')
          .child(state.userModel.userName + '.jpg');
      await ref.putFile(state.imageFile!);
      imgURL = await ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'profilePic': imgURL,
        'name': state.userModel.userName,
      });
      state = state.copyWith(isLoading: false);
    } else if (state.imageFile != null) {
      final ref = FirebaseStorage.instance
          .ref()
          .child('profileimages')
          .child(state.userModel.userName + '.jpg');
      await ref.putFile(state.imageFile!);
      imgURL = await ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'profilePic': imgURL,
      });
      state = state.copyWith(isLoading: false);
    } else if (changedUserName != null) {
      state = state.copyWith(userModel: UserModel(userName: changedUserName!));
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'name': state.userModel.userName,
      });
      state = state.copyWith(isLoading: false);
    } else {
      state = state.copyWith(isLoading: false);
      return null;
    }
  }

  changeUserName(String name) {
    print('change user name');
    changedUserName = name;
  }
}
