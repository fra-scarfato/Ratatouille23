import 'package:ratatouille23/models/Utente.dart';


import '../services/Utente_service.dart';


class Utente_controller{

  late Utente_service _utente_service;


  Utente_controller(this._utente_service);

  Future<List<Utente>?> getAllUtenti(int idRistorante) async {
    try{
      List<Utente> listaUtenti = await _utente_service.getUtenti(idRistorante);
      return listaUtenti;
    } catch (error) {
      rethrow;
    }

  }

  Future<Utente> getUtenteFromEmail(String email) async {
    try{
      Utente utente = await _utente_service.getUtenteWithEmail(email);
      return utente;
    } catch (error) {
      rethrow;
    }

  }

  Future<void> aggiungiUtente(String nome, String cognome, String email, String ruolo, int id_ristorante) async {
    try{
      var utenteDaAggiungere = Utente.senzaId(nome, cognome, email, ruolo, id_ristorante);
      await _utente_service.aggiungi(utenteDaAggiungere);
    } catch (error) {
      rethrow;
    }

  }
  Future<void> rimuoviUtente(int id, String nome, String cognome, String email, String ruolo, int id_ristorante) async {
    try{
      var utenteDaEliminare = Utente(id, nome, cognome, email, ruolo, id_ristorante);
      _utente_service.rimuovi(utenteDaEliminare);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> aggiornaUtente(int id, String nome, String cognome, String email, String ruolo, int id_ristorante) async {
    try{
      var utenteDaAggiornare = Utente(id, nome, cognome, email, ruolo, id_ristorante);
      _utente_service.aggiorna(utenteDaAggiornare);
    } catch (error) {
      rethrow;
    }
  }


  // Future<int?> get_idRistorante(int idRistorante) async {
  //   try{
  //
  //   } catch (error) {
  //     rethrow;
  //   }
  //
  // }
}