import 'menu/Elemento.dart';

class Elemento_ordinato{
  late int _id_ordinazione;
  late Elemento _elemento;
  late int _quantita;

  Elemento_ordinato(int id_ordinazione, Elemento elemento, int quantita){
    _id_ordinazione=id_ordinazione;
    _elemento=elemento;
    _quantita=quantita;
  }

  Elemento_ordinato.senzaId(Elemento elemento, int quantita){
    _elemento=elemento;
    _quantita=quantita;
  }

  Elemento_ordinato.fromJson(Map<String, dynamic> json):
      _id_ordinazione=json['id'],
      _elemento=Elemento.fromJson(json['elementoDaOrdinare']),
      _quantita=json['quantita'];

  Map<String, dynamic> toJson(){
    return{
      'id':_id_ordinazione,
      'elementoDaOrdinare':_elemento.toJsonSenzaCategoria(),
      'quantita':_quantita

    };
  }

  Map<String, dynamic> toJsonSenzaId(){
    return{
      'elemento':_elemento.toJsonSenzaId(),
      'quantita':_quantita

    };
  }

  void set_id_ordinazione(int id_ordinazione){_id_ordinazione=id_ordinazione;}
  void set_id_elemento(Elemento elemento){_elemento=elemento;}
  void incrementa_quantita(){_quantita++;}
  void decrementa_quantita(){
    if(_quantita > 0){
      _quantita--;
    }
  }

  int get_id_ordinazione(){return _id_ordinazione;}
  Elemento get_elemento(){return _elemento;}
  int get_quantita(){return _quantita;}
}