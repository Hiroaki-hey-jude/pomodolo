// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LoginState {
  bool get isLoading => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  UserModel? get userModel => throw _privateConstructorUsedError;
  SharedPreferencesData? get sharedPreferencesData =>
      throw _privateConstructorUsedError;
  Auth? get auth => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginStateCopyWith<LoginState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginStateCopyWith<$Res> {
  factory $LoginStateCopyWith(
          LoginState value, $Res Function(LoginState) then) =
      _$LoginStateCopyWithImpl<$Res, LoginState>;
  @useResult
  $Res call(
      {bool isLoading,
      String password,
      UserModel? userModel,
      SharedPreferencesData? sharedPreferencesData,
      Auth? auth});

  $UserModelCopyWith<$Res>? get userModel;
}

/// @nodoc
class _$LoginStateCopyWithImpl<$Res, $Val extends LoginState>
    implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? password = null,
    Object? userModel = freezed,
    Object? sharedPreferencesData = freezed,
    Object? auth = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      userModel: freezed == userModel
          ? _value.userModel
          : userModel // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      sharedPreferencesData: freezed == sharedPreferencesData
          ? _value.sharedPreferencesData
          : sharedPreferencesData // ignore: cast_nullable_to_non_nullable
              as SharedPreferencesData?,
      auth: freezed == auth
          ? _value.auth
          : auth // ignore: cast_nullable_to_non_nullable
              as Auth?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get userModel {
    if (_value.userModel == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.userModel!, (value) {
      return _then(_value.copyWith(userModel: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_LoginStateCopyWith<$Res>
    implements $LoginStateCopyWith<$Res> {
  factory _$$_LoginStateCopyWith(
          _$_LoginState value, $Res Function(_$_LoginState) then) =
      __$$_LoginStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      String password,
      UserModel? userModel,
      SharedPreferencesData? sharedPreferencesData,
      Auth? auth});

  @override
  $UserModelCopyWith<$Res>? get userModel;
}

/// @nodoc
class __$$_LoginStateCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$_LoginState>
    implements _$$_LoginStateCopyWith<$Res> {
  __$$_LoginStateCopyWithImpl(
      _$_LoginState _value, $Res Function(_$_LoginState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? password = null,
    Object? userModel = freezed,
    Object? sharedPreferencesData = freezed,
    Object? auth = freezed,
  }) {
    return _then(_$_LoginState(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      userModel: freezed == userModel
          ? _value.userModel
          : userModel // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      sharedPreferencesData: freezed == sharedPreferencesData
          ? _value.sharedPreferencesData
          : sharedPreferencesData // ignore: cast_nullable_to_non_nullable
              as SharedPreferencesData?,
      auth: freezed == auth
          ? _value.auth
          : auth // ignore: cast_nullable_to_non_nullable
              as Auth?,
    ));
  }
}

/// @nodoc

class _$_LoginState implements _LoginState {
  const _$_LoginState(
      {this.isLoading = false,
      this.password = '',
      this.userModel,
      this.sharedPreferencesData,
      this.auth});

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final String password;
  @override
  final UserModel? userModel;
  @override
  final SharedPreferencesData? sharedPreferencesData;
  @override
  final Auth? auth;

  @override
  String toString() {
    return 'LoginState(isLoading: $isLoading, password: $password, userModel: $userModel, sharedPreferencesData: $sharedPreferencesData, auth: $auth)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LoginState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.userModel, userModel) ||
                other.userModel == userModel) &&
            (identical(other.sharedPreferencesData, sharedPreferencesData) ||
                other.sharedPreferencesData == sharedPreferencesData) &&
            (identical(other.auth, auth) || other.auth == auth));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, isLoading, password, userModel, sharedPreferencesData, auth);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LoginStateCopyWith<_$_LoginState> get copyWith =>
      __$$_LoginStateCopyWithImpl<_$_LoginState>(this, _$identity);
}

abstract class _LoginState implements LoginState {
  const factory _LoginState(
      {final bool isLoading,
      final String password,
      final UserModel? userModel,
      final SharedPreferencesData? sharedPreferencesData,
      final Auth? auth}) = _$_LoginState;

  @override
  bool get isLoading;
  @override
  String get password;
  @override
  UserModel? get userModel;
  @override
  SharedPreferencesData? get sharedPreferencesData;
  @override
  Auth? get auth;
  @override
  @JsonKey(ignore: true)
  _$$_LoginStateCopyWith<_$_LoginState> get copyWith =>
      throw _privateConstructorUsedError;
}
