import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodolo/data/model/chat_message_model.dart';
import 'package:pomodolo/state/chat_state/chat_state.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chatStateProvider);
    final notifier = ref.watch(chatStateProvider.notifier);

    return state.isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: notifier.fetchChatMessages(),
            builder: (context, snapshot) {
              print('asdfa');
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: ColoredBox(
                    color: Colors.white,
                    child: Text('エラーが発生しました'),
                  ),
                );
              }
              if (state.currentUser == null) {
                return const Center(
                  child: Text('ログインしてください'),
                );
              }

              // 画面に表示するための空配列を作成
              final messages = <types.Message>[];

              if (snapshot.hasData) {
                // firestoreからチャッメッセージリスト型で取得
                final list = snapshot.data!.docs;
                // flutter_chat_uiで使用するtypes.Userを定義
                types.User typeUser;

                final userList = ref
                    .watch(chatStateProvider.select((state) => state.userList));

                for (final snapShot in list) {
                  final messageModel = ChatMessageModel.fromSnapshot(snapShot);

                  // グループユーザーから1件づつ取得
                  for (final user in userList) {
                    // グループ内のユーザーIDとチャット投稿者IDが一致していれば、types.Userに一致したユーザー名を渡す。
                    // ※ユーザー名を変更時、変更したユーザー名を表示したい為、streamのsnapShotではなくuser情報からデータを取得
                    if (user.uid == messageModel.userId) {
                      String profile = '';
                      if (user.profilePic == null) {
                        profile =
                            'https://firebasestorage.googleapis.com/v0/b/pomo-58355.appspot.com/o/profileimages%2F%E3%81%97%E3%81%8A.jpg?alt=media&token=5368ecc5-6a4c-4900-9df8-3655bed49dbf';
                      } else {
                        profile = user.profilePic!;
                      }
                      typeUser = types.User(
                        id: user.uid,
                        firstName: user.name,
                        imageUrl: profile,
                      );

                      // flutter_chat_uiで使用するtypes.TextMessageにデーター代入
                      if (messageModel.messageText != null) {
                        final message = types.TextMessage(
                          id: messageModel.id!,
                          author: typeUser,
                          text: messageModel.messageText!,
                          createdAt:
                              messageModel.createdAt!.millisecondsSinceEpoch,
                        );
                        // messageをtypes.Message型の配列に代入
                        messages.add(message);
                      }

                      // flutter_chat_uiで使用するtypes.ImageMessageにデーター代入
                      if (messageModel.storageImagePath != null) {
                        final messageImage = types.ImageMessage(
                          id: messageModel.id!,
                          author: typeUser,
                          uri: messageModel.storageImagePath!,
                          name: messageModel.messageImageName!,
                          size: messageModel.messageImageSize!,
                          createdAt:
                              messageModel.createdAt!.millisecondsSinceEpoch,
                        );
                        // messageImageFileをtypes.Message型の配列に代入
                        messages.add(messageImage);
                      }
                    }
                  }
                }
                return Column(
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(
                            Icons.chevron_left,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Text(
                          'chat',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Chat(
                        user: types.User(
                          id: state.currentUser!.uid,
                          firstName: state.currentUser!.name,
                        ),
                        messages: messages,
                        onSendPressed: (message) {
                          notifier.handleSendPressed(message.text);
                        },
                        onMessageLongPress: (context, message) {}, // 削除処理ぽいのほしい
                        showUserAvatars: true,
                        showUserNames: true,
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: ColoredBox(
                    color: Colors.white,
                    child: Text(''),
                  ),
                );
              }
            });
  }
}
