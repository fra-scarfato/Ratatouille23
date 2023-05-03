import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/Utente.dart';

class Utente_service{

  final String authority = "localhost:8080";
  final header = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Access-Control-Allow-Origin': '*',
  };


  void aggiungi(Utente utente) async {
    final uri = Uri.http(authority, '/user/add');
    var response = await http.post(
      uri,
      headers: header,
      body: jsonEncode(utente.toJsonSenzaId()),
    );
    if (response.statusCode != 200) {
      throw(response.statusCode);
    }
  }

  Future<void> rimuovi(Utente utente) async {
    final uri = Uri.http(authority, '/user/delete');
    var response = await http.delete(
      uri,
      headers: header,
      body: jsonEncode(utente.toJson()),
    );
    if (response.statusCode != 200) {
      throw(response.statusCode);
    }

  }
  Future<void> aggiorna(Utente utente) async{
    final uri = Uri.http(authority, '/user/update');
    var response = await http.put(
      uri,
      headers: header,
      body: jsonEncode(utente.toJson()),
    );
    if (response.statusCode != 200) {
      throw(response.statusCode);
    }
  }

  Future<List<Utente>> getUtenti(int idRistorante) async {
    final queryParameter = {
      'idr': idRistorante
    };
    final uri = Uri.http(authority, '/user/get', queryParameter);
    var response = await http.get(uri);
    if(response.statusCode==200){
      List<Utente> lista_utenti = (jsonDecode(response.body) as List)
          .map((utente) => Utente.fromJson(utente))
          .toList();
      return lista_utenti;
    }
    else{
      throw(response.statusCode);
    }

  }

  Future<Utente> getUtenteWithEmail(String email) async {
    final queryParameter = {
      'email': email
    };
    final uri = Uri.http(authority, '/user/get-user', queryParameter);
    var response = await http.get(uri);
    if(response.statusCode==200){
      Utente utente = Utente.fromJson(jsonDecode(response.body));
      return utente;
    }
    else{
      throw(response.statusCode);
    }
  }
  
}