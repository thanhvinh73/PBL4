part of 'connect_to_server_screen_cubit.dart';

@freezed
class ConnectToServerScreenState with _$ConnectToServerScreenState {
  const factory ConnectToServerScreenState.initial(
      {String? baseUrl,
      String? errorMessage,
      User? user,
      @Default(false) bool isConfirmed}) = _Initial;
}
