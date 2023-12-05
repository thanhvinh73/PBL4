import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

part 'web_socket_state.dart';
part 'web_socket_cubit.freezed.dart';

class WebSocketCubit extends Cubit<WebSocketState> {
  WebSocketCubit({required this.context})
      : super(const WebSocketState.initial());
  final BuildContext context;
  StreamSubscription? subscription;
  WebSocketChannel? webSocketChannel;

  initWebSocket({
    String wsUrl = "ws://192.168.39.158/ServoInput",
  }) async {
    try {
      webSocketChannel = WebSocketChannel.connect(Uri.parse(wsUrl));
      subscription = webSocketChannel!.stream.listen((message) {
        debugPrint("========> WEB SOCKET DATA: $message");
        webSocketChannel!.sink.add(message);
        webSocketChannel!.sink.close(status.goingAway);
      }, onError: (e) async {
        await Future.delayed(const Duration(seconds: 5));
        debugPrint("========> WEB SOCKET CONNECTION ERROR: $e");
        initWebSocket();
      }, onDone: () async {
        await Future.delayed(const Duration(seconds: 5));
        debugPrint("========> WEB SOCKET DISCONNECTION");
        initWebSocket();
      }, cancelOnError: true);

      debugPrint("========> WEB SOCKET CONNECTION SUCCESSFULLY");
    } catch (err) {
      debugPrint("========> WEB SOCKET CONNECTION FAILED");
      initWebSocket();
    }
  }

  void sendData(dynamic data) {
    if (webSocketChannel != null) {
      // debugPrint("========> WEB SOCKET DATA: $data");
      webSocketChannel!.sink.add(data);
      // webSocketChannel!.sink.close(status.goingAway);
    }
  }

  disconnect() {
    subscription?.cancel();
  }
}
