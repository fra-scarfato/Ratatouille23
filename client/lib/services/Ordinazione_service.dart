import 'dart:convert';

import 'package:ratatouille23/models/Elemento_ordinato.dart';
import 'package:ratatouille23/models/Ordinazione.dart';
import 'package:http/http.dart' as http;
import 'package:ratatouille23/models/menu/Elemento.dart';

import '../models/Utente.dart';

class Ordinazione_service{

  final String authority = "localhost:8080";
  final header = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Access-Control-Allow-Origin': '*',
  };

  void registra_nuova_ordinazione(Ordinazione ordinazione) async {
    final uri = Uri.http(authority, '');
    var response = await http.post(
      uri,
      headers: header,
      body: jsonEncode(ordinazione.toJson()),
    );
    if (response.statusCode != 200) {
      throw (response.statusCode);
    }

  }

  void elimina_ordinazione(Ordinazione ordinazione) async {
    final uri = Uri.http(authority, '');
    var response = await http.delete(
      uri,
      headers: header,
      body: jsonEncode(ordinazione.toJson()),
    );
    if (response.statusCode != 200) {
      throw (response.statusCode);
    }
  }

  void modifica_ordinazione(Ordinazione ordinazione) async{
    final uri = Uri.http(authority, '');
    var response = await http.put(
      uri,
      headers: header,
      body: jsonEncode(ordinazione.toJson()),
    );
    if (response.statusCode != 200) {
      throw (response.statusCode);
    }
  }

  Future<List<Ordinazione>> elenco_ordinazioni(Utente utente) async {
    final queryParameter = {};//TODO
    final uri = Uri.http(authority, '', /*queryParameter*/);
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


}