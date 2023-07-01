import 'package:ratatouille23/models/Ordinazione.dart';

class Ordinazione_DTO{
  late Ordinazione _ordinazione;
  late String _operazione;


  Ordinazione_DTO(this._ordinazione, this._operazione);

  Ordinazione_DTO.fromJsonSTOMP(Map<String, dynamic> json){
    _operazione = json['operazione'];
    if(_operazione == "INSERT") {
      _ordinazione = Ordinazione.fromJson(json['ordinazione']);
    }

  }

  Ordinazione get ordinazione => _ordinazione;

  set ordinazione(Ordinazione value) {
    _ordinazione = value;
  }

  String get operazione => _operazione;

  set operazione(String value) {
    _operazione = value;
  }
}