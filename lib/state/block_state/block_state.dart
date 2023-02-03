import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pomodolo/data/firebase/firestore.dart';

part 'block_state.freezed.dart';

final blockStateProvider =
    StateNotifierProvider.autoDispose<BlockStateNotifier, BlockState>(
  (ref) => BlockStateNotifier(),
);

@freezed
class BlockState with _$BlockState {
  const factory BlockState({
    @Default(false) bool isLoading,
    @Default(<String>[]) List<String> blocks,
  }) = _BlockState;
}

class BlockStateNotifier extends StateNotifier<BlockState> {
  BlockStateNotifier() : super(const BlockState()) {
    getUserBlock();
  }

  Future<void> getUserBlock() async {
    state = state.copyWith(isLoading: true);
    final userModel =
        await FireStore(uid: FirebaseAuth.instance.currentUser!.uid)
            .getCurrentUserModel();
    final blocks = userModel.blocks;
    print(blocks);
    print('kokokoko');
    state = state.copyWith(isLoading: false, blocks: blocks ?? []);
  }

  Future<void> unBlockUser(String uid, String name) async {
    state = state.copyWith(isLoading: true);
    await FireStore().unBlock(uid, name);
    final userModel =
        await FireStore(uid: FirebaseAuth.instance.currentUser!.uid)
            .getCurrentUserModel();
    final blocks = userModel.blocks;
    state = state.copyWith(isLoading: false, blocks: blocks ?? []);
  }
}
