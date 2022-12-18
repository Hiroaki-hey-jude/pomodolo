// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pomodolo_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PomodoloModel _$PomodoloModelFromJson(Map<String, dynamic> json) {
  return _PomodoloModel.fromJson(json);
}

/// @nodoc
mixin _$PomodoloModel {
  Status get status => throw _privateConstructorUsedError;
  int get time => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PomodoloModelCopyWith<PomodoloModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PomodoloModelCopyWith<$Res> {
  factory $PomodoloModelCopyWith(
          PomodoloModel value, $Res Function(PomodoloModel) then) =
      _$PomodoloModelCopyWithImpl<$Res, PomodoloModel>;
  @useResult
  $Res call({Status status, int time});
}

/// @nodoc
class _$PomodoloModelCopyWithImpl<$Res, $Val extends PomodoloModel>
    implements $PomodoloModelCopyWith<$Res> {
  _$PomodoloModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? time = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PomodoloModelCopyWith<$Res>
    implements $PomodoloModelCopyWith<$Res> {
  factory _$$_PomodoloModelCopyWith(
          _$_PomodoloModel value, $Res Function(_$_PomodoloModel) then) =
      __$$_PomodoloModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Status status, int time});
}

/// @nodoc
class __$$_PomodoloModelCopyWithImpl<$Res>
    extends _$PomodoloModelCopyWithImpl<$Res, _$_PomodoloModel>
    implements _$$_PomodoloModelCopyWith<$Res> {
  __$$_PomodoloModelCopyWithImpl(
      _$_PomodoloModel _value, $Res Function(_$_PomodoloModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? time = null,
  }) {
    return _then(_$_PomodoloModel(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PomodoloModel implements _PomodoloModel {
  const _$_PomodoloModel({required this.status, required this.time});

  factory _$_PomodoloModel.fromJson(Map<String, dynamic> json) =>
      _$$_PomodoloModelFromJson(json);

  @override
  final Status status;
  @override
  final int time;

  @override
  String toString() {
    return 'PomodoloModel(status: $status, time: $time)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PomodoloModel &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.time, time) || other.time == time));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, time);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PomodoloModelCopyWith<_$_PomodoloModel> get copyWith =>
      __$$_PomodoloModelCopyWithImpl<_$_PomodoloModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PomodoloModelToJson(
      this,
    );
  }
}

abstract class _PomodoloModel implements PomodoloModel {
  const factory _PomodoloModel(
      {required final Status status,
      required final int time}) = _$_PomodoloModel;

  factory _PomodoloModel.fromJson(Map<String, dynamic> json) =
      _$_PomodoloModel.fromJson;

  @override
  Status get status;
  @override
  int get time;
  @override
  @JsonKey(ignore: true)
  _$$_PomodoloModelCopyWith<_$_PomodoloModel> get copyWith =>
      throw _privateConstructorUsedError;
}
