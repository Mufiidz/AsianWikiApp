abstract class BaseState {
  final String message;
  final StatusState statusState;
  final StatusStateScreen statusStateScreen;

  const BaseState({
    this.message = '',
    this.statusState = StatusState.idle,
    this.statusStateScreen = StatusStateScreen.idle,
  });

  bool get isLoading => statusState == StatusState.loading;
  bool get isSuccess => statusState == StatusState.success;
  bool get isError => statusState == StatusState.failure;
  bool get isIdle => statusState == StatusState.idle;

  /// Status State for Screen
  bool get isLoadingScreen => statusStateScreen == StatusStateScreen.loading;
  bool get isSuccessScreen => statusStateScreen == StatusStateScreen.success;
  bool get isErrorScreen => statusStateScreen == StatusStateScreen.failure;
  bool get isIdleScreen => statusStateScreen == StatusStateScreen.idle;
}

enum StatusState { idle, loading, success, failure }

enum StatusStateScreen { idle, loading, success, failure }
