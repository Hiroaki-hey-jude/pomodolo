import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pomodolo/data/firebase/firestore.dart';
import 'package:pomodolo/data/model/user_model.dart';

part 'block_state.freezed.dart';

final blockStateProvider =
    StateNotifierProvider.autoDispose<BlockStateNotifier, BlockState>(
  (ref) => BlockStateNotifier(),
);

@freezed
class BlockState with _$BlockState {
  const factory BlockState({
    @Default(false) bool isLoading,
    @Default(<UserModel>[]) List<UserModel> blocks,
  }) = _BlockState;
}

class BlockStateNotifier extends StateNotifier<BlockState> {
  BlockStateNotifier() : super(const BlockState()) {
    getUserBlock();
  }

  Future<void> getUserBlock() async {
    state = state.copyWith(isLoading: true);
    List<UserModel> list = [];
    final userModel =
        await FireStore(uid: FirebaseAuth.instance.currentUser!.uid)
            .getCurrentUserModel();
    final blocks = userModel.blocks;
    blocks?.forEach((uid) async {
      final userModel = await FireStore(uid: uid).getCurrentUserModel();
      list.add(userModel);
    });
    print(blocks);
    print('kokokoko');
    if (!mounted) {
      return;
    }
    state = state.copyWith(isLoading: false, blocks: list);
  }

  Future<void> unBlockUser(String uid) async {
    state = state.copyWith(isLoading: true);
    List<UserModel> list = [];
    await FireStore().unBlock(uid);
    final userModel =
        await FireStore(uid: FirebaseAuth.instance.currentUser!.uid)
            .getCurrentUserModel();
    final blocks = userModel.blocks;
    if (blocks != []) {
      for (var uid in blocks!) {
        final userModel = await FireStore(uid: uid).getCurrentUserModel();
        list.add(userModel);
      }
    }
    if (!mounted) {
      return;
    }
    state = state.copyWith(
      isLoading: false,
      blocks: list,
    );
  }
}
