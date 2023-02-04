import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pomodolo/data/model/chat_message_model.dart';
import 'package:pomodolo/screen/widgets/widgets.dart';
import 'package:pomodolo/shared/constant.dart';
import 'package:pomodolo/state/chat_state/chat_state.dart';
import 'package:pomodolo/state/lounge_state/lounge_state.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chatStateProvider);
    final notifier = ref.watch(chatStateProvider.notifier);
    final loungeState = ref.watch(loungeStateProvider);

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: notifier.fetchChatMessages(),
        builder: (context, snapshot) {
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

            final userList =
                ref.watch(chatStateProvider.select((state) => state.userList));
            print(state.currentUser!.blocks.toString());

            for (final snapShot in list) {
              final messageModel = ChatMessageModel.fromSnapshot(snapShot);

              // グループユーザーから1件づつ取得
              for (final user in userList) {
                // グループ内のユーザーIDとチャット投稿者IDが一致していれば、types.Userに一致したユーザー名を渡す。
                // ※ユーザー名を変更時、変更したユーザー名を表示したい為、streamのsnapShotではなくuser情報からデータを取得
                if (user.uid == messageModel.userId) {
                  String profile = '';
                  String name = user.name;

                  if (user.profilePic == null || user.profilePic == '') {
                    profile = Constant.anonymousProfilePic;
                  } else {
                    profile = user.profilePic!;
                  }
                  if (state.currentUser!.blocks != null &&
                      state.currentUser!.blocks!.contains(user.uid)) {
                    profile = Constant.anonymousProfilePic;
                    name = Constant.blockedUserName;
                  }

                  typeUser = types.User(
                    id: user.uid,
                    firstName: name,
                    imageUrl: profile,
                  );

                  // flutter_chat_uiで使用するtypes.TextMessageにデーター代入
                  if (messageModel.messageText != null) {
                    final message = types.TextMessage(
                      id: messageModel.id!,
                      author: typeUser,
                      text: !(state.currentUser!.blocks != null &&
                              state.currentUser!.blocks!
                                  .contains(messageModel.userId))
                          ? messageModel.messageText!
                          : '.....',
                      createdAt: messageModel.createdAt!.millisecondsSinceEpoch,
                    );
                    // messageをtypes.Message型の配列に代入
                    messages.add(message);
                  }

                  // flutter_chat_uiで使用するtypes.ImageMessageにデーター代入
                  // if (messageModel.storageImagePath != null) {
                  //   final messageImage = types.ImageMessage(
                  //     id: messageModel.id!,
                  //     author: typeUser,
                  //     uri: messageModel.storageImagePath!,
                  //     name: messageModel.messageImageName!,
                  //     size: messageModel.messageImageSize!,
                  //     createdAt: messageModel.createdAt!.millisecondsSinceEpoch,
                  //   );
                  //   // messageImageFileをtypes.Message型の配列に代入
                  //   messages.add(messageImage);
                  // }
                }
              }
            }
            return Scaffold(
              backgroundColor: Colors.white,
              body: Column(
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
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Text(
                          DateFormat.ms().format(loungeState.time),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
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
                      onMessageLongPress: (context, message) {},
                      // 削除処理ぽいのほしい
                      showUserAvatars: true,
                      showUserNames: true,
                      onAvatarTap: (avatar) {
                        _showBlockAndReportDialog(
                          context: context,
                          user: avatar,
                          ref: ref,
                        );
                      },
                    ),
                  ),
                ],
              ),
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

  void _showBlockAndReportDialog(
      {required BuildContext context,
      required User user,
      required WidgetRef ref}) {
    final notifier = ref.watch(chatStateProvider.notifier);
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('このユーザについて'),
            children: <Widget>[
              SimpleDialogOption(
                child: const Text('報告'),
                onPressed: () {
                  Navigator.of(context).pop();
                  popupReportAndBlock(
                    context: context,
                    uid: user.id,
                    kind: '報告',
                  );
                },
              ),
              SimpleDialogOption(
                child: const Text('ブロック'),
                onPressed: () {
                  Navigator.of(context).pop();
                  popupReportAndBlock(
                      context: context,
                      uid: user.id,
                      kind: 'ブロック',
                      onBlockTap: () async {
                        await notifier.fetchCurrentUserInfo();
                        print('hello, i am here');
                      });
                },
              ),
            ],
          );
        });
  }
}
