// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ChatState {
  bool get isLoading => throw _privateConstructorUsedError;
  UserModel? get currentUser => throw _privateConstructorUsedError;
  List<UserModel> get userList => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChatStateCopyWith<ChatState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatStateCopyWith<$Res> {
  factory $ChatStateCopyWith(ChatState value, $Res Function(ChatState) then) =
      _$ChatStateCopyWithImpl<$Res, ChatState>;
  @useResult
  $Res call(
      {bool isLoading,
      UserModel? currentUser,
      List<UserModel> userList,
      String? errorMessage});

  $UserModelCopyWith<$Res>? get currentUser;
}

/// @nodoc
class _$ChatStateCopyWithImpl<$Res, $Val extends ChatState>
    implements $ChatStateCopyWith<$Res> {
  _$ChatStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? currentUser = freezed,
    Object? userList = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      currentUser: freezed == currentUser
          ? _value.currentUser
          : currentUser // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      userList: null == userList
          ? _value.userList
          : userList // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get currentUser {
    if (_value.currentUser == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.currentUser!, (value) {
      return _then(_value.copyWith(currentUser: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ChatStateCopyWith<$Res> implements $ChatStateCopyWith<$Res> {
  factory _$$_ChatStateCopyWith(
          _$_ChatState value, $Res Function(_$_ChatState) then) =
      __$$_ChatStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      UserModel? currentUser,
      List<UserModel> userList,
      String? errorMessage});

  @override
  $UserModelCopyWith<$Res>? get currentUser;
}

/// @nodoc
class __$$_ChatStateCopyWithImpl<$Res>
    extends _$ChatStateCopyWithImpl<$Res, _$_ChatState>
    implements _$$_ChatStateCopyWith<$Res> {
  __$$_ChatStateCopyWithImpl(
      _$_ChatState _value, $Res Function(_$_ChatState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? currentUser = freezed,
    Object? userList = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$_ChatState(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      currentUser: freezed == currentUser
          ? _value.currentUser
          : currentUser // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      userList: null == userList
          ? _value._userList
          : userList // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_ChatState implements _ChatState {
  const _$_ChatState(
      {this.isLoading = false,
      this.currentUser = null,
      final List<UserModel> userList = const <UserModel>[],
      this.errorMessage = null})
      : _userList = userList;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final UserModel? currentUser;
  final List<UserModel> _userList;
  @override
  @JsonKey()
  List<UserModel> get userList {
    if (_userList is EqualUnmodifiableListView) return _userList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userList);
  }

  @override
  @JsonKey()
  final String? errorMessage;

  @override
  String toString() {
    return 'ChatState(isLoading: $isLoading, currentUser: $currentUser, userList: $userList, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChatState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.currentUser, currentUser) ||
                other.currentUser == currentUser) &&
            const DeepCollectionEquality().equals(other._userList, _userList) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, currentUser,
      const DeepCollectionEquality().hash(_userList), errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChatStateCopyWith<_$_ChatState> get copyWith =>
      __$$_ChatStateCopyWithImpl<_$_ChatState>(this, _$identity);
}

abstract class _ChatState implements ChatState {
  const factory _ChatState(
      {final bool isLoading,
      final UserModel? currentUser,
      final List<UserModel> userList,
      final String? errorMessage}) = _$_ChatState;

  @override
  bool get isLoading;
  @override
  UserModel? get currentUser;
  @override
  List<UserModel> get userList;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$_ChatStateCopyWith<_$_ChatState> get copyWith =>
      throw _privateConstructorUsedError;
}
