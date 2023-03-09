import 'dart:convert';

import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

void onCallback(StompFrame frame) {
  print("Tornato");
  print(frame.body);
  String ordine = frame.body.toString();
  var ordinazioneMap = jsonDecode(ordine);
  var ordinazione = Ordinazione.fromJson(ordinazioneMap);
  print("${ordinazione.stato}");
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
    //stompConnectHeaders: {'idization': 'Bearer yourToken'},
    //webSocketConnectHeaders: {'idization': 'Bearer yourToken'},
  ),
);

class Ordinazione {
  int? id;
  String? gestoreOrdinazione;
  int? numeroTavolo;
  String? note;
  String? stato;
  String? data;
  double? costoTotale;

  Ordinazione(
      {this.id,
      this.gestoreOrdinazione,
      this.numeroTavolo,
      this.note,
      this.stato,
      this.data,
      this.costoTotale});

  factory Ordinazione.fromJson(Map<String, dynamic> json) {
    return Ordinazione(
      id: json["id"],
      gestoreOrdinazione: json["gestoreOrdinazione"],
      numeroTavolo: json["numeroTavolo"],
      note: json["note"],
      stato: json["stato"],
      data: json["data"],
      costoTotale: json["costoTotale"],
    );
  }
}

void main(List<String> arguments) {
  stompClient.activate();
}
