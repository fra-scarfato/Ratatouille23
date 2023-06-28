// ignore: file_names
import 'package:ratatouille23/models/Ordinazione.dart';

import '../models/Elemento_ordinato.dart';
import '../models/Utente.dart';
import '../services/Ordinazione_service.dart';

class Ordinazione_controller{


  late final Ordinazione_service _ordinazione_service = Ordinazione_service();

  Future<List<Ordinazione>?> getAll_ordini(Utente utente) async {
    try{
      List<Ordinazione> listaOrdinazione = await _ordinazione_service.elenco_ordinazioni(utente);
      return listaOrdinazione;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> registra_nuova_ordinazione(int tavolo, String note, List<Elemento_ordinato> elementi, Utente gestore_ordinazione) async {
    try{
      _ordinazione_service.registra_nuova_ordinazione(Ordinazione.senzaId(tavolo, note, elementi, gestore_ordinazione));
    } catch (error) {
      rethrow;
    }
  }

  Future<void> elimina_ordinazione(Ordinazione ordinazione) async {
    try{
      _ordinazione_service.elimina_ordinazione(ordinazione);
    } catch (error) {
      rethrow;
    }
  }


  Future<void> modifica_ordinazione(int id, int tavolo, String note, String stato, List<Elemento_ordinato> elementi, Utente gestore_ordinazione)async {
    try{
      _ordinazione_service.modifica_ordinazione(Ordinazione.conStato(id, tavolo, note, stato, elementi, gestore_ordinazione));
    } catch (error) {
      rethrow;
    }
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