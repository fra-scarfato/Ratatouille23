import 'package:ratatouille23/models/Utente.dart';

import 'Elemento.dart';

class Ordinazione{
  late int _id;
  late int _tavolo;
  late String _note;
  late String _stato;
  late DateTime _data;
  late List<Elemento> _elementi;
  late double _costo_totale;
  late Utente _gestore_ordinazione;


  double _calcola_totale(List<Elemento> elementi){
    double totale=0;
    for(int i=0;i<elementi.length;i++){
      totale=totale+elementi[i].get_costo();
    }
    return totale;
  }

    Ordinazione(int id, int tavolo, String note, List<Elemento> elementi, Utente gestore_ordinazione /*String stato, DateTime data, double costo_totale*/){
      _id=id;
      _tavolo=tavolo;
      _note=note;
      _stato='In attesa';
      _data= DateTime.now();
      _elementi=elementi;
      _costo_totale=_calcola_totale(elementi);
      _gestore_ordinazione=gestore_ordinazione;

    }

    Ordinazione.fromJson(Map<String, dynamic> json):
      _id=json['id'],
      _tavolo=json['tavolo'],
      _note=json['note'],
      _stato=json['stato'],
      _data=json['data'],
      _elementi=json['elementi'],
      _costo_totale=json['costo_totale'],
      _gestore_ordinazione=json['gestore_ordinazione'];

    Map<String, dynamic> toJson(){
      return{
        'id':_id,
        'tavolo':_tavolo,
        'note':_note,
        'stato':_stato,
        'data':_data,
        'elementi':_elementi,
        'costo_totale':_costo_totale,
        'gestore_ordinazione':_gestore_ordinazione
      };
    }

    void set_id(int id){_id=id;}
    void set_tavolo(int tavolo){_tavolo=tavolo;}
    void set_note(String note){_note=note;}
    void set_stato(String stato){_stato=stato;}
    void set_elementi(List<Elemento> elementi){_elementi=elementi;}
    void aggiungi_elemento(Elemento elemento){_elementi.add(elemento);}
    void rimuovi_elemento(Elemento elemento){_elementi.removeWhere((element) => element.get_id()==elemento.get_id());}
    void set_gestore_ordinazione(Utente gestore_ordinazione){_gestore_ordinazione=gestore_ordinazione;}

    int get_id(){return _id;}
    int get_tavolo(){return _tavolo;}
    String get_note(){return _note;}
    String get_stato(){return _stato;}
    DateTime get_data(){return _data;}
    List<Elemento> get_elementi(){return _elementi;}
    double get_costo_totale(){return _costo_totale;}
    Utente get_gestore_ordinazione(){return _gestore_ordinazione;}

}