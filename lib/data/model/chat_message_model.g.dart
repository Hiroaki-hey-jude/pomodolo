// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChatMessageModel _$$_ChatMessageModelFromJson(Map<String, dynamic> json) =>
    _$_ChatMessageModel(
      id: json['id'] as String?,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userImageUrl: json['userImageUrl'] as String?,
      messageText: json['messageText'] as String?,
      localImagePath: json['localImagePath'] as String?,
      storageImagePath: json['storageImagePath'] as String?,
      messageImageName: json['messageImageName'] as String?,
      messageImageSize: json['messageImageSize'] as int?,
      sendTime: const TimestampDateTimeConverter()
          .fromJson(json['sendTime'] as Timestamp?),
      createdAt: const TimestampDateTimeConverter()
          .fromJson(json['createdAt'] as Timestamp?),
      deletedAt: const TimestampDateTimeConverter()
          .fromJson(json['deletedAt'] as Timestamp?),
    );

Map<String, dynamic> _$$_ChatMessageModelToJson(_$_ChatMessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'userName': instance.userName,
      'userImageUrl': instance.userImageUrl,
      'messageText': instance.messageText,
      'localImagePath': instance.localImagePath,
      'storageImagePath': instance.storageImagePath,
      'messageImageName': instance.messageImageName,
      'messageImageSize': instance.messageImageSize,
      'sendTime': const TimestampDateTimeConverter().toJson(instance.sendTime),
      'createdAt':
          const TimestampDateTimeConverter().toJson(instance.createdAt),
      'deletedAt':
          const TimestampDateTimeConverter().toJson(instance.deletedAt),
    };
