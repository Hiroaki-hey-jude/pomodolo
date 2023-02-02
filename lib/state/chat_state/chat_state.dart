import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pomodolo/data/model/chat_message_model.dart';
import 'package:pomodolo/data/model/user_model.dart';
import 'package:uuid/uuid.dart';

part 'chat_state.freezed.dart';

final chatStateProvider = StateNotifierProvider<ChatStateNotifier, ChatState>(
  (ref) => ChatStateNotifier(),
);

@freezed
class ChatState with _$ChatState {
  const factory ChatState({
    @Default(false) bool isLoading,
    @Default(null) UserModel? currentUser,
    @Default(<UserModel>[]) List<UserModel> userList,
    @Default(null) String? errorMessage,
  }) = _ChatState;
}

class ChatStateNotifier extends StateNotifier<ChatState> {
  ChatStateNotifier() : super(const ChatState()) {
    print('tooafoksao');
    init();
  }

  Future<void> init() async {
    try {
      state = state.copyWith(isLoading: true);
      await fetchCurrentUserInfo();
      await fetchUserInfo();
    } catch (e) {
      if (mounted) {
        log(e.toString());
        state = state.copyWith(errorMessage: '何らかのエラーが発生しました。');
      }
    } finally {
      if (mounted) {
        state = state.copyWith(isLoading: false);
      }
    }
  }

  // チャットで使用するログインユーザー情報取得
  Future<void> fetchCurrentUserInfo() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final model =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final userModel = UserModel.fromSnapshot(model);
    if (!mounted) {
      return;
    }
    state = state.copyWith(currentUser: userModel);
  }

  // チャットで使用するログインユーザー情報取得
  Future<void> fetchUserInfo() async {
    List<UserModel> list = [];
    final users = await FirebaseFirestore.instance.collection('users').get();
    for (var element in users.docs) {
      list.add(UserModel.fromSnapshot(element));
    }
    state = state.copyWith(userList: list);
  }

  // チャット一覧をストリームで取得
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchChatMessages() async* {
    yield* FirebaseFirestore.instance
        .collection('chat')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

// チャット送信ボタンフィールドの挙動(firestoreにチャットメッセージ書き込み)
  Future<void> handleSendPressed(String message) async {
    try {
      // 文字数が10001文字以上の場合はerrorMessageのstateを更新してもモーダル表示
      if (message.length > 10000) {
        state = state.copyWith(errorMessage: '10000字以内で入力してください');
        return;
      }
      state = state.copyWith(isLoading: true);

      // fireStoreに保存するデータ
      final chatMessage = ChatMessageModel(
        id: const Uuid().v4(),
        userId: state.currentUser!.uid,
        userName: state.currentUser!.name,
        messageText: message,
        sendTime: DateTime.now(),
        createdAt: DateTime.now(),
        // deviceTokens: deviceTokens,
      );

      await FirebaseFirestore.instance
          .collection('chat')
          .doc()
          .set(chatMessage.toJson());
    } on Exception catch (e) {
      print(e.toString());
      state = state.copyWith(errorMessage: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
