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

  Elemento_ordinato.fromJson(Map<String, dynamic> json):
      _id_ordinazione=json['id_ordinazione'],
      _elemento=json['elemento'],
      _quantita=json['quantita'];

  Map<String, dynamic> toJson(){
    return{
      'id_ordinazione':_id_ordinazione,
      'elemento':_elemento,
      'quantita':_quantita

    };
  }

  void set_id_ordinazione(int id_ordinazione){_id_ordinazione=id_ordinazione;}
  void set_id_elemento(Elemento elemento){_elemento=elemento;}
  void incrementa_quantita(){_quantita++;}
  void decrementa_quantita(){_quantita--;}

  int get_id_ordinazione(){return _id_ordinazione;}
  Elemento get_elemento(){return _elemento;}
  int get_quantita(){return _quantita;}
}