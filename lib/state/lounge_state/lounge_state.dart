import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pomodolo/data/firebase/firestore.dart';
import 'package:pomodolo/data/model/pomodolo_model.dart';
import 'package:pomodolo/data/model/user_model.dart';
import 'package:pomodolo/shared/interval_type_enum.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../data/sharedpreference/sharedPreferencesData.dart';
import '../../shared/status.dart';

part 'lounge_state.freezed.dart';

final loungeStateProvider =
    StateNotifierProvider.autoDispose<LoungeStateNotifier, LoungeState>(
  (ref) => LoungeStateNotifier(),
);

@freezed
class LoungeState with _$LoungeState {
  const factory LoungeState({
    @Default(false) bool isLoading,
    @Default(null) Timer? timer,
    required DateTime time,
    @Default(false) bool isResting,
    @Default(IntervalType.rest) IntervalType intervalType,
    required PomodoloModel pomodoloModel,
    @Default(null) int? currentPomo,
    @Default(null) UserModel? currentUser,
    @Default(null) String? userName,
  }) = _LoungeState;
}

class LoungeStateNotifier extends StateNotifier<LoungeState>
    with WidgetsBindingObserver {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  bool? _isTimerPaused; // バックグラウンドに遷移した際にタイマーがもともと起動中で、停止したかどうか
  late DateTime? _pausedTime = null; // バックグラウンドに遷移した時間
  late int? _notificationId; // 通知ID
  LoungeStateNotifier()
      : super(LoungeState(
          time: DateTime.utc(0, 0, 0).add(const Duration(minutes: 25)),
          pomodoloModel: const PomodoloModel(status: Status.initial),
        )) {
    // タイムゾーンを初期化
    _initialize();
    tz.initializeTimeZones();
    var tokyo = tz.getLocation('Asia/Tokyo');
    tz.setLocalLocation(tokyo);
    getUserData();
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
        handleOnPaused();
        break;
      case AppLifecycleState.paused:
        print('停止されたときの処理');
        FireStore().toggleOnline(false);
        break;
      case AppLifecycleState.resumed:
        print('再開されたときの処理');
        FireStore().toggleOnline(true);
        handleOnResumed();
        break;
      case AppLifecycleState.detached:
        print('破棄されたときの処理');
        FireStore().toggleOnline(false);
        _notificationId = null;
        _pausedTime = null;
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> getUserData() async {
    final userName = await SharedPreferencesData().getUserNameFromSF();
    final userModel =
        await FireStore(uid: FirebaseAuth.instance.currentUser!.uid)
            .getCurrentUserModel();
    if (!mounted) {
      return;
    }
    state = state.copyWith(
      userName: userName,
      currentUser: userModel,
    );
  }

  // 時間がゼロになったらタイマーを止める
  void handleTimeIsOver() {
    if (state.timer != null &&
        state.timer!.isActive &&
        state.time == DateTime.utc(0, 0, 0)) {
      state.timer!.cancel();
      state = state.copyWith(
        pomodoloModel: const PomodoloModel(status: Status.stopped),
      );
      if (state.intervalType == IntervalType.rest) {
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
      if (state.isResting == false) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update(
          {
            'currentNumOfPomo': FieldValue.increment(1),
            'totalPomo': FieldValue.increment(1),
          },
        );
      }
      //pomodoloModel = pomodoloModel.copyWith(status: Status.stopped);
    }
  }

  void stopTimer() {
    state.timer!.cancel();
    state = state.copyWith(
      pomodoloModel: const PomodoloModel(status: Status.stopped),
    );
  }

  // タイマーを開始する
  void startTimer() {
    print('adsfadgfadgagmsdi!!!!');
    if ((state.pomodoloModel.status == Status.initial &&
            state.intervalType == IntervalType.work) ||
        state.pomodoloModel.status == Status.stopped) {
      print(state.pomodoloModel.status);
      print(state.intervalType);
      state = state.copyWith(
          timer: Timer.periodic(const Duration(seconds: 1), (Timer timer) {
        state =
            state.copyWith(time: state.time.add(const Duration(seconds: -1)));
        handleTimeIsOver();
      }));
      state = state.copyWith(
          pomodoloModel: const PomodoloModel(status: Status.started));
      print(state.pomodoloModel.status);
      print('startボタン押した後');
      //pomodoloModel = pomodoloModel.copyWith(status: Status.started);
    }
  }

  void workOrRest(bool value) {
    print(state.pomodoloModel.status);
    print(state.intervalType);
    if (state.pomodoloModel.status == Status.initial) {
      print('ifの中');
      if (value == true) {
        state = state.copyWith(
          isResting: true,
          intervalType: IntervalType.rest,
        );
        state = state.copyWith(
          time: DateTime.utc(0, 0, 0).add(
            const Duration(minutes: 1),
          ),
        );
      } else {
        state = state.copyWith(
          isResting: false,
          intervalType: IntervalType.work,
        );
        state = state.copyWith(
          time: DateTime.utc(0, 0, 0).add(
            const Duration(minutes: 1),
          ),
        );
      }
    } else {
      if (value == true) {
        state = state.copyWith(
          intervalType: IntervalType.rest,
          pomodoloModel: const PomodoloModel(status: Status.stopped),
        );
        //pomodoloModel = pomodoloModel.copyWith(status: Status.stopped);
        state = state.copyWith(
          isResting: true,
          time: DateTime.utc(0, 0, 0).add(
            const Duration(minutes: 1),
          ),
        );
        print(state.intervalType);
      } else {
        state = state.copyWith(
          intervalType: IntervalType.work,
          pomodoloModel: const PomodoloModel(status: Status.stopped),
        );
        //pomodoloModel = pomodoloModel.copyWith(status: Status.stopped);
        state = state.copyWith(isResting: false);
        state = state.copyWith(
          time: DateTime.utc(0, 0, 0).add(
            const Duration(minutes: 1),
          ),
        );
      }
    }
    if (state.timer != null && state.pomodoloModel.status != Status.started) {
      state.timer!.cancel(); //timerストップ
    }
  }

  void resetTimer() {
    if (state.intervalType == IntervalType.work) {
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
      pomodoloModel: const PomodoloModel(status: Status.initial),
    );
  }

  //アプリがバックグラウンドに行った時の処理
  void handleOnPaused() {
    if (state.timer == null) {
      return;
    }
    print('offlineになりました');
    if (state.timer!.isActive) {
      _isTimerPaused = true;
      state.timer!.cancel(); // タイマーを停止する
      state = state.copyWith(
          pomodoloModel: const PomodoloModel(status: Status.stopped));
      //pomodoloModel = pomodoloModel.copyWith(status: Status.stopped);
      print('timer cancelled');
    }
    _pausedTime = DateTime.now(); // バックグラウンドに遷移した時間を記録
    _notificationId = scheduleLocalNotification(
        state.time.difference(DateTime.utc(0, 0, 0))); // ローカル通知をスケジュール登録
  }

  void handleOnResumed() {
    if (_isTimerPaused == null && _pausedTime == null) {
      return;
    } // タイマーが動いてなければ何もしない
    Duration backgroundDuration =
        DateTime.now().difference(_pausedTime!); // バックグラウンドでの経過時間

    // バックグラウンドでの経過時間が終了予定を超えていた場合（この場合は通知実行済みのはず）
    if (state.time
            .difference(DateTime.utc(0, 0, 0))
            .compareTo(backgroundDuration) <
        0) {
      if (state.isResting == true) {
        state = state.copyWith(
            time: DateTime.utc(0, 0, 0).add(
          const Duration(minutes: 5),
        ));
      } else {
        state = state.copyWith(
          time: DateTime.utc(0, 0, 0).add(
            const Duration(minutes: 25),
          ),
        );
      }
      if (state.isResting == false) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update(
          {
            'currentNumOfPomo': FieldValue.increment(1),
          },
        );
      }
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
    print('${_notificationId}リセットできてる？');
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

  Future<void> initialStart(String objectve, int goalPomo, String uid) async {
    state = state.copyWith(intervalType: IntervalType.work);
    await FireStore().startTimer(goalPomo, objectve, uid);
    await getUserData();
  }

  changeState() {
    state = state.copyWith(
        pomodoloModel: const PomodoloModel(status: Status.initial));
  }
}
