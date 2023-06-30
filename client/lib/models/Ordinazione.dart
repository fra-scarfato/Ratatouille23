
import 'package:intl/intl.dart';
import 'package:ratatouille23/models/Elemento_ordinato.dart';
import 'package:ratatouille23/models/Utente.dart';

import 'menu/Elemento.dart';

class Ordinazione{
  late int _id;
  late int _tavolo;
  late String _note;
  late String _stato;
  late DateTime _data;
  late List<Elemento_ordinato> _elementi;
  late double _costo_totale;
  Utente? _gestore_ordinazione;
  Utente? _addetto_alla_sala;


  double _calcola_totale(List<Elemento_ordinato> elementi){
    double totale=0;
    for(int i=0;i<elementi.length;i++){
      totale=totale+elementi[i].get_elemento().costo;
    }
    return totale;
  }

  Ordinazione.senzaId(int tavolo, String note, List<Elemento_ordinato> elementi, Utente addetto_alla_sala){
    _tavolo=tavolo;
    _note=note;
    _stato='In attesa';
    _data= DateTime.now();
    _elementi=elementi;
    _costo_totale=_calcola_totale(elementi);
    _addetto_alla_sala=addetto_alla_sala;
  }

    Ordinazione.fromJson(Map<String, dynamic> json){
      _id = json['id'];
      _tavolo=json['numeroTavolo'];
      _note=json['note'];
      _stato=json['stato'];
      _data=DateTime.parse(json['data']);
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
    _data=DateTime.parse(json['data']);
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
    _data=DateTime.parse(json['data']);
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
        'idRistorante':_addetto_alla_sala?.get_id_ristorante(),
        'id':_id,
        'numeroTavolo':_tavolo,
        'note':_note,
        'stato':_stato,
        'data':fromDateToString(),
        'elementiOrdinati':jsonElem,
        'costoTotale':_costo_totale,
        'gestoreOrdinazione':_gestore_ordinazione,
        'addettoAllaSala':_addetto_alla_sala
      };
    }

  Map<String, dynamic> toJsonSenzaId(){
    return{
      'tavolo':_tavolo,
      'note':_note,
      'stato':_stato,
      'data':fromDateToString(),
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
      'data':fromDateToString(),
      'elementiOrdinati':jsonElem,
      'costoTotale':_costo_totale,
      'gestoreOrdinazione':_gestore_ordinazione
    };
  }

  Map<String, dynamic> toJsonSenzaGestore(){
    List<Map> jsonElem = _elementi.map((e) => e.toJson()).toList();
    return{
      'idRistorante':_addetto_alla_sala?.get_id_ristorante(),
      'numeroTavolo':_tavolo,
      'note':_note,
      'stato':_stato,
      'data':fromDateToString(),
      'elementiOrdinati':jsonElem,
      'costoTotale':_costo_totale,
      'addettoAllaSala':_addetto_alla_sala,
    };
  }

  String fromDateToString() {
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(_data);
    return formattedDate;
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
    DateTime get_data(){return _data;}
    List<Elemento_ordinato> get_lista_elementi(){return _elementi;}
    double get_costo_totale(){return _costo_totale;}
    Utente? get_gestore_ordinazione(){return _gestore_ordinazione;}
    Elemento get_elemento(int i){return _elementi[i].get_elemento();}
    int get_quantita_elemento(int i){return _elementi[i].get_quantita();}

}