import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'lounge_state.freezed.dart';

final loungeStateProvider =
    StateNotifierProvider<LoungeStateNotifier, LoungeState>(
  (ref) => LoungeStateNotifier(),
);

@freezed
class LoungeState with _$LoungeState {
  const factory LoungeState({
    @Default(false) bool isLoading,
  }) = _LoungeState;
}

class LoungeStateNotifier extends StateNotifier<LoungeState> {
  LoungeStateNotifier() : super(const LoungeState());

  Future<void> example() async {
    state = state.copyWith(isLoading: true);
    // なんかの処理する
    state = state.copyWith(isLoading: false);
  }
}
