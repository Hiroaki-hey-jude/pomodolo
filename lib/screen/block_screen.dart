import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodolo/screen/widgets/widgets.dart';
import 'package:pomodolo/state/block_state/block_state.dart';

class BlockScreen extends ConsumerStatefulWidget {
  const BlockScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BlockScreenState();
}

class _BlockScreenState extends ConsumerState<BlockScreen> {
  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String r) {
    return r.substring(r.indexOf('_') + 1);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(blockStateProvider);
    final notifier = ref.watch(blockStateProvider.notifier);
    print(state.blocks);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('ブロックした人'),
        backgroundColor: Colors.transparent,
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
              child: state.isLoading
                  ? Container()
                  : Container(
                      child: ListView.builder(
                        itemCount: state.blocks.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: profilePicturesWidget(
                              getId(state.blocks[index]),
                            ),
                            title: Text(
                              getName(state.blocks[index].toString()),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            trailing: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                side: const BorderSide(
                                  color: Colors.white30,
                                ),
                              ),
                              onPressed: () {
                                notifier.unBlockUser(
                                    getId(state.blocks[index]), getName(state.blocks[index].toString()));
                              },
                              child: const Text(
                                'ブロックを外す',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ))
        ],
      ),
    );
  }
}
