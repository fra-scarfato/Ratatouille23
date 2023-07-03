
import 'package:ratatouille23/models/ElementoVendutoChartData.dart';
import 'package:ratatouille23/models/Ordinazione.dart';
import 'package:ratatouille23/models/TempoGuadagnoChartData.dart';
import 'package:ratatouille23/models/UtentiChartData.dart';
import 'package:ratatouille23/models/menu/Categoria.dart';
import 'package:ratatouille23/models/menu/Elemento.dart';
import 'package:ratatouille23/services/Menu_service.dart';
import 'package:ratatouille23/services/Ordinazione_service.dart';
import 'package:ratatouille23/services/Utente_service.dart';

import '../models/Utente.dart';

class Statistiche_controller {
  final Ordinazione_service _ordinazione_service = Ordinazione_service();
  final Menu_service _menu_service = Menu_service();
  final Utente_service _utente_service = Utente_service();
  final List<Ordinazione> _listaOrdinazioni = <Ordinazione>[];
  final List<Elemento> _listaElementi = <Elemento>[];
  List<Utente> _listaUtenti = <Utente>[];
  final List<AddettoAllaSalaChartData> _addettoData = <AddettoAllaSalaChartData>[];
  final List<GestoreOrdinazioneChartData> _gestoreData = <GestoreOrdinazioneChartData>[];
  final List<TempoGuadagnoChartData> _guadagniData = <TempoGuadagnoChartData>[];

  List<AddettoAllaSalaChartData> get addettoData => _addettoData;
  List<TempoGuadagnoChartData> get guadagniData => _guadagniData;

  Future<List<ElementoVendutoChartData>> prepareAndGetElementData(Utente utente) async {
    List<Ordinazione> temp = await _ordinazione_service.elenco_ordinazioni_cucina(utente);
    List<Categoria> listaCategorie = await _menu_service.getCategorie(utente.get_id_ristorante());
    _listaUtenti = await _utente_service.getUtenti(utente.get_id_ristorante());
    for (var categoria in listaCategorie) {
      if(categoria.get_elementi() != null) {
        categoria.get_elementi()?.forEach((element) {
          _listaElementi.add(element);
        });
      }
    }
    for (var element in temp) {
      if(element.get_stato() == "Evasa") {
        _listaOrdinazioni.add(element);
      }
    }
    preparaDatiUtente();
    preparaDatiGuadagno();
    return preparaDatiElementi();

  }

  List<ElementoVendutoChartData> preparaDatiElementi() {
    List<ElementoVendutoChartData> elementiData = <ElementoVendutoChartData>[];
    for (var element in _listaElementi) {
      elementiData.add(ElementoVendutoChartData(element.nome, element.id, 0, 0));
    }
   for (Ordinazione ordinazione in _listaOrdinazioni) {
     ordinazione.get_lista_elementi().forEach((element) {
       int index = elementiData.indexWhere((elementData) => (elementData.id_elemento==element.get_elemento().id));
       elementiData[index].numeroVendite = elementiData[index].numeroVendite + element.get_quantita();
       elementiData[index].guadagno = elementiData[index].guadagno + (element.get_quantita() * element.get_elemento().costo);
     });
   }
   return elementiData;
  }

  void preparaDatiUtente() {
    for(Utente utente in _listaUtenti) {
      if(utente.get_ruolo() == "Amministratore" || utente.get_ruolo() =="Addetto alla sala") {
        _addettoData.add(AddettoAllaSalaChartData(utente.get_id(), utente.get_name(), utente.get_cognome(), 0));
      }
      if(utente.get_ruolo() == "Amministratore" || utente.get_ruolo() == "Addetto alla cucina") {
        _gestoreData.add(GestoreOrdinazioneChartData(utente.get_id(), utente.get_name(), utente.get_cognome(), 0));
      }
    }
    for(Ordinazione ordinazione in _listaOrdinazioni) {
      int index = _addettoData.indexWhere((addetto) => (addetto.idAddetto == ordinazione.get_addetto_sala()?.get_id()));
      int indexGestore = _gestoreData.indexWhere((gestore) => (gestore.idGestore == ordinazione.get_gestore_ordinazione()?.get_id()));
      _addettoData[index].ordinazioniRegistrate = _addettoData[index].ordinazioniRegistrate + 1;
      _gestoreData[indexGestore].ordinazioniEvase = _gestoreData[indexGestore].ordinazioniEvase + 1;

    }
    _addettoData.sort((addetto1, addetto2) => addetto1.ordinazioniRegistrate.compareTo(addetto2.ordinazioniRegistrate));
    _gestoreData.sort((gestore1, gestore2) => gestore1.ordinazioniEvase.compareTo(gestore2.ordinazioniEvase));
  }

  void preparaDatiGuadagno() {
    List<DateTime> date = <DateTime>[];
    for(Ordinazione ordinazione in _listaOrdinazioni) {
      if(!date.contains(ordinazione.get_data())){
        date.add(ordinazione.get_data());
        _guadagniData.add(TempoGuadagnoChartData(ordinazione.get_data(),ordinazione.get_costo_totale()));
      } else {
        int index = _guadagniData.indexWhere((element) => (ordinazione.get_data() == element.data));
        _guadagniData[index].guadagno = _guadagniData[index].guadagno + ordinazione.get_costo_totale();
      }
    }
    _guadagniData.sort((guadagno1, guadagno2) => guadagno1.data.compareTo(guadagno2.data));
  }



  List<GestoreOrdinazioneChartData> get gestoreData => _gestoreData;
}