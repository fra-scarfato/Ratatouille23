import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/Utente.dart';

class Utente_service{

  //List<Map<String, dynamic>> _utenti=[];

  Future<http.Response> inserisci(Utente utente) {
    return http.post(
      Uri.parse(''),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: utente.toJson(),
    );
  }

  Future<http.Response> rimuovi(Utente utente) async {
    return http.delete(Uri.parse(''),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: utente.toJson(),
    );

  }
  Future<http.Response> aggiorna(Utente utente) {
    return http.put(
      Uri.parse(''),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: utente.toJson(),
    );
  }

  Future<List<Utente>> elenco_utenti() async {
    var response= await http.get(Uri.parse(''));
    if(response.statusCode==200){
      List<Utente> utenti=[];
      List elementi = json.decode(response.body) ;
      elementi.map((e) => utenti.add(Utente.fromJson(e))).toList();
      return utenti;

    }
    else{
      throw('error');
    }

  }
  
}