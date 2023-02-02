// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      uid: json['uid'] as String? ?? '',
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      profilePic: json['profilePic'] as String? ?? null,
      objective: json['objective'] as String? ?? '',
      goalPomo: json['goalPomo'] as int? ?? 0,
      currentNumOfPomo: json['currentNumOfPomo'] as int? ?? 0,
      totalPomo: json['totalPomo'] as int? ?? 0,
      isOnline: json['isOnline'] as bool? ?? false,
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'email': instance.email,
      'profilePic': instance.profilePic,
      'objective': instance.objective,
      'goalPomo': instance.goalPomo,
      'currentNumOfPomo': instance.currentNumOfPomo,
      'totalPomo': instance.totalPomo,
      'isOnline': instance.isOnline,
    };
