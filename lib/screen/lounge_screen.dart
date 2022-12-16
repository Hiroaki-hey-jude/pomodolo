import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodolo/state/lounge_state/lounge_state.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:intl/intl.dart';

class LoungeScreen extends ConsumerWidget {
  const LoungeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                Align(
                  alignment: Alignment.center,
                  child: ToggleSwitch(
                    minWidth: 90.0,
                    minHeight: 45.0,
                    initialLabelIndex: 0,
                    totalSwitches: 2,
                    labels: const ['作業時間', '休憩時間'],
                    onToggle: (index) {
                      print('switched to: $index');
                    },
                  ),
                ),
                // Text(
                //   state.time == null
                //       ? '00:00:00'
                //       : DateFormat.Hms().format(state.time!),
                //   style: Theme.of(context).textTheme.headline2,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     FloatingActionButton(
                //       onPressed: () {
                //         if (state.timer != null && state.timer!.isActive)
                //           state.timer!.cancel();
                //       },
                //       child: Text("Stop"),
                //     ),
                //     FloatingActionButton(
                //       onPressed: () {
                //         notifier.startTimer();
                //       },
                //       child: Text("Start"),
                //     ),
                //   ],
                // )
              ],
            ),
          ),
        ],
      ),
    );
    ;
  }
}
