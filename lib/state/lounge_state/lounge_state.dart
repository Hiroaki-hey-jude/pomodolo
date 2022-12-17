import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:pomodolo/data/model/pomodolo_model.dart';
import 'package:pomodolo/shared/interval_type_enum.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../shared/status.dart';

part 'lounge_state.freezed.dart';

final loungeStateProvider =
    StateNotifierProvider<LoungeStateNotifier, LoungeState>(
  (ref) => LoungeStateNotifier(),
);

@freezed
class LoungeState with _$LoungeState {
  const factory LoungeState({
    @Default(false) bool isLoading,
    Timer? timer,
    required DateTime time,
    @Default(false) bool isResting,
  }) = _LoungeState;
}

class LoungeStateNotifier extends StateNotifier<LoungeState>
    with WidgetsBindingObserver {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  PomodoloModel workTime = PomodoloModel(status: Status.initial, time: 25);
  PomodoloModel restTime = PomodoloModel(status: Status.initial, time: 5);
  // PomodoloModel workTime = PomodoloModel(25, Status.initial);
  bool _isTimerPaused = false; // バックグラウンドに遷移した際にタイマーがもともと起動中で、停止したかどうか
  late DateTime? _pausedTime; // バックグラウンドに遷移した時間
  late int? _notificationId; // 通知ID
  IntervalType intervalType = IntervalType.work;
  LoungeStateNotifier()
      : super(LoungeState(
            time: DateTime.utc(0, 0, 0).add(Duration(minutes: 25)))) {
    // タイムゾーンを初期化
    _initialize();
    tz.initializeTimeZones();
    var tokyo = tz.getLocation('Asia/Tokyo');
    tz.setLocalLocation(tokyo);
  }

  void _initialize() {
    WidgetsBinding.instance.addObserver(this);
  }

  // ライフサイクルが変更された際に呼び出される関数をoverrideして、変更を検知
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        print('非アクティブになったときの処理');
        break;
      case AppLifecycleState.paused:
        print('停止されたときの処理');
        break;
      case AppLifecycleState.resumed:
        print('再開されたときの処理');
        break;
      case AppLifecycleState.detached:
        print('破棄されたときの処理');
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // void handleOnPaused() {
  //   if()
  // }

  // 時間がゼロになったらタイマーを止める
  void handleTimeIsOver() {
    if (state.timer != null &&
        state.timer!.isActive &&
        state.time != null &&
        state.time == DateTime.utc(0, 0, 0)) {
      state.timer!.cancel();
    }
  }

  // タイマーを開始する
  void startTimer() {
    state = state.copyWith(
        timer: Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      state = state.copyWith(time: state.time.add(const Duration(seconds: -1)));
      handleTimeIsOver();
    }));
  }

  void workOrRest(bool value) {
    if (value == true) {
      state = state.copyWith(isResting: true);
      state = state.copyWith(
        time: DateTime.utc(0, 0, 0).add(
          const Duration(minutes: 5),
        ),
      );
    } else {
      state = state.copyWith(isResting: false);
      state = state.copyWith(
        time: DateTime.utc(0, 0, 0).add(
          const Duration(minutes: 25),
        ),
      );
    }
  }
}
