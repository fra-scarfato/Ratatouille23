import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:ratatouille23/models/Utente.dart';

import '../services/Utente_service.dart';


class Utente_controller{

  Utente_service _utente_service = new Utente_service();

  Future<void> getAllUtenti() async {
    try{
      print(_utente_service.getUtenti());
    } catch (error) {
      //TODO: Something bad
      print("Errore:"+error.toString());
    }
  }

  Future<void> aggiungiUtente(String nome, String cognome, String email, String password, String ruolo, int id_ristorante) async {
    try{
      var utenteDaAggiungere = Utente.senzaId(nome, cognome, email, password, ruolo, id_ristorante);
      _utente_service.aggiungi(utenteDaAggiungere);
    } catch (error) {
      //TODO: Something bad
      print("Errore:"+error.toString());
    }

  }
  Future<void> rimuoviUtente(int id, String nome, String cognome, String email, String password, String ruolo, int id_ristorante) async {
    try{
      var utenteDaEliminare = Utente(id, nome, cognome, email, password, ruolo, id_ristorante);
      _utente_service.rimuovi(utenteDaEliminare);
    } catch (error) {
      //TODO: Something bad
    }
  }

  Future<void> aggiornaUtente(int id, String nome, String cognome, String email, String password, String ruolo, int id_ristorante) async {

    _utente_service.aggiorna(Utente(id, nome, cognome, email, password, ruolo, id_ristorante));
    try{
      var utenteDaAggiornare = Utente(id, nome, cognome, email, password, ruolo, id_ristorante);
      _utente_service.rimuovi(utenteDaAggiornare);
    } catch (error) {
      //TODO: Something bad
    }
  }
}