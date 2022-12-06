import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    @Default('') String uid,
    @Default('') String userName,
    @Default('') String email,
    @Default('') String iconUrl,
    @Default(0) int goalPomo,
    @Default(0) int currentNumOfPomo,
    @Default(false) bool hasTimerLock,
    @Default(false) bool hasChatLock,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) =>
      UserModel.fromJson(snapshot.data()!);
}
