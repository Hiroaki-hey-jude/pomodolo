import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    @Default('') String uid,
    @Default('') String name,
    @Default('') String email,
    @Default(null) String? profilePic,
    @Default('') String objective,
    @Default(0) int goalPomo,
    @Default(0) int currentNumOfPomo,
    @Default(0) int totalPomo,
    @Default(false) bool isOnline,
    @Default(null) List<String>? blocks,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) =>
      UserModel.fromJson(snapshot.data()!);
}
