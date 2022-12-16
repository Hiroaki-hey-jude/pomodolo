// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pomodolo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PomodoloModel _$$_PomodoloModelFromJson(Map<String, dynamic> json) =>
    _$_PomodoloModel(
      status: $enumDecodeNullable(_$StatusEnumMap, json['status']),
      time: json['time'] as int?,
    );

Map<String, dynamic> _$$_PomodoloModelToJson(_$_PomodoloModel instance) =>
    <String, dynamic>{
      'status': _$StatusEnumMap[instance.status],
      'time': instance.time,
    };

const _$StatusEnumMap = {
  Status.initial: 'initial',
  Status.started: 'started',
  Status.stopped: 'stopped',
};
