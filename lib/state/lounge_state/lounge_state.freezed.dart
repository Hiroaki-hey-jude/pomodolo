// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lounge_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LoungeState {
  bool get isLoading => throw _privateConstructorUsedError;
  Timer? get timer => throw _privateConstructorUsedError;
  DateTime get time => throw _privateConstructorUsedError;
  bool get isResting => throw _privateConstructorUsedError;
  PomodoloModel get pomodoloModel => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoungeStateCopyWith<LoungeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoungeStateCopyWith<$Res> {
  factory $LoungeStateCopyWith(
          LoungeState value, $Res Function(LoungeState) then) =
      _$LoungeStateCopyWithImpl<$Res, LoungeState>;
  @useResult
  $Res call(
      {bool isLoading,
      Timer? timer,
      DateTime time,
      bool isResting,
      PomodoloModel pomodoloModel});

  $PomodoloModelCopyWith<$Res> get pomodoloModel;
}

/// @nodoc
class _$LoungeStateCopyWithImpl<$Res, $Val extends LoungeState>
    implements $LoungeStateCopyWith<$Res> {
  _$LoungeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? timer = freezed,
    Object? time = null,
    Object? isResting = null,
    Object? pomodoloModel = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      timer: freezed == timer
          ? _value.timer
          : timer // ignore: cast_nullable_to_non_nullable
              as Timer?,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isResting: null == isResting
          ? _value.isResting
          : isResting // ignore: cast_nullable_to_non_nullable
              as bool,
      pomodoloModel: null == pomodoloModel
          ? _value.pomodoloModel
          : pomodoloModel // ignore: cast_nullable_to_non_nullable
              as PomodoloModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PomodoloModelCopyWith<$Res> get pomodoloModel {
    return $PomodoloModelCopyWith<$Res>(_value.pomodoloModel, (value) {
      return _then(_value.copyWith(pomodoloModel: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_LoungeStateCopyWith<$Res>
    implements $LoungeStateCopyWith<$Res> {
  factory _$$_LoungeStateCopyWith(
          _$_LoungeState value, $Res Function(_$_LoungeState) then) =
      __$$_LoungeStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      Timer? timer,
      DateTime time,
      bool isResting,
      PomodoloModel pomodoloModel});

  @override
  $PomodoloModelCopyWith<$Res> get pomodoloModel;
}

/// @nodoc
class __$$_LoungeStateCopyWithImpl<$Res>
    extends _$LoungeStateCopyWithImpl<$Res, _$_LoungeState>
    implements _$$_LoungeStateCopyWith<$Res> {
  __$$_LoungeStateCopyWithImpl(
      _$_LoungeState _value, $Res Function(_$_LoungeState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? timer = freezed,
    Object? time = null,
    Object? isResting = null,
    Object? pomodoloModel = null,
  }) {
    return _then(_$_LoungeState(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      timer: freezed == timer
          ? _value.timer
          : timer // ignore: cast_nullable_to_non_nullable
              as Timer?,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isResting: null == isResting
          ? _value.isResting
          : isResting // ignore: cast_nullable_to_non_nullable
              as bool,
      pomodoloModel: null == pomodoloModel
          ? _value.pomodoloModel
          : pomodoloModel // ignore: cast_nullable_to_non_nullable
              as PomodoloModel,
    ));
  }
}

/// @nodoc

class _$_LoungeState implements _LoungeState {
  const _$_LoungeState(
      {this.isLoading = false,
      this.timer,
      required this.time,
      this.isResting = false,
      required this.pomodoloModel});

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final Timer? timer;
  @override
  final DateTime time;
  @override
  @JsonKey()
  final bool isResting;
  @override
  final PomodoloModel pomodoloModel;

  @override
  String toString() {
    return 'LoungeState(isLoading: $isLoading, timer: $timer, time: $time, isResting: $isResting, pomodoloModel: $pomodoloModel)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LoungeState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.timer, timer) || other.timer == timer) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.isResting, isResting) ||
                other.isResting == isResting) &&
            (identical(other.pomodoloModel, pomodoloModel) ||
                other.pomodoloModel == pomodoloModel));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, isLoading, timer, time, isResting, pomodoloModel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LoungeStateCopyWith<_$_LoungeState> get copyWith =>
      __$$_LoungeStateCopyWithImpl<_$_LoungeState>(this, _$identity);
}

abstract class _LoungeState implements LoungeState {
  const factory _LoungeState(
      {final bool isLoading,
      final Timer? timer,
      required final DateTime time,
      final bool isResting,
      required final PomodoloModel pomodoloModel}) = _$_LoungeState;

  @override
  bool get isLoading;
  @override
  Timer? get timer;
  @override
  DateTime get time;
  @override
  bool get isResting;
  @override
  PomodoloModel get pomodoloModel;
  @override
  @JsonKey(ignore: true)
  _$$_LoungeStateCopyWith<_$_LoungeState> get copyWith =>
      throw _privateConstructorUsedError;
}
