import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pomodolo/screen/chat_screen.dart';
import 'package:pomodolo/screen/profile_screen.dart';
import 'package:pomodolo/screen/widgets/widgets.dart';
import 'package:pomodolo/shared/interval_type_enum.dart';
import 'package:pomodolo/shared/status.dart';
import 'package:pomodolo/state/lounge_state/lounge_state.dart';
import 'package:url_launcher/url_launcher.dart';

import '../shared/constant.dart';

class LoungeScreen extends StatelessWidget {
  const LoungeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),
      appBar: AppBar(
        elevation: 0,
        title: const Text('Lounge'),
        backgroundColor: Colors.transparent,
        actions: [
          _buildChatIcon(context),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: AssetImage('assets/background.JPG'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          _buildBody(context),
        ],
      ),
    );
  }

  Consumer _buildChatIcon(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final screenHeight = mediaQueryData.size.height;
    final blockSizeVertical = screenHeight / 100;
    return Consumer(builder: (context, ref, child) {
      final state = ref.watch(loungeStateProvider);
      return state.intervalType == IntervalType.work
          ? Container()
          : Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: const Icon(Icons.chat_bubble),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    builder: (BuildContext context) {
                      return SizedBox(
                        // 90%の高さで表示させる
                        height: blockSizeVertical * 95,
                        child: const ChatScreen(),
                      );
                    },
                  );
                },
              ),
            );
    });
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: AssetImage('assets/sub.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
            child: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text(
                    'プロフィール',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    nextScreen(context, const ProfileScreen());
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.notes_sharp,
                  ),
                  title: const Text(
                    '利用規約',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () async {
                    Navigator.of(context).pop();
                    final url = Uri.parse(
                        'https://cut-primula-dac.notion.site/27bc1799880d49c7877e6f2f0e348296');
                    if (!await launchUrl(url)) {
                    } else {
                      throw 'このURLにはアクセスできません';
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.notes,
                    color: Colors.black,
                  ),
                  title: const Text(
                    'プライバシーポリシー',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () async {
                    Navigator.of(context).pop();
                    final url = Uri.parse(
                        'https://cut-primula-dac.notion.site/8d53f61435014ba689333c514befb566');
                    if (!await launchUrl(url)) {
                    } else {
                      throw 'このURLにはアクセスできません';
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.mail_outline,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'お問い合わせ',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () async {
                    Navigator.of(context).pop();
                    final url =
                        Uri.parse('https://forms.gle/LoXC5gQ6j1G2Bsii6');
                    if (!await launchUrl(url)) {
                    } else {
                      throw 'このURLにはアクセスできません';
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'ログアウト',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    popupForLogout(context);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.logout_sharp,
                    color: Colors.black,
                  ),
                  title: const Text(
                    '退会',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    popupForDelteAccount(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
  ) {
    final mediaQueryData = MediaQuery.of(context);
    final screenHeight = mediaQueryData.size.height;
    double onlineContainer = 0;
    if (screenHeight < 900) {
      onlineContainer = 320;
    } else {
      onlineContainer = 600;
    }
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '休憩モード',
                  style: TextStyle(fontSize: 17),
                ),
                const SizedBox(width: 5),
                Consumer(builder: (context, ref, child) {
                  final state = ref.watch(loungeStateProvider);
                  final notifier = ref.watch(loungeStateProvider.notifier);
                  return CupertinoSwitch(
                    value: state.isResting,
                    onChanged: (value) {
                      print(value);
                      notifier.workOrRest(value);
                    },
                  );
                }),
              ],
            ),
            const SizedBox(height: 50),
            Consumer(builder: (context, ref, child) {
              final state = ref.watch(loungeStateProvider);
              return Text(
                DateFormat.ms().format(state.time),
                style: Theme.of(context).textTheme.headline1,
              );
            }),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3, //横幅
                  height: 50, //高さ
                  child: Consumer(builder: (context, ref, child) {
                    final state = ref.watch(loungeStateProvider);
                    final notifier = ref.watch(loungeStateProvider.notifier);
                    return state.pomodoloModel.status == Status.started
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () {
                              notifier.stopTimer();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.play_arrow),
                                SizedBox(width: 8),
                                Text('一時停止'),
                              ],
                            ),
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () {
                              if (state.pomodoloModel.status ==
                                      Status.initial &&
                                  state.isResting == false) {
                                _showStartDialog(context, ref);
                              } else {
                                notifier.startTimer();
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.play_arrow),
                                SizedBox(width: 8),
                                Text('Start'),
                              ],
                            ),
                          );
                  }),
                ),
                const SizedBox(width: 10),
                Consumer(builder: (context, ref, child) {
                  final notifier = ref.watch(loungeStateProvider.notifier);
                  return SizedBox(
                    width: MediaQuery.of(context).size.width / 3, //横幅
                    height: 50, //高さ
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        notifier.stopTimer();
                        notifier.resetTimer();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.clear),
                          SizedBox(width: 8),
                          Text('Reset'),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 40,
              ),
              child: Container(
                width: double.infinity,
                height: onlineContainer,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Constant.whiteColor,
                  ),
                  color: Colors.grey.withOpacity(0.5),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10.0,
                        spreadRadius: 1.0,
                        offset: Offset(0, 10))
                  ],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    const Text(
                      'Online',
                      style: TextStyle(
                        fontSize: 20,
                        color: Constant.whiteColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      color: const Color.fromARGB(255, 159, 199, 232)
                          .withOpacity(0.4),
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .where('uid',
                                isEqualTo:
                                    FirebaseAuth.instance.currentUser!.uid)
                            .snapshots(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.data.docs[0]['isOnline'] != null) {
                            if (snapshot.data!.docs[0]['isOnline'] == true) {
                              return myselfTile(
                                snapshot.data!.docs[0]['name'],
                                snapshot.data!.docs[0]['profilePic'],
                                snapshot.data!.docs[0]['goalPomo'],
                                snapshot.data!.docs[0]['objective'],
                                snapshot.data!.docs[0]['uid'],
                                snapshot.data!.docs[0]['currentNumOfPomo'],
                              );
                            }
                          }
                          return Container();
                        },
                      ),
                    ),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .where('isOnline', isEqualTo: true)
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Consumer(builder: (context, ref, child) {
                          final state = ref.read(loungeStateProvider);
                          return Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: ((context, index) {
                                final uid = snapshot.data!.docs[index]['uid'];
                                if (state.currentUser != null) {
                                  if (state.currentUser!.blocks != null &&
                                      state.currentUser!.blocks!
                                          .contains(uid)) {
                                    return Container();
                                  }
                                }
                                return userTile(
                                    snapshot.data!.docs[index]['name'],
                                    snapshot.data!.docs[index]['profilePic'],
                                    snapshot.data!.docs[index]['goalPomo'],
                                    snapshot.data!.docs[index]['objective'],
                                    snapshot.data!.docs[index]['uid'],
                                    snapshot.data!.docs[index]
                                        ['currentNumOfPomo'],
                                    context);
                              }),
                            ),
                          );
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showStartDialog(BuildContext context, WidgetRef ref) {
    final TextEditingController numberOfPomoEditingController =
        TextEditingController();
    final TextEditingController goaltaskEditingController =
        TextEditingController();
    final notifier = ref.watch(loungeStateProvider.notifier);

    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(13.0),
              ),
            ),
            backgroundColor: Colors.white,
            title: const Text(
              "Let's pomodoro!",
              style: TextStyle(color: Color.fromARGB(255, 96, 96, 96)),
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '何ポモドーロしますか？',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  style: const TextStyle(color: Colors.black),
                  controller: numberOfPomoEditingController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: textInputDecorationPopUp.copyWith(
                    labelText: "Pomodolo",
                    labelStyle: const TextStyle(
                      color: Constant.blackColor,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  '終わらせるタスクは?',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  style: const TextStyle(color: Colors.black),
                  controller: goaltaskEditingController,
                  decoration: textInputDecorationPopUp.copyWith(
                    labelText: "Goal",
                    labelStyle: const TextStyle(
                      color: Constant.blackColor,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                  child: SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.play_arrow),
                          SizedBox(width: 3),
                          Text('start'),
                        ],
                      ),
                      onPressed: () {
                        notifier.initialStart(
                            goaltaskEditingController.text,
                            int.parse(numberOfPomoEditingController.text),
                            FirebaseAuth.instance.currentUser!.uid);
                        notifier.startTimer();
                        goaltaskEditingController.clear();
                        numberOfPomoEditingController.clear();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  Widget myselfTile(String userName, String profilePic, int goalPomo,
      String objective, String uid, int currentNumOfPomo) {
    if (currentNumOfPomo == goalPomo && goalPomo != 0) {
      return Consumer(builder: (context, ref, child) {
        final notifier = ref.watch(loungeStateProvider.notifier);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          notifier.changeState();
        });
        return Column(
          children: const [
            SizedBox(height: 10),
            Text('お疲れ様でした！\nポモゴールを達成しました！',
                style: TextStyle(fontWeight: FontWeight.w700),
                textAlign: TextAlign.center),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Startボタンを押してポモろう！',
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),
          ],
        );
      });
    }
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
          tileColor: Colors.yellow[100],
          textColor: Colors.black54,
          leading: profilePicturesWidget(uid),
          title: Text(userName,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white)),
          subtitle: Text(
            objective,
            style: const TextStyle(color: Colors.white),
          ),
          trailing: goalPomoWidget(uid),
        ),
      ),
    );
  }

  Widget userTile(
    String userName,
    String profilePic,
    int goalPomo,
    String objective,
    String uid,
    int currentNumOfPomo,
    BuildContext context,
  ) {
    return uid != FirebaseAuth.instance.currentUser!.uid
        ? Consumer(builder: (context, ref, child) {
            final notifier = ref.watch(loungeStateProvider.notifier);
            return SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ListTile(
                  tileColor: Colors.yellow[100],
                  textColor: Colors.black54,
                  leading: profilePicturesWidget(uid),
                  title: Text(userName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white60,
                      )),
                  subtitle: Text(
                    objective,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      goalPomoWidget(uid),
                      PopupMenuButton(
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                        itemBuilder: ((context) => [
                              const PopupMenuItem(
                                value: '報告',
                                child: Text('報告'),
                              ),
                              const PopupMenuItem(
                                value: 'ブロック',
                                child: Text('ブロック'),
                              )
                            ]),
                        onSelected: (newValue) {
                          popupReportAndBlock(
                              context: context,
                              uid: uid,
                              kind: newValue,
                              name: userName,
                              onBlockTap: () {
                                notifier.getUserData();
                              });
                        },
                        child: const Icon(Icons.more_vert),
                      ),
                    ],
                  ),
                ),
              ),
            );
          })
        : Container();
  }
}
