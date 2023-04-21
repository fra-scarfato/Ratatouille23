import 'package:ratatouille23/models/Utente.dart';
import 'package:amplify_flutter/amplify_flutter.dart';


import '../services/Utente_service.dart';


class Utente_controller{

  Utente_service _utente_service = new Utente_service();

  Future<SignInResult> signInUser(String email, String password) async {
    SignInResult result;
    try {
      result = await Amplify.Auth.signIn(
        username: email,
        password: password,
      );
    } on AuthException catch (e) {
      rethrow;
    }
    return result;
  }

  Future<void> resetPassword(String nuovaPassword) async {
    try {
      await Amplify.Auth.confirmSignIn(
        confirmationValue: nuovaPassword,
      );
    }catch (e) {
      rethrow;
    }
  }

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
}