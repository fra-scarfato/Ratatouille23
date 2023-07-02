
import 'package:ratatouille23/models/ElementiVendutiData.dart';
import 'package:ratatouille23/models/Ordinazione.dart';
import 'package:ratatouille23/models/menu/Categoria.dart';
import 'package:ratatouille23/models/menu/Elemento.dart';
import 'package:ratatouille23/services/Menu_service.dart';
import 'package:ratatouille23/services/Ordinazione_service.dart';

import '../models/Utente.dart';

class Statistiche_controller {
  final Ordinazione_service _ordinazione_service = Ordinazione_service();
  final Menu_service _menu_service = Menu_service();
  final List<Ordinazione> _listaOrdinazioni = <Ordinazione>[];
  final List<Elemento> _listaElementi = <Elemento>[];

  Future<List<ElementiVendutiData>> getData(Utente utente) async {
    List<Ordinazione> temp = await _ordinazione_service.elenco_ordinazioni_cucina(utente);
    List<Categoria> listaCategorie = await _menu_service.getCategorie(utente.get_id_ristorante());
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
    return preparaDati();
  }

  List<ElementiVendutiData> preparaDati() {
    List<ElementiVendutiData> elementiData = <ElementiVendutiData>[];
    for (var element in _listaElementi) {
      elementiData.add(ElementiVendutiData(element.nome, element.id, 0, 0));
    }
   for (var ordinazione in _listaOrdinazioni) {
     ordinazione.get_lista_elementi().forEach((element) {
       int index = elementiData.indexWhere((elementData) => (elementData.id_elemento==element.get_elemento().id));
       elementiData[index].numeroVendite = elementiData[index].numeroVendite + element.get_quantita();
       elementiData[index].guadagno = elementiData[index].guadagno + (element.get_quantita() * element.get_elemento().costo);
     });
   }
    return elementiData;
  }
}