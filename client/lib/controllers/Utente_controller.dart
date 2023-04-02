import 'package:flutter/cupertino.dart';
import 'package:ratatouille23/models/Utente.dart';
import 'package:ratatouille23/repositories/Utente_repository.dart';

import '../services/Utente_service.dart';


class Utente_controller{

  //late Utente_repository _utente_repository=Utente_repository(Utente_service());
  late Utente_service _utente_service;

  Future<List<Utente>> getAll_utenti() {
    //return _utente_repository.getAll();
    return _utente_service.elenco_utenti();
  }

  Future<void> aggiungi_utente(Utente utente) async {
   //_utente_repository.inserisci(utente);
    _utente_service.inserisci(utente);
  }

  Future<void> rimuovi_utente(Utente utente) async {
    //_utente_repository.rimuovi(utente);
    _utente_service.rimuovi(utente);
  }

  Future<void> aggiorna_password(Utente utente) async {
    //_utente_repository.aggiorna(utente);
    _utente_service.aggiorna(utente);
  }



  /*
  late Utente _utente;

  Utente_controller(Utente utente){_utente=utente; notifyListeners();}

  void set_id(int id){_utente.set_id(id); notifyListeners();}
  void set_nome(String name){_utente.set_nome(name); notifyListeners();}
  void set_surname(String cognome){_utente.set_cognome(cognome); notifyListeners();}
  void set_email(String email){_utente.set_email(email); notifyListeners();}
  void set_password(String password){_utente.set_password(password); notifyListeners();}
  void set_ruolo(String ruolo){_utente.set_ruolo(ruolo); notifyListeners();}



  int get_id(){return _utente.get_id();}
  String get_name(){return _utente.get_name();}
  String get_cognome(){return _utente.get_cognome();}
  String get_email(){return _utente.get_email();}
  String get_password(){return _utente.get_password();}
  String get_ruolo(){return _utente.get_ruolo();}

  Utente crea_utente(int id, String name, String surname, String email, String password, String ruolo){
    return Utente(id, name, surname, email, password, ruolo);
    notifyListeners();
    */


    /*Utente? utente;
    utente?.set_id(id);
    utente?.set_nome(name);
    utente?.set_surname(surname);
    utente?.set_email(email);
    utente?.set_password(password);
    utente?.set_ruolo(ruolo);
    return utente;*/
  //}

  //void rimuovi_utente(int id){}
}