import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../shared/status.dart';

part 'pomodolo_model.freezed.dart';
part 'pomodolo_model.g.dart';

@freezed
class PomodoloModel with _$PomodoloModel {
  const factory PomodoloModel({
    required Status status,
    required int time,
  }) = _PomodoloModel;

  factory PomodoloModel.fromJson(Map<String, dynamic> json) =>
      _$PomodoloModelFromJson(json);

  factory PomodoloModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) =>
      PomodoloModel.fromJson(snapshot.data()!);
}
