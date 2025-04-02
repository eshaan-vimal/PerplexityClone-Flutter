import 'dart:async';
import 'dart:convert';

import 'package:web_socket_client/web_socket_client.dart';
import 'package:frontend/core/constants/constants.dart';


class ChatService 
{
  WebSocket? _socket;
  final _sourcesController = StreamController<Map<String,dynamic>>.broadcast();
  final _responseController = StreamController<Map<String,dynamic>>.broadcast();

  bool isReady = false;

  static final _instance = ChatService._internal();

  ChatService._internal();

  factory ChatService() => _instance;


  Stream<Map<String,dynamic>> get sourcesStream => _sourcesController.stream;

  Stream<Map<String,dynamic>> get responseStream => _responseController.stream;


  void connect ()
  {
    _socket = WebSocket(Uri.parse('ws://${Constants.backendUri}/ws/chat'));

    _socket!.messages.listen((message) {

      final data = jsonDecode(message);
      
      if (data['type'] == 'sources' && isReady)
      {
        _sourcesController.add(data);
      }
      else if (data['type'] == 'response' && isReady)
      {
        _responseController.add(data);
      }
    });
  }

  void prepare ()
  {
    isReady = true;
  }

  void dispose () async
  {
    // _socket?.close();

    // await _sourcesController.close();
    // await _responseController.close();

    isReady = false;
  }


  void chat (String query)
  {
    _socket!.send(jsonEncode({
      'query': query,
    }));
  }
}