import 'dart:convert';

import 'package:ratatouille23/models/Elemento_ordinato.dart';
import 'package:ratatouille23/models/Ordinazione.dart';
import 'package:http/http.dart' as http;
import 'package:ratatouille23/models/menu/Elemento.dart';

import '../models/Utente.dart';

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
      List<Elemento_ordinato> elem=[Elemento_ordinato(5656, Elemento(47,'pera','frutto dolce',1.5,'',37), 1),Elemento_ordinato(5656, Elemento(42,'mela','frutto dolce',1.3,'',31), 3)];
      List<Ordinazione> ordinazioni=[Ordinazione(001, 3, 'boh', elem, Utente(01,'er','va','ap','so','amministratore',45)),Ordinazione(001, 3, 'boh', elem, Utente(01,'er','va','ap','so','amministratore',45)),
        Ordinazione(001, 3, 'boh', elem, Utente(01,'er','va','ap','so','amministratore',45)),Ordinazione(001, 3, 'boh', elem, Utente(01,'er','va','ap','so','amministratore',45))];
      //List ord= json.decode(response.body);
      //ord.map((o) => ordinazioni.add(Ordinazione.fromJson(o))).toList();
      return ordinazioni;
    }
    else{
      throw('error');
    }
  }


}