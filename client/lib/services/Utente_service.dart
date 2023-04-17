import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/Utente.dart';

class Utente_service{

  String uri = "http://localhost:8080/user";

  void aggiungi(Utente utente) async {
    var response = http.post(
      Uri.parse("$uri/add"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(utente.toJsonWithoutId()),
    ) as http.Response;
    if (response.statusCode != 200) {
      throw(response.statusCode);
    }
  }

  Future<void> rimuovi(Utente utente) async {
    var response = await http.delete(Uri.parse('$uri/delete'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: utente.toJson(),
    );
    if (response.statusCode != 200) {
      throw(response.statusCode);
    }

  }
  Future<void> aggiorna(Utente utente) async{
    var response = await http.put(
      Uri.parse('$uri/update'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: utente.toJson(),
    );
    if (response.statusCode != 200) {
      throw(response.statusCode);
    }
  }

  Future<List<Utente>> getUtenti() async {
    var response= await http.get(Uri.parse('$uri/get'));
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
  
}