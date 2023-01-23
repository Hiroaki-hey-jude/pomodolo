import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pomodolo/screen/widgets/widgets.dart';
import 'package:pomodolo/shared/status.dart';
import 'package:pomodolo/state/lounge_state/lounge_state.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

import '../shared/constant.dart';

class LoungeScreen extends ConsumerWidget {
  const LoungeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isOn = false;
    final state = ref.watch(loungeStateProvider);
    final notifier = ref.watch(loungeStateProvider.notifier);
    final TextEditingController numberOfPomoEditingController =
        TextEditingController();
    final TextEditingController goaltaskEditingController =
        TextEditingController();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Lounge'),
        backgroundColor: Colors.transparent,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.chat_bubble),
          ),
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
          SafeArea(
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
                      CupertinoSwitch(
                        value: state.isResting,
                        onChanged: (value) {
                          print(value);
                          notifier.workOrRest(value);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Text(
                    DateFormat.ms().format(state.time),
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3, //横幅
                        height: 50, //高さ
                        child: state.pomodoloModel.status == Status.started
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
                                      Status.initial) {
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
                                              "Let's pomodolo!",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 96, 96, 96)),
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
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                  controller:
                                                      numberOfPomoEditingController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  decoration:
                                                      textInputDecorationPopUp
                                                          .copyWith(
                                                    labelText: "Pomodolo",
                                                    labelStyle: const TextStyle(
                                                      color:
                                                          Constant.blackColor,
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
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                  controller:
                                                      goaltaskEditingController,
                                                  decoration:
                                                      textInputDecorationPopUp
                                                          .copyWith(
                                                    labelText: "Goal",
                                                    labelStyle: const TextStyle(
                                                      color:
                                                          Constant.blackColor,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 10,
                                                      horizontal: 60),
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: 45,
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        side: const BorderSide(
                                                          color: Colors.white,
                                                        ),
                                                        backgroundColor:
                                                            Colors.black,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                        ),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: const [
                                                          Icon(
                                                              Icons.play_arrow),
                                                          SizedBox(width: 3),
                                                          Text('start'),
                                                        ],
                                                      ),
                                                      onPressed: () {},
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        });
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
                              ),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
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
                            print(notifier.getUserInLounge());
                            print('koko');
                            if (state.pomodoloModel.status == Status.stopped) {
                              print('koko2');
                              notifier.resetTimer();
                            }
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
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 40,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Constant.whiteColor,
                        ),
                        color: Constant.whiteColor.withOpacity(0.3),
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
                          Text(
                            'Lounge',
                            style: TextStyle(
                              fontSize: 20,
                              color: Constant.blackColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .where('isOnline', isEqualTo: true)
                                .snapshots(),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return SingleChildScrollView(
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: ((context, index) {
                                    // return Container(
                                    //   width: 200,
                                    //   height: 100,
                                    //   child: ListTile(
                                    //     leading: Text(snapshot.data!.docs[index]['name']),
                                    //   ),
                                    // );
                                    return userTile(
                                      snapshot.data!.docs[index]['name'],
                                      snapshot.data!.docs[index]['profilePic'],
                                      snapshot.data!.docs[index]['goalPomo'],
                                      snapshot.data!.docs[index]['objective'],
                                      snapshot.data!.docs[index]['uid'],
                                      snapshot.data!.docs[index]['currentNumOfPomo'],
                                    );
                                  }),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  initialDialog(BuildContext context) {}

  Widget userTile(
      String userName, String profilePic, int goalPomo, String objective, String uid, int currentNumOfPomo) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
          tileColor: Colors.yellow[100],
          textColor: Colors.black54,
          leading: profilePicturesWidget(uid),
          title: Text(userName,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(objective),
          trailing: goalPomoWidget(uid),
        ),
      ),
    );
  }
}
