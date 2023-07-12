import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ratatouille23/constants.dart';

import '../models/Utente.dart';

class Utente_service{
  APIConstants apiConstants = APIConstants();

  Future<void> aggiungi(Utente utente) async {
    final uri = Uri.http(apiConstants.baseURL, '/user/add');
    var response = await http.post(
      uri,
      headers: apiConstants.header,
      body: jsonEncode(utente.toJsonSenzaId()),
    );
    if (response.statusCode != 200) {
      throw(response.statusCode);
    }
  }

  Future<void> rimuovi(Utente utente) async {
    final uri = Uri.http(apiConstants.baseURL, '/user/delete');
    var response = await http.delete(
      uri,
      headers: apiConstants.header,
      body: jsonEncode(utente.toJson()),
    );
    if (response.statusCode != 200) {
      throw(response.statusCode);
    }

  }
  Future<void> aggiorna(Utente utente) async{
    final uri = Uri.http(apiConstants.baseURL, '/user/update');
    var response = await http.put(
      uri,
      headers: apiConstants.header,
      body: jsonEncode(utente.toJson()),
    );
    if (response.statusCode != 200) {
      throw(response.statusCode);
    }
  }

  Future<List<Utente>> getUtenti(int idRistorante) async {
    final queryParameter = {
      'idr': idRistorante.toString()
    };
    final uri = Uri.http(apiConstants.baseURL, '/user/get', queryParameter);
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
    final uri = Uri.http(apiConstants.baseURL, '/user/get-user', queryParameter);
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