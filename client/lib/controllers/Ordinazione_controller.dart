import 'package:flutter/cupertino.dart';
import 'package:ratatouille23/models/Ordinazione.dart';
import 'package:ratatouille23/repositories/Ordinazione_repository.dart';

import '../models/menu/Elemento.dart';
import '../services/Ordinazione_service.dart';

class Ordinazione_controller{

  //late Ordinazione_repository _ordinazione_repository=Ordinazione_repository(Ordinazione_service());
  late Ordinazione_service _ordinazione_service = Ordinazione_service();

  Future<List<Ordinazione>> getAll_ordini() {
    //return _ordinazione_repository.getAll();
    return _ordinazione_service.elenco_ordinazioni();
  }

  Future<void> registra_nuova_ordinazione(Ordinazione ordinazione) async {
    //_ordinazione_repository.registra_nuova_ordinazione(ordinazione);
    _ordinazione_service.registra_nuova_ordinazione(ordinazione);
  }

  Future<void> elimina_ordinazione(Ordinazione ordinazione) async {
     //_ordinazione_repository.elimina_ordinazione(ordinazione);
    _ordinazione_service.elimina_ordinazione(ordinazione);
  }


  Future<void> modifica_ordinazione(Ordinazione ordinazione)async {
    //_ordinazione_repository.modifica_ordinazione(ordinazione);
    _ordinazione_service.modifica_ordinazione(ordinazione);
  }


  /*
  late Ordinazione _ordinazione;

  Ordinazione_controller(Ordinazione ordinazione){_ordinazione=ordinazione;}

  void set_id(int id){_ordinazione.set_id(id); notifyListeners();}
  void set_tavolo(int tavolo){_ordinazione.set_tavolo(tavolo); notifyListeners();}
  void set_note(String note){_ordinazione.set_note(note); notifyListeners();}
  void set_stato(String stato){_ordinazione.set_stato(stato); notifyListeners();}
  void set_elementi(List<Elemento> elementi){_ordinazione.set_elementi(elementi);}
  void aggiungi_elemento(Elemento elemento){_ordinazione.aggiungi_elemento(elemento); notifyListeners();}
  void rimuovi_elemento(Elemento elemento){_ordinazione.rimuovi_elemento(elemento); notifyListeners();}

  int get_id(){return _ordinazione.get_id();}
  int get_tavolo(){return _ordinazione.get_tavolo();}
  String get_note(){return _ordinazione.get_note();}
  String get_stato(){return _ordinazione.get_stato();}
  DateTime get_data(){return _ordinazione.get_data();}
  List<Elemento> get_elementi(){return _ordinazione.get_elementi();}
  double get_costo_totale(){return _ordinazione.get_costo_totale();}

  Ordinazione registra_nuova_ordinazione(int id, int tavolo, String note, List<Elemento> elementi){
    return Ordinazione(id, tavolo, note, elementi);
  }

   */

}