import 'dart:convert';

import 'package:ratatouille23/models/Ordinazione.dart';
import 'package:http/http.dart' as http;

class Ordinazione_service{



  Future<http.Response> registra_nuova_ordinazione(Ordinazione ordinazione) async {
    return http.post(
      Uri.parse(''),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: ordinazione.toJson()
    );
  }

  Future<http.Response> elimina_ordinazione(Ordinazione ordinazione) async {
    return http.delete(
        Uri.parse(''),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: ordinazione.toJson()
    );
  }

  Future<http.Response> modifica_ordinazione(Ordinazione ordinazione) async{
    return http.put(
        Uri.parse(''),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: ordinazione.toJson()
    );
  }

  Future<List<Ordinazione>> elenco_ordinazioni() async {
    var response= await http.get(Uri.parse(''));
    if(response.statusCode==200){
      List<Ordinazione> ordinazioni=[];
      List elementi= json.decode(response.body);
      elementi.map((e) => ordinazioni.add(Ordinazione.fromJson(e))).toList();
      return ordinazioni;
    }
    else{
      throw('error');
    }
  }


}