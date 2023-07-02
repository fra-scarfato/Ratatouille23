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
  final List<Ordinazione> _listaOrdiniAttesa = <Ordinazione>[];
  final List<Ordinazione> _listaOrdiniPresiInCarico = <Ordinazione>[];
  List<Ordinazione> _listaDaVisualizzare = <Ordinazione>[];
  final Utente utente;

  Ordinazione_controller({required this.utente});

  void onStompCallback(StompFrame frame) {
    print(frame.body.toString());
    Ordinazione_DTO ordinazioneDto = Ordinazione_DTO.fromJsonSTOMP(
        jsonDecode(frame.body.toString()));
    if(ordinazioneDto.ordinazione.get_gestore_ordinazione() == null) {
      if (ordinazioneDto.operazione == "INSERT") {
        _listaOrdiniAttesa.add(ordinazioneDto.ordinazione);
      }
      notifyListeners();
    }
    //Se l'elemento in coda è da qualche altro utente, allora aggiorno la schermata
    else if (ordinazioneDto.ordinazione.get_gestore_ordinazione()!.get_id() !=
        utente.get_id()) {
      if (ordinazioneDto.operazione == "UPDATE") {
        if (ordinazioneDto.ordinazione.get_stato() == "Presa in carico") {
          _listaOrdiniAttesa.removeWhere((element) =>
          element.get_id() == ordinazioneDto.ordinazione.get_id());
          _listaOrdiniPresiInCarico.add(ordinazioneDto.ordinazione);
        } else if (ordinazioneDto.ordinazione.get_stato() == "Evasa") {
          _listaOrdiniPresiInCarico.removeWhere((element) =>
          element.get_id() == ordinazioneDto.ordinazione.get_id());
        }
      } else {
        if (ordinazioneDto.ordinazione.get_stato() == "In attesa") {
          _listaOrdiniAttesa.remove(ordinazioneDto.ordinazione);
        } else {
          _listaOrdiniPresiInCarico.remove(ordinazioneDto.ordinazione);
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
      _listaOrdinazioniSala = await _ordinazione_service.elenco_ordinazioni_sala(utente);
      return _listaOrdinazioniCucina;
    } catch (error) {
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
      List<Elemento_ordinato> elementi, Utente addettoAllaSala) async {
    try {
      Ordinazione nuovaOrdinazione = Ordinazione.senzaId(tavolo, note, elementi, addettoAllaSala);
      await _ordinazione_service.registra_nuova_ordinazione(nuovaOrdinazione);
      _listaOrdinazioniSala.add(nuovaOrdinazione);
      _listaOrdiniAttesa.add(nuovaOrdinazione);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> elimina_ordinazione_sala(Ordinazione ordinazione) async {
    try {
      String statoOrdinazione = await _ordinazione_service.get_ordinazione_by_id(ordinazione.get_id());
      if(statoOrdinazione != "In attesa") {
        throw "Ordinazione presa in carico. Impossibile eliminare.";
      }
      await _ordinazione_service.elimina_ordinazione(ordinazione);
      _listaOrdinazioniSala.remove(ordinazione);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> elimina_ordinazione_cucina(Ordinazione ordinazione) async {
    try {
      if(ordinazione.get_stato() == "In attesa") {
        _listaOrdiniAttesa.remove(ordinazione);
      }
      else if(ordinazione.get_stato() == "Presa in carico") {
        _listaOrdiniPresiInCarico.remove(ordinazione);
      }
      await _ordinazione_service.elimina_ordinazione(ordinazione);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> modifica_ordinazione_cucina(Ordinazione ordinazioneDaModificare) async {
    try {
      await _ordinazione_service.modifica_ordinazione(ordinazioneDaModificare);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> modifica_ordinazione_sala(Ordinazione ordinazioneDaModificare) async {
    try {
      String statoOrdinazione = await _ordinazione_service.get_ordinazione_by_id(ordinazioneDaModificare.get_id());
      if(statoOrdinazione != "In attesa") {
        throw "Ordinazione presa in carico. Impossibile modificare.";
      }
      await _ordinazione_service.modifica_ordinazione(ordinazioneDaModificare);
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