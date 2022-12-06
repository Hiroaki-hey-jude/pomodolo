// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      uid: json['uid'] as String? ?? '',
      userName: json['userName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      iconUrl: json['iconUrl'] as String? ?? '',
      goalPomo: json['goalPomo'] as int? ?? 0,
      currentNumOfPomo: json['currentNumOfPomo'] as int? ?? 0,
      hasTimerLock: json['hasTimerLock'] as bool? ?? false,
      hasChatLock: json['hasChatLock'] as bool? ?? false,
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'userName': instance.userName,
      'email': instance.email,
      'iconUrl': instance.iconUrl,
      'goalPomo': instance.goalPomo,
      'currentNumOfPomo': instance.currentNumOfPomo,
      'hasTimerLock': instance.hasTimerLock,
      'hasChatLock': instance.hasChatLock,
    };
