import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pomodolo/state/lounge_state/lounge_state.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

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
                Text(
                  DateFormat.ms().format(state.time),
                  style: Theme.of(context).textTheme.headline2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        if (state.timer != null && state.timer!.isActive) {
                          state.timer!.cancel();
                        }
                      },
                      child: const Text("Stop"),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        notifier.startTimer();
                      },
                      child: const Text("Start"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
    ;
  }
}
