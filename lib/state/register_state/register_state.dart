import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_state.freezed.dart';

final registerStateProvider =
    StateNotifierProvider<RegisterStateNotifier, RegisterState>(
  (ref) => RegisterStateNotifier(),
);

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState({
    @Default(false) bool isLoading,
  }) = _RegisterState;
}

class RegisterStateNotifier extends StateNotifier<RegisterState> {
  RegisterStateNotifier() : super(const RegisterState());

  Future<void> example() async {
    // state = state.copyWith(isLoading: true);
    // // なんかの処理する
    // state = state.copyWith(isLoading: false);
  }
}
