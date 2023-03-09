import 'package:ratatouille23/models/Utente.dart';
import 'package:ratatouille23/services/Utente_service.dart';

class Utente_repository{

  late Utente_service _utente_service;

  Utente_repository(Utente_service utente_service){
    _utente_service=utente_service;
  }

  Future<List<Utente>> getAll() async {

    return  _utente_service.elenco_utenti();
  }



  Future<void> inserisci(Utente utente) async {
    await _utente_service.inserisci(utente);
  }

  Future<void> aggiorna(Utente utente) async {
    await _utente_service.aggiorna(utente);
  }

  Future<void> rimuovi(Utente utente) async {
    await _utente_service.rimuovi(utente);
  }

}