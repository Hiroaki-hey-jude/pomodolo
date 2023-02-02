// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChatMessageModel _$ChatMessageModelFromJson(Map<String, dynamic> json) {
  return _ChatMessageModel.fromJson(json);
}

/// @nodoc
mixin _$ChatMessageModel {
  String? get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String? get userImageUrl => throw _privateConstructorUsedError;
  String? get messageText => throw _privateConstructorUsedError;
  String? get localImagePath => throw _privateConstructorUsedError;
  String? get storageImagePath => throw _privateConstructorUsedError;
  String? get messageImageName => throw _privateConstructorUsedError;
  int? get messageImageSize => throw _privateConstructorUsedError;
  @TimestampDateTimeConverter()
  DateTime? get sendTime => throw _privateConstructorUsedError;
  @TimestampDateTimeConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @TimestampDateTimeConverter()
  DateTime? get deletedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatMessageModelCopyWith<ChatMessageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageModelCopyWith<$Res> {
  factory $ChatMessageModelCopyWith(
          ChatMessageModel value, $Res Function(ChatMessageModel) then) =
      _$ChatMessageModelCopyWithImpl<$Res, ChatMessageModel>;
  @useResult
  $Res call(
      {String? id,
      String userId,
      String userName,
      String? userImageUrl,
      String? messageText,
      String? localImagePath,
      String? storageImagePath,
      String? messageImageName,
      int? messageImageSize,
      @TimestampDateTimeConverter() DateTime? sendTime,
      @TimestampDateTimeConverter() DateTime? createdAt,
      @TimestampDateTimeConverter() DateTime? deletedAt});
}

/// @nodoc
class _$ChatMessageModelCopyWithImpl<$Res, $Val extends ChatMessageModel>
    implements $ChatMessageModelCopyWith<$Res> {
  _$ChatMessageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = null,
    Object? userName = null,
    Object? userImageUrl = freezed,
    Object? messageText = freezed,
    Object? localImagePath = freezed,
    Object? storageImagePath = freezed,
    Object? messageImageName = freezed,
    Object? messageImageSize = freezed,
    Object? sendTime = freezed,
    Object? createdAt = freezed,
    Object? deletedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userImageUrl: freezed == userImageUrl
          ? _value.userImageUrl
          : userImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      messageText: freezed == messageText
          ? _value.messageText
          : messageText // ignore: cast_nullable_to_non_nullable
              as String?,
      localImagePath: freezed == localImagePath
          ? _value.localImagePath
          : localImagePath // ignore: cast_nullable_to_non_nullable
              as String?,
      storageImagePath: freezed == storageImagePath
          ? _value.storageImagePath
          : storageImagePath // ignore: cast_nullable_to_non_nullable
              as String?,
      messageImageName: freezed == messageImageName
          ? _value.messageImageName
          : messageImageName // ignore: cast_nullable_to_non_nullable
              as String?,
      messageImageSize: freezed == messageImageSize
          ? _value.messageImageSize
          : messageImageSize // ignore: cast_nullable_to_non_nullable
              as int?,
      sendTime: freezed == sendTime
          ? _value.sendTime
          : sendTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChatMessageModelCopyWith<$Res>
    implements $ChatMessageModelCopyWith<$Res> {
  factory _$$_ChatMessageModelCopyWith(
          _$_ChatMessageModel value, $Res Function(_$_ChatMessageModel) then) =
      __$$_ChatMessageModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String userId,
      String userName,
      String? userImageUrl,
      String? messageText,
      String? localImagePath,
      String? storageImagePath,
      String? messageImageName,
      int? messageImageSize,
      @TimestampDateTimeConverter() DateTime? sendTime,
      @TimestampDateTimeConverter() DateTime? createdAt,
      @TimestampDateTimeConverter() DateTime? deletedAt});
}

