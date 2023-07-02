import 'dart:convert';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import 'package:ratatouille23/models/Ordinazione.dart';
import 'package:http/http.dart' as http;

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

  
  Future<void> registra_nuova_ordinazione(Ordinazione ordinazione) async {
    final uri = Uri.http(authority, '/order/add');
    print(jsonEncode(ordinazione.toJsonSenzaId()));
    var response = await http.post(
      uri,
      headers: header,
      body: jsonEncode(ordinazione.toJsonSenzaId()),
    );
    if (response.statusCode != 200) {
      throw (response.statusCode);
    }

  }

  Future<void> elimina_ordinazione(Ordinazione ordinazione) async {
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

  Future<void> modifica_ordinazione(Ordinazione ordinazione) async{
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

  Future<String> get_ordinazione_by_id(int idOrdinazione) async {
    Map<String, String> queryParameter;
    String endpoint;
    queryParameter = {'ido': idOrdinazione.toString()};
    endpoint = "/order/get/sala/single";

    final uri = Uri.http(authority, endpoint, queryParameter);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw (response.statusCode);
    }
  }

  Future<List<Ordinazione>> elenco_ordinazioni_cucina(Utente utente) async {
    Map<String, String> queryParameter;
    String endpoint;
    queryParameter = {'idr': utente.get_id_ristorante().toString()};
    endpoint = "/order/get/all";

    final uri = Uri.http(authority, endpoint, queryParameter);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      List<Ordinazione> listaOrdinazione = (jsonDecode(response.body) as List)
          .map((ordinazione) => Ordinazione.fromJson(ordinazione))
          .toList();
      return listaOrdinazione;
    } else {
      throw (response.statusCode);
    }
  }

  Future<List<Ordinazione>> elenco_ordinazioni_sala(Utente utente) async {
    Map<String, String> queryParameter;
    String endpoint;
    if(utente.get_ruolo() == "Addetto alla sala") {
      queryParameter = {'idu': utente.get_id().toString()};
      endpoint = "/order/get/sala/AS";
    } else {
      queryParameter = {'idr': utente.get_id_ristorante().toString()};
      endpoint = "/order/get/sala/all";
    }
    final uri = Uri.http(authority, endpoint, queryParameter);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      List<Ordinazione> listaOrdinazione = (jsonDecode(response.body) as List)
          .map((ordinazione) => Ordinazione.fromJsonSenzaGestore(ordinazione))
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