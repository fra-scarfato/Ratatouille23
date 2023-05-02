import 'package:ratatouille23/models/Utente.dart';


import '../services/Utente_service.dart';


class Utente_controller{

  final Utente_service _utente_service = Utente_service();

  //TODO: Come recupero id ristorante?
  Future<List<Utente>?> getAllUtenti(int idRistorante) async {
    try{
      List<Utente> listaUtenti = await _utente_service.getUtenti(idRistorante);
      return listaUtenti;
    } catch (error) {
      rethrow;
    }

  }

  Future<void> aggiungiUtente(String nome, String cognome, String email, String password, String ruolo, int id_ristorante) async {
    try{
      var utenteDaAggiungere = Utente.senzaId(nome, cognome, email, password, ruolo, id_ristorante);
      _utente_service.aggiungi(utenteDaAggiungere);
    } catch (error) {
      rethrow;
    }

  }
  Future<void> rimuoviUtente(int id, String nome, String cognome, String email, String password, String ruolo, int id_ristorante) async {
    try{
      var utenteDaEliminare = Utente(id, nome, cognome, email, password, ruolo, id_ristorante);
      _utente_service.rimuovi(utenteDaEliminare);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> aggiornaUtente(int id, String nome, String cognome, String email, String password, String ruolo, int id_ristorante) async {

    _utente_service.aggiorna(Utente(id, nome, cognome, email, password, ruolo, id_ristorante));
    try{
      var utenteDaAggiornare = Utente(id, nome, cognome, email, password, ruolo, id_ristorante);
      _utente_service.rimuovi(utenteDaAggiornare);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> resetPassword(/*Utente utente*/int id, String nome, String cognome, String email, String password, String ruolo, int id_ristorante, String newPassword) async {
    //_utente_service.resetPassword(/*utente*/Utente(id, nome, cognome, email, password, ruolo, id_ristorante), newPassword);
    try{
      var utenteDaAggiornare = Utente(id, nome, cognome, email, password, ruolo, id_ristorante);
      _utente_service.resetPassword(utenteDaAggiornare, newPassword);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getDati(int id, String nome, String cognome, String email, String password, String ruolo, int id_ristorante) async {
    try{
      id = await _utente_service.getId(email);
      nome = await _utente_service.getNome(email);
      cognome = await _utente_service.getCognome(email);
      // email = await _utente_service.getEmail(email);
      password = await _utente_service.getPassword(email);
      ruolo = await _utente_service.getRuolo(email);
      id_ristorante = await _utente_service.getId_ristorante(email);
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