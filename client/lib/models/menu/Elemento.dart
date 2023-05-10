import 'Categoria.dart';

class Elemento{

  late int _id;
  late String _nome;
  late String _descrizione;
  late double _costo;
  late String _allergeni;
  late Categoria _categoria;

  Elemento.senzaId(String nome, String descrizione, double costo, String allergeni, Categoria categoria){
    _nome=nome;
    _descrizione=descrizione;
    _costo=costo;
    _allergeni=allergeni;
    _categoria=categoria;
  }

  Elemento(int id, String nome, String descrizione, double costo, String allergeni, Categoria categoria){
    _id=id;
    _nome=nome;
    _descrizione=descrizione;
    _costo=costo;
    _allergeni=allergeni;
    _categoria=categoria;
  }

  Elemento.fromJson(Map<String, dynamic> json):
    _id=json['id'],
    _nome=json['nome'],
    _descrizione=json['descrizione'],
    _costo=json['costo'],
    _allergeni=json['allergeni'];

  Map<String, dynamic> toJson(){
    return{
      'id':_id,
      'nome':_nome,
      'descrizione':_descrizione,
      'costo':_costo,
      'allergeni':_allergeni,
      'categoria':_categoria.toJson(),
    };
  }

  Map<String, dynamic> toJsonSenzaId(){
    return{
      'nome':_nome,
      'descrizione':_descrizione,
      'costo':_costo,
      'allergeni':_allergeni,
      'categoria':_categoria.toJson(),
    };
  }


  Categoria get categoria => _categoria;

  set categoria(Categoria value) {
    _categoria = value;
  }

  String get allergeni => _allergeni;

  set allergeni(String value) {
    _allergeni = value;
  }

  double get costo => _costo;

  set costo(double value) {
    _costo = value;
  }

  String get descrizione => _descrizione;

  set descrizione(String value) {
    _descrizione = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }
}