/// @nodoc
class __$$_ChatMessageModelCopyWithImpl<$Res>
    extends _$ChatMessageModelCopyWithImpl<$Res, _$_ChatMessageModel>
    implements _$$_ChatMessageModelCopyWith<$Res> {
  __$$_ChatMessageModelCopyWithImpl(
      _$_ChatMessageModel _value, $Res Function(_$_ChatMessageModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = null,
    Object? userName = null,
    Object? userImageUrl = freezed,
    Object? messageText = freezed,
    Object? localImagePath = freezed,
    Object? storageImagePath = freezed,
    Object? messageImageName = freezed,
    Object? messageImageSize = freezed,
    Object? sendTime = freezed,
    Object? createdAt = freezed,
    Object? deletedAt = freezed,
  }) {
    return _then(_$_ChatMessageModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userImageUrl: freezed == userImageUrl
          ? _value.userImageUrl
          : userImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      messageText: freezed == messageText
          ? _value.messageText
          : messageText // ignore: cast_nullable_to_non_nullable
              as String?,
      localImagePath: freezed == localImagePath
          ? _value.localImagePath
          : localImagePath // ignore: cast_nullable_to_non_nullable
              as String?,
      storageImagePath: freezed == storageImagePath
          ? _value.storageImagePath
          : storageImagePath // ignore: cast_nullable_to_non_nullable
              as String?,
      messageImageName: freezed == messageImageName
          ? _value.messageImageName
          : messageImageName // ignore: cast_nullable_to_non_nullable
              as String?,
      messageImageSize: freezed == messageImageSize
          ? _value.messageImageSize
          : messageImageSize // ignore: cast_nullable_to_non_nullable
              as int?,
      sendTime: freezed == sendTime
          ? _value.sendTime
          : sendTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChatMessageModel implements _ChatMessageModel {
  const _$_ChatMessageModel(
      {this.id,
      required this.userId,
      required this.userName,
      this.userImageUrl,
      this.messageText,
      this.localImagePath,
      this.storageImagePath,
      this.messageImageName,
      this.messageImageSize,
      @TimestampDateTimeConverter() this.sendTime,
      @TimestampDateTimeConverter() this.createdAt,
      @TimestampDateTimeConverter() this.deletedAt});

  factory _$_ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$$_ChatMessageModelFromJson(json);

  @override
  final String? id;
  @override
  final String userId;
  @override
  final String userName;
  @override
  final String? userImageUrl;
  @override
  final String? messageText;
  @override
  final String? localImagePath;
  @override
  final String? storageImagePath;
  @override
  final String? messageImageName;
  @override
  final int? messageImageSize;
  @override
  @TimestampDateTimeConverter()
  final DateTime? sendTime;
  @override
  @TimestampDateTimeConverter()
  final DateTime? createdAt;
  @override
  @TimestampDateTimeConverter()
  final DateTime? deletedAt;

  @override
  String toString() {
    return 'ChatMessageModel(id: $id, userId: $userId, userName: $userName, userImageUrl: $userImageUrl, messageText: $messageText, localImagePath: $localImagePath, storageImagePath: $storageImagePath, messageImageName: $messageImageName, messageImageSize: $messageImageSize, sendTime: $sendTime, createdAt: $createdAt, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChatMessageModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userImageUrl, userImageUrl) ||
                other.userImageUrl == userImageUrl) &&
            (identical(other.messageText, messageText) ||
                other.messageText == messageText) &&
            (identical(other.localImagePath, localImagePath) ||
                other.localImagePath == localImagePath) &&
            (identical(other.storageImagePath, storageImagePath) ||
                other.storageImagePath == storageImagePath) &&
            (identical(other.messageImageName, messageImageName) ||
                other.messageImageName == messageImageName) &&
            (identical(other.messageImageSize, messageImageSize) ||
                other.messageImageSize == messageImageSize) &&
            (identical(other.sendTime, sendTime) ||
                other.sendTime == sendTime) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      userName,
      userImageUrl,
      messageText,
      localImagePath,
      storageImagePath,
      messageImageName,
      messageImageSize,
      sendTime,
      createdAt,
      deletedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChatMessageModelCopyWith<_$_ChatMessageModel> get copyWith =>
      __$$_ChatMessageModelCopyWithImpl<_$_ChatMessageModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChatMessageModelToJson(
      this,
    );
  }
}

abstract class _ChatMessageModel implements ChatMessageModel {
  const factory _ChatMessageModel(
          {final String? id,
          required final String userId,
          required final String userName,
          final String? userImageUrl,
          final String? messageText,
          final String? localImagePath,
          final String? storageImagePath,
          final String? messageImageName,
          final int? messageImageSize,
          @TimestampDateTimeConverter() final DateTime? sendTime,
          @TimestampDateTimeConverter() final DateTime? createdAt,
          @TimestampDateTimeConverter() final DateTime? deletedAt}) =
      _$_ChatMessageModel;

  factory _ChatMessageModel.fromJson(Map<String, dynamic> json) =
      _$_ChatMessageModel.fromJson;

  @override
  String? get id;
  @override
  String get userId;
  @override
  String get userName;
  @override
  String? get userImageUrl;
  @override
  String? get messageText;
  @override
  String? get localImagePath;
  @override
  String? get storageImagePath;
  @override
  String? get messageImageName;
  @override
  int? get messageImageSize;
  @override
  @TimestampDateTimeConverter()
  DateTime? get sendTime;
  @override
  @TimestampDateTimeConverter()
  DateTime? get createdAt;
  @override
  @TimestampDateTimeConverter()
  DateTime? get deletedAt;
  @override
  @JsonKey(ignore: true)
  _$$_ChatMessageModelCopyWith<_$_ChatMessageModel> get copyWith =>
      throw _privateConstructorUsedError;
}
