import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
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
                          notifier.startTimer();
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
                          if (state.timer != null && state.timer!.isActive) {
                            state.timer!.cancel();
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    ;
  }
}
