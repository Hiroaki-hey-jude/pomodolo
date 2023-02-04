import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodolo/data/firebase/auth.dart';
import 'package:pomodolo/data/firebase/firestore.dart';
import 'package:pomodolo/screen/auth/login_screen.dart';
import 'package:pomodolo/shared/constant.dart';
import 'package:pomodolo/state/lounge_state/lounge_state.dart';

void nextScreen(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenReplacement(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

const textInputDecoration = InputDecoration(
  labelStyle:
      TextStyle(color: Constant.whiteColor, fontWeight: FontWeight.w300),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Constant.whiteColor, width: 2),
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Constant.whiteColor, width: 2),
  ),
  errorBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Constant.whiteColor, width: 2),
  ),
);

const textInputDecorationPopUp = InputDecoration(
  labelStyle:
      TextStyle(color: Constant.whiteColor, fontWeight: FontWeight.w300),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Constant.blackColor, width: 2),
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Constant.blackColor, width: 2),
  ),
  errorBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Constant.blackColor, width: 2),
  ),
);

Widget profilePicturesWidget(String id) {
  return SizedBox(
    height: 50,
    width: 50,
    child: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('users').doc(id).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          String originalImgURL =
              snapshot.data!.get('profilePic') as String != ''
                  ? snapshot.data!.get('profilePic') as String
                  : Constant.anonymousProfilePic;
          return CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(originalImgURL),
          );
        }),
  );
}

Widget goalPomoWidget(String id) {
  return Container(
    width: 70,
    child: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('users').doc(id).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return Text(
            '${snapshot.data!.get('currentNumOfPomo')}/${snapshot.data!.get('goalPomo')}ポモ',
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white60),
          );
        }),
  );
}

showDialogForStart(BuildContext context) {}

popupForLogout(context) {
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.white,
              width: 3,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          backgroundColor: Colors.black.withOpacity(0.5),
          title: const Text(
            'ログアウトする',
            textAlign: TextAlign.left,
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await Auth().signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const LogInScreen()),
                    (route) => false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 79, 121, 193),
              ),
              child: const Text('ログアウト'),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: ElevatedButton(
                onPressed: () {
                  print('hihi');
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 79, 121, 193),
                ),
                child: const Text('キャンセル'),
              ),
            ),
          ],
        );
      });
    },
  );
}

popupForDelteAccount(context) {
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.white,
              width: 3,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          backgroundColor: Colors.black.withOpacity(0.5),
          title: const Text(
            '退会するとデータがこれまでのデータが失われてしまいます',
            textAlign: TextAlign.left,
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await Auth().deleteUser();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const LogInScreen()),
                    (route) => false);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor),
              child: const Text('退会する'),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: ElevatedButton(
                onPressed: () {
                  print('hihi');
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor),
                child: const Text('キャンセル'),
              ),
            ),
          ],
        );
      });
    },
  );
}

popupReportAndBlock({
  context,
  required String uid,
  required String kind,
  required String name,
  void Function()? onBlockTap,
}) {
  print(kind);
  if (kind == '報告') {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.white,
                width: 3,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            backgroundColor: Colors.black.withOpacity(0.5),
            title: const Text(
              'ユーザーのコンテンツに何か不適切な内容がありましたか？\n報告されたユーザーには２４時間以内に対策が講じられます',
              textAlign: TextAlign.left,
            ),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  FireStore().report(uid);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('ご報告ありがとうございました')));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor),
                child: const Text('報告する'),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: ElevatedButton(
                  onPressed: () {
                    print('hihi');
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor),
                  child: const Text('キャンセル'),
                ),
              ),
            ],
          );
        });
      },
    );
  } else {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.white,
                width: 3,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            backgroundColor: Colors.black.withOpacity(0.5),
            title: const Text(
              'このユーザーをブロックしますか？',
              textAlign: TextAlign.left,
            ),
            actions: [
              Consumer(builder: (context, ref, child) {
                final notifier = ref.watch(loungeStateProvider.notifier);
                return ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    FireStore().block(uid);
                    notifier.getUserData();
                    if (onBlockTap != null) {
                      onBlockTap();
                      print('できてる？');
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('このユーザーをブロックしました')));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  child: const Text('ブロック'),
                );
              }),
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: ElevatedButton(
                  onPressed: () {
                    print('hihi');
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor),
                  child: const Text('キャンセル'),
                ),
              ),
            ],
          );
        });
  }
  // showDialog(
  //   barrierDismissible: true,
  //   context: context,
  //   builder: (context) {
  //     return StatefulBuilder(builder: (context, setState) {
  //       return AlertDialog(
  //         shape: const RoundedRectangleBorder(
  //           side: BorderSide(
  //             color: Colors.white,
  //             width: 3,
  //           ),
  //           borderRadius: BorderRadius.all(
  //             Radius.circular(10),
  //           ),
  //         ),
  //         backgroundColor: Colors.black.withOpacity(0.5),
  //         title: const Text(
  //           '退会するとデータがこれまでのデータが失われてしまいます',
  //           textAlign: TextAlign.left,
  //         ),
  //         actions: [
  //           ElevatedButton(
  //             onPressed: () async {
  //               await Auth().deleteUser();
  //               Navigator.of(context).pushAndRemoveUntil(
  //                   MaterialPageRoute(
  //                       builder: (context) => const LogInScreen()),
  //                   (route) => false);
  //             },
  //             style: ElevatedButton.styleFrom(
  //                 backgroundColor: Theme.of(context).primaryColor),
  //             child: const Text('退会する'),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.only(right: 5),
  //             child: ElevatedButton(
  //               onPressed: () {
  //                 print('hihi');
  //                 Navigator.of(context).pop();
  //               },
  //               style: ElevatedButton.styleFrom(
  //                   backgroundColor: Theme.of(context).primaryColor),
  //               child: const Text('キャンセル'),
  //             ),
  //           ),
  //         ],
  //       );
  //     });
  //   },
  // );
}
