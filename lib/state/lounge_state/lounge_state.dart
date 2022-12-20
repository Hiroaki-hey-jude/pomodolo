import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
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
    required PomodoloModel pomodoloModel,
  }) = _LoungeState;
}

class LoungeStateNotifier extends StateNotifier<LoungeState>
    with WidgetsBindingObserver {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  //PomodoloModel pomodoloModel = PomodoloModel(status: Status.initial);
  //PomodoloModel workTime = PomodoloModel(25, Status.initial);
  bool? _isTimerPaused; // バックグラウンドに遷移した際にタイマーがもともと起動中で、停止したかどうか
  late DateTime? _pausedTime; // バックグラウンドに遷移した時間
  late int? _notificationId; // 通知ID
  IntervalType intervalType = IntervalType.work;
  LoungeStateNotifier()
      : super(LoungeState(
          time: DateTime.utc(0, 0, 0).add(Duration(minutes: 25)),
          pomodoloModel: PomodoloModel(status: Status.initial),
        )) {
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
        handleOnPaused();
        break;
      case AppLifecycleState.resumed:
        print('再開されたときの処理');
        handleOnResumed();
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
        state.time == DateTime.utc(0, 0, 0)) {
      state.timer!.cancel();
      state = state.copyWith(
        pomodoloModel: PomodoloModel(status: Status.stopped),
      );
      if (intervalType == IntervalType.rest) {
        state = state.copyWith(
            time: DateTime.utc(0, 0, 0).add(
          const Duration(minutes: 5),
        ));
      } else {
        state = state.copyWith(
            time: DateTime.utc(0, 0, 0).add(
          const Duration(minutes: 25),
        ));
      }
      //pomodoloModel = pomodoloModel.copyWith(status: Status.stopped);
    }
  }

  void stopTimer() {
    state.timer!.cancel();
    state = state.copyWith(
      pomodoloModel: PomodoloModel(status: Status.stopped),
    );
  }

  // タイマーを開始する
  void startTimer() {
    if (state.pomodoloModel.status == Status.initial ||
        state.pomodoloModel.status == Status.stopped) {
      print(state.pomodoloModel.status);
      print(intervalType);
      state = state.copyWith(
          timer: Timer.periodic(const Duration(seconds: 1), (Timer timer) {
        state =
            state.copyWith(time: state.time.add(const Duration(seconds: -1)));
        handleTimeIsOver();
      }));
      state =
          state.copyWith(pomodoloModel: PomodoloModel(status: Status.started));
      //pomodoloModel = pomodoloModel.copyWith(status: Status.started);
    }
  }

  void workOrRest(bool value) {
    if (value == true) {
      intervalType = IntervalType.rest;
      state = state.copyWith(
        pomodoloModel: PomodoloModel(status: Status.stopped),
      );
      //pomodoloModel = pomodoloModel.copyWith(status: Status.stopped);
      state = state.copyWith(isResting: true);
      state = state.copyWith(
        time: DateTime.utc(0, 0, 0).add(
          const Duration(minutes: 1),
        ),
      );
      print(intervalType);
    } else {
      intervalType = IntervalType.work;
      state = state.copyWith(
        pomodoloModel: PomodoloModel(status: Status.stopped),
      );
      //pomodoloModel = pomodoloModel.copyWith(status: Status.stopped);
      state = state.copyWith(isResting: false);
      state = state.copyWith(
        time: DateTime.utc(0, 0, 0).add(
          const Duration(minutes: 25),
        ),
      );
    }
    if (state.timer != null && state.pomodoloModel.status != Status.started) {
      state.timer!.cancel(); //timerストップ
    }
  }

  void resetTimer() {
    if (intervalType == IntervalType.work) {
      state = state.copyWith(
        time: DateTime.utc(0, 0, 0).add(
          const Duration(minutes: 25),
        ),
      );
    } else {
      state = state.copyWith(
        time: DateTime.utc(0, 0, 0).add(
          const Duration(minutes: 5),
        ),
      );
    }
    state = state.copyWith(
      pomodoloModel: PomodoloModel(status: Status.stopped),
    );
  }

  //アプリがバックグラウンドに行った時の処理
  void handleOnPaused() {
    if (state.timer == null) {
      return;
    }
    if (state.timer!.isActive) {
      _isTimerPaused = true;
      state.timer!.cancel(); // タイマーを停止する
      state =
          state.copyWith(pomodoloModel: PomodoloModel(status: Status.stopped));
      //pomodoloModel = pomodoloModel.copyWith(status: Status.stopped);
      print('timer cancelled');
    }
    _pausedTime = DateTime.now(); // バックグラウンドに遷移した時間を記録
    _notificationId = scheduleLocalNotification(
        state.time.difference(DateTime.utc(0, 0, 0))); // ローカル通知をスケジュール登録
  }

  void handleOnResumed() {
    if (_isTimerPaused == null) {
      return;
    } // タイマーが動いてなければ何もしない
    Duration backgroundDuration =
        DateTime.now().difference(_pausedTime!); // バックグラウンドでの経過時間

    // バックグラウンドでの経過時間が終了予定を超えていた場合（この場合は通知実行済みのはず）
    if (state.time
            .difference(DateTime.utc(0, 0, 0))
            .compareTo(backgroundDuration) <
        0) {
      state = state.copyWith(time: DateTime.utc(0, 0, 0)); // 時間をリセットする
    } else {
      state = state.copyWith(
          time: state.time.add(-backgroundDuration)); // バックグラウンド経過時間分時間を進める
      startTimer(); // タイマーを再開する
      print('timer resterted');
    }
    if (_notificationId != null) {
      flutterLocalNotificationsPlugin.cancel(_notificationId!); // 通知をキャンセル
    }
    _isTimerPaused = false; // リセット
    _notificationId = null; // リセット
    _pausedTime = null;
  }

  int scheduleLocalNotification(Duration duration) {
    print('notification set');
    flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        iOS: DarwinInitializationSettings(),
      ), // app_icon.pngを配置
    );
    int notificationId = DateTime.now().hashCode;
    flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId,
      'Time is over',
      '頑張ってるね',
      tz.TZDateTime.now(tz.local).add(duration),
      const NotificationDetails(
        iOS: DarwinNotificationDetails(),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
    return notificationId;
  }
}
