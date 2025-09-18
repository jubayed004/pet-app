import 'package:flutter/material.dart';
import 'package:pet_app/core/dependency/get_it_injection.dart';
import 'package:pet_app/helper/local_db/local_db.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'api_url.dart';

class SocketApi {
  factory SocketApi() {
    return _socketApi;
  }

  SocketApi._internal();

  static io.Socket? _socket;
  static io.Socket? get socket => _socket;

  ///<------------------------- Socket Initialization with dynamic User ID ---------------->

  static Future<void> init() async {
    if (_socket != null && _socket!.connected) {
      debugPrint('Socket is already initialized and connected.');
      return;
    }

    final DBHelper dbHelper = serviceLocator<DBHelper>();
    String id = await dbHelper.getUserId();
    if (id.isEmpty || id == "null") {
      debugPrint('Socket Connected >>>>>>>>>>>> FALSE userId.isEmpty <<<<<<<<<<<<');
      return;
    }

    _socket = io.io(
      ApiUrl.socketUrl(id: id),
      io.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .setReconnectionDelay(2000)
          .setReconnectionAttempts(0)
          .setTimeout(5000)
          .build(),
    );

    debugPrint('$id=============> Socket initialization, connected: ${_socket?.connected}');

    // Listen for socket connection
    _socket?.onConnect((_) {
      _socket?.on('pong', (data) {
        debugPrint('Received pong from server');
      });
      debugPrint('==============>>>>>>> Socket Connected ${_socket?.connected} ===============<<<<<<<');
    });

    _socket?.on('unauthorized', (dynamic data) {
      debugPrint('Unauthorized');
    });

    // Listen for errors
    _socket?.onError((dynamic error) {
      debugPrint('Socket error: $error');
    });

    // Listen for disconnection
    _socket?.onDisconnect((dynamic data) {
      debugPrint('>>>>>>>>>> Socket instance disconnected <<<<<<<<<<<<$data');
      reconnect();
    });

    _socket?.on('pong', (data) {
      debugPrint('Received pong from server');
    });
  }

  static void reconnect() {
    if (_socket != null && !_socket!.connected) {
      debugPrint('Attempting to reconnect...');
      _socket?.connect();
    }
  }

  static final SocketApi _socketApi = SocketApi._internal();
}