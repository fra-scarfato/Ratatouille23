import 'dart:js_util';

import 'package:ratatouille23/models/Elemento_ordinato.dart';
import 'package:ratatouille23/models/Utente.dart';

import 'menu/Elemento.dart';

class Ordinazione{
  late int _id;
  late int _tavolo;
  late String _note;
  late String _stato;
  late String _data;
  late List<Elemento_ordinato> _elementi;
  late double _costo_totale;
  late Utente _gestore_ordinazione;
  Utente? _addetto_alla_sala;


  double _calcola_totale(List<Elemento_ordinato> elementi){
    double totale=0;
    for(int i=0;i<elementi.length;i++){
      totale=totale+elementi[i].get_elemento().costo;
    }
    return totale;
  }

    Ordinazione(int id, int tavolo, String note, List<Elemento_ordinato> elementi, Utente gestore_ordinazione, String stato, String data, double costo_totale, Utente addetto_alla_sala){
      _id=id;
      _tavolo=tavolo;
      _note=note;
      _stato=stato;
      _data= data;
      _elementi=elementi;
      _costo_totale=_calcola_totale(elementi);
      _gestore_ordinazione=gestore_ordinazione;
      _addetto_alla_sala=addetto_alla_sala;
    }

  Ordinazione.senzaId(int tavolo, String note, List<Elemento_ordinato> elementi, Utente addetto_alla_sala /*String stato, DateTime data, double costo_totale*/){
    _tavolo=tavolo;
    _note=note;
    _stato='In attesa';
    _data= _data;
    _elementi=elementi;
    _costo_totale=_calcola_totale(elementi);
    _addetto_alla_sala=addetto_alla_sala;
  }


  Ordinazione.senzaGestore(int id, int tavolo, String note, List<Elemento_ordinato> elementi, Utente addetto_alla_sala, String stato, String data, double costo_totale){
    _id=id;
    _tavolo=tavolo;
    _note=note;
    _stato=stato;
    _data= data;
    _elementi=elementi;
    _costo_totale=_calcola_totale(elementi);
    _addetto_alla_sala=addetto_alla_sala;
  }

    Ordinazione.fromJson(Map<String, dynamic> json){
      _id = json['id'];
      _tavolo=json['numeroTavolo'];
      _note=json['note'];
      _stato=json['stato'];
      _data=json['data'];
      _costo_totale=json['costoTotale'];
      _gestore_ordinazione=Utente.fromJson(json['gestoreOrdinazione']);
      _addetto_alla_sala=Utente.fromJson(json['addettoAllaSala']);
      _elementi = [];
      json['elementiOrdinati'].forEach((v) {
        _elementi.add(Elemento_ordinato.fromJson(v));
      });
  }

  Ordinazione.fromJsonSenzaGestore(Map<String, dynamic> json){
    _id = json['id'];
    _tavolo=json['numeroTavolo'];
    _note=json['note'];
    _stato=json['stato'];
    _data=json['data'];
    _costo_totale=json['costoTotale'];
    _addetto_alla_sala=Utente.fromJson(json['addettoAllaSala']);
    _elementi = [];
    json['elementiOrdinati'].forEach((v) {
      _elementi.add(Elemento_ordinato.fromJson(v));
    });
  }

  Ordinazione.fromJsonSenzaAddettoAllaSala(Map<String, dynamic> json){
    _id = json['id'];
    _tavolo=json['numeroTavolo'];
    _note=json['note'];
    _stato=json['stato'];
    _data=json['data'];
    _costo_totale=json['costoTotale'];
    _gestore_ordinazione=Utente.fromJson(json['gestoreOrdinazione']);
    _elementi = [];
    json['elementiOrdinati'].forEach((v) {
      _elementi.add(Elemento_ordinato.fromJson(v));
    });
  }

  Map<String, dynamic> toJson(){
      List<Map> jsonElem = _elementi.map((e) => e.toJson()).toList();
      return{
        'id':_id,
        'numeroTavolo':_tavolo,
        'note':_note,
        'stato':_stato,
        'data':_data,
        'elementiOrdinati':jsonElem,
        'costoTotale':_costo_totale,
        'gestoreOrdinazione':_gestore_ordinazione
      };
    }

  Map<String, dynamic> toJsonSenzaId(){
    return{
      'tavolo':_tavolo,
      'note':_note,
      'stato':_stato,
      'data':_data,
      'elementi':_elementi,
      'costo_totale':_costo_totale,
      'gestore_ordinazione':_gestore_ordinazione
    };
  }

  Map<String, dynamic> toJsonSenzaAddettoAllaSala(){
    List<Map> jsonElem = _elementi.map((e) => e.toJson()).toList();
    return{
      'id':_id,
      'numeroTavolo':_tavolo,
      'note':_note,
      'stato':_stato,
      'data':_data,
      'elementiOrdinati':jsonElem,
      'costoTotale':_costo_totale,
      'gestoreOrdinazione':_gestore_ordinazione
    };
  }

  Map<String, dynamic> toJsonSenzaGestore(){
    List<Map> jsonElem = _elementi.map((e) => e.toJson()).toList();
    return{
      'id':_id,
      'numeroTavolo':_tavolo,
      'note':_note,
      'stato':_stato,
      'data':_data,
      'elementiOrdinati':jsonElem,
      'costoTotale':_costo_totale,
      'addettoAllaSala':_addetto_alla_sala,
    };
  }

    void set_id(int id){_id=id;}
    void set_tavolo(int tavolo){_tavolo=tavolo;}
    void set_note(String note){_note=note;}
    void set_stato(String stato){_stato=stato;}
    void set_lista_elementi(List<Elemento_ordinato> elementi){_elementi=elementi;}
    void set_gestore_ordinazione(Utente gestore_ordinazione){_gestore_ordinazione=gestore_ordinazione;}

    int get_id(){return _id;}
    int get_tavolo(){return _tavolo;}
    String get_note(){return _note;}
    String get_stato(){return _stato;}
    String get_data(){return _data;}
    List<Elemento_ordinato> get_lista_elementi(){return _elementi;}
    double get_costo_totale(){return _costo_totale;}
    Utente get_gestore_ordinazione(){return _gestore_ordinazione;}
    Elemento get_elemento(int i){return _elementi[i].get_elemento();}
    int get_quantita_elemento(int i){return _elementi[i].get_quantita();}

}