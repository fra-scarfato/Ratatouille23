import 'package:ratatouille23/models/Ordinazione.dart';
import 'package:ratatouille23/services/Ordinazione_service.dart';

class Ordinazione_repository{

  late Ordinazione_service _ordinazione_service;

  Ordinazione_repository(Ordinazione_service ordinazione_service){
    _ordinazione_service=ordinazione_service;
  }

  Future<List<Ordinazione>> getAll() async{
    return _ordinazione_service.elenco_ordinazioni();

  }


  Future<void> registra_nuova_ordinazione(Ordinazione ordinazione) async {
    await _ordinazione_service.registra_nuova_ordinazione(ordinazione);
  }


  Future<void> modifica_ordinazione(Ordinazione ordinazione) async {
    await _ordinazione_service.modifica_ordinazione(ordinazione);
  }

  Future<void> elimina_ordinazione(Ordinazione ordinazione) async {
    await _ordinazione_service.elimina_ordinazione(ordinazione);
  }
}