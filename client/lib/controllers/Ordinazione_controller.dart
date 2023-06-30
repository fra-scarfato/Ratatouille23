// ignore: file_names
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:ratatouille23/models/Ordinazione.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import '../models/Elemento_ordinato.dart';
import '../models/Ordinazione_DTO.dart';
import '../models/Utente.dart';
import '../services/Ordinazione_service.dart';

class Ordinazione_controller extends ChangeNotifier {
  final Ordinazione_service _ordinazione_service = Ordinazione_service();
  List<Ordinazione> _listaOrdinazioniSala = <Ordinazione>[];
  List<Ordinazione> _listaOrdinazioniCucina = <Ordinazione>[];
  List<Ordinazione> _listaOrdiniAttesa = <Ordinazione>[];
  List<Ordinazione> _listaOrdiniPresiInCarico = <Ordinazione>[];
  List<Ordinazione> _listaDaVisualizzare = <Ordinazione>[];
  final Utente utente;

  Ordinazione_controller({required this.utente});

  void onStompCallback(StompFrame frame) {
    Ordinazione_DTO ordinazione_dto = Ordinazione_DTO.fromJsonSTOMP(
        jsonDecode(frame.body.toString()));
    //Se l'elemento in coda è da qualche altro utente, allora aggiorno la schermata
    if (ordinazione_dto.ordinazione.get_gestore_ordinazione()!.get_id() !=
        utente.get_id()) {
      if (ordinazione_dto.operazione == "INSERT") {
        _listaOrdiniAttesa.add(ordinazione_dto.ordinazione);
      } else if (ordinazione_dto.operazione == "UPDATE") {
        if (ordinazione_dto.ordinazione.get_stato() == "Presa in carico") {
          _listaOrdiniAttesa.removeWhere((element) =>
          element.get_id() == ordinazione_dto.ordinazione.get_id());
          _listaOrdiniPresiInCarico.add(ordinazione_dto.ordinazione);
        } else if (ordinazione_dto.ordinazione.get_stato() == "Evasa") {
          _listaOrdiniPresiInCarico.removeWhere((element) =>
          element.get_id() == ordinazione_dto.ordinazione.get_id());
        }
      } else {
        if (ordinazione_dto.ordinazione.get_stato() == "In attesa") {
          _listaOrdiniAttesa.remove(ordinazione_dto.ordinazione);
        } else {
          _listaOrdiniPresiInCarico.remove(ordinazione_dto.ordinazione);
        }
      }
      notifyListeners();
    }
  }

  Future<List<Ordinazione>?> get_ordini_cucina() async {
    try {
      _listaOrdinazioniCucina =
      await _ordinazione_service.elenco_ordinazioni_cucina(utente);
      if (_listaOrdinazioniCucina.isNotEmpty) {
        for (int i = 0; i < _listaOrdinazioniCucina.length; i++) {
          if (_listaOrdinazioniCucina[i].get_stato() == "In attesa") {
            _listaOrdiniAttesa.add(_listaOrdinazioniCucina[i]);
          } else if (_listaOrdinazioniCucina[i].get_stato() == "Presa in carico") {
            _listaOrdiniPresiInCarico.add(_listaOrdinazioniCucina[i]);
          }
        }
      }
      _listaDaVisualizzare = _listaOrdiniAttesa;
      return _listaOrdinazioniCucina;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<Ordinazione>?> get_ordini_sala() async {
    try {
      _listaOrdinazioniCucina = await _ordinazione_service.elenco_ordinazioni_sala(utente);
      return _listaOrdinazioniCucina;
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }

  void showOrdinazioniInAttesa() {
    _listaDaVisualizzare = _listaOrdiniAttesa;
    notifyListeners();
  }

  void showOrdinazioniPreseInCarico() {
    _listaDaVisualizzare = _listaOrdiniPresiInCarico;
    notifyListeners();
  }

  List<Ordinazione> getListaOrdinazioniDaVisualizzare() {
    return _listaDaVisualizzare;
  }

  List<Ordinazione> getListaOrdinazioniSala() {
    return _listaOrdinazioniSala;
  }

  void prendiInCaricoOrdinazione(Ordinazione ordinazioneDaPrendereInCarico) {
    ordinazioneDaPrendereInCarico.set_gestore_ordinazione(utente);
    ordinazioneDaPrendereInCarico.set_stato("Presa in carico");
    _listaDaVisualizzare.remove(ordinazioneDaPrendereInCarico);
    _listaOrdiniAttesa.remove(ordinazioneDaPrendereInCarico);
    _listaOrdiniPresiInCarico.add(ordinazioneDaPrendereInCarico);
    notifyListeners();
  }

  void evadiOrdinazione(Ordinazione ordinazioneDaEvadere) {
    ordinazioneDaEvadere.set_stato("Evasa");
    _listaDaVisualizzare.remove(ordinazioneDaEvadere);
    _listaOrdiniPresiInCarico.remove(ordinazioneDaEvadere);
    notifyListeners();
  }

  Future<void> registra_nuova_ordinazione(int tavolo, String note,
      List<Elemento_ordinato> elementi, Utente addetto_alla_sala) async {
    try {
      _ordinazione_service.registra_nuova_ordinazione(
          Ordinazione.senzaId(tavolo, note, elementi, addetto_alla_sala));
    } catch (error) {
      rethrow;
    }
  }

  Future<void> elimina_ordinazione(Ordinazione ordinazione) async {
    try {
      _ordinazione_service.elimina_ordinazione(ordinazione);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> modifica_ordinazione(Ordinazione ordinazione) async {
    try {
      _ordinazione_service.modifica_ordinazione(ordinazione);
    } catch (error) {
      rethrow;
    }
  }

  void connettiStompClient() {
    try {
      _ordinazione_service.onStompCallback = onStompCallback;
      _ordinazione_service.configuraStompClient(utente.get_id_ristorante());
    } catch (error) {
      rethrow;
    }
  }
}