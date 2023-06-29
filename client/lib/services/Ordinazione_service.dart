import 'dart:convert';
import 'dart:html';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import 'package:ratatouille23/models/Elemento_ordinato.dart';
import 'package:ratatouille23/models/Ordinazione.dart';
import 'package:http/http.dart' as http;
import 'package:ratatouille23/models/menu/Elemento.dart';

import '../models/Ordinazione_DTO.dart';
import '../models/Utente.dart';

class Ordinazione_service{

  String authority = "localhost:8080";
  final header = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Access-Control-Allow-Origin': '*',
  };
  late StompClient stompClient;
  late int endpointStomp;
  late Function(StompFrame) onStompCallback;

  
  void registra_nuova_ordinazione(Ordinazione ordinazione) async {
    final uri = Uri.http(authority, '/order/add');
    var response = await http.post(
      uri,
      headers: header,
      body: jsonEncode(ordinazione.toJsonSenzaGestore()),
    );
    if (response.statusCode != 200) {
      throw (response.statusCode);
    }

  }

  void elimina_ordinazione(Ordinazione ordinazione) async {
    final uri = Uri.http(authority, '/order/delete');
    var response = await http.delete(
      uri,
      headers: header,
      body: (ordinazione.get_gestore_ordinazione() != null) ? jsonEncode(ordinazione.toJson()) : jsonEncode(ordinazione.toJsonSenzaGestore()),
    );
    if (response.statusCode != 200) {
      throw (response.statusCode);
    }
  }

  void modifica_ordinazione(Ordinazione ordinazione) async{
    final uri = Uri.http(authority, '/order/update');
    var response = await http.put(
      uri,
      headers: header,
      body: (ordinazione.get_gestore_ordinazione() != null) ? jsonEncode(ordinazione.toJson()) : jsonEncode(ordinazione.toJsonSenzaGestore()),
    );
    if (response.statusCode != 200) {
      throw (response.statusCode);
    }
  }

  Future<List<Ordinazione>> elenco_ordinazioni(Utente utente) async {
    var queryParameter;
    String endpoint;
    if(utente.get_ruolo() == "Addetto alla sala") {
      queryParameter = {'idu': utente.get_id().toString()};
      endpoint = "/order/get/sala";
    } else {
      queryParameter = {'idr': utente.get_id_ristorante().toString()};
      endpoint = "/order/get/all";
    }
    final uri = Uri.http(authority, endpoint, queryParameter);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      List<Ordinazione> listaOrdinazione = (jsonDecode(response.body) as List)
          .map((ordinazione) => (ordinazione.get_gestore_ordinazione() != null) ? Ordinazione.fromJson(ordinazione) : Ordinazione.fromJsonSenzaGestore(ordinazione))
          .toList();
      return listaOrdinazione;
    } else {
      throw (response.statusCode);
    }
  }
  
  void onStompConnect(StompFrame frame) {
    String destinationURL = "/ws/order/$endpointStomp";
    stompClient.subscribe(destination: destinationURL, callback: onStompCallback);
  }

  void configuraStompClient(int idRistorante) {
    endpointStomp = idRistorante;
    String stompURL = "ws://$authority/ws";
    stompClient = StompClient(config: StompConfig(
      url: stompURL,
      onConnect: onStompConnect,
      onWebSocketError: (dynamic error) => throw error
    ));
    stompClient.activate();
  }



}