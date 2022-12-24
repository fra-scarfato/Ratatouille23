import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

void onCallback(StompFrame frame) {
  print("Tornato");
  print(frame.body);
}

void onConnect(StompFrame frame) {
  print('Connected');
  stompClient.subscribe(destination: '/ws/order/1', callback: onCallback);
}

final stompClient = StompClient(
  config: StompConfig(
    url: 'ws://localhost:8080/ws',
    onConnect: onConnect,
    beforeConnect: () async {
      print('waiting to connect...');
      await Future.delayed(Duration(milliseconds: 200));
      print('connecting...');
    },
    onWebSocketError: (dynamic error) => print(error.toString()),
    //stompConnectHeaders: {'Authorization': 'Bearer yourToken'},
    //webSocketConnectHeaders: {'Authorization': 'Bearer yourToken'},
  ),
);

void main(List<String> arguments) {
  stompClient.activate();
}
