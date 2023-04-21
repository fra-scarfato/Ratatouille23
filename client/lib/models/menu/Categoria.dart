import 'Elemento.dart';

class Categoria{

  late int _id;
  late String _nome;
  List<Elemento>? _elementi;
  late int _id_ristorante;

  Categoria.senzaIdAndElementi(this._nome, this._id_ristorante);

  Categoria(int id, String nome, List<Elemento> elementi, int id_ristorante) {
    _id = id;
    _nome = nome;
    _elementi = elementi;
    _id_ristorante=id_ristorante;
  }

  Categoria.senzaElementi(int id, String nome, int id_ristorante) {
    _id = id;
    _nome = nome;
    _id_ristorante=id_ristorante;
  }

  Categoria.fromJson(Map<String, dynamic> json) {
    _id=json['id'];
    _nome=json['nome'];
    _id_ristorante=json['idRistorante'];
    _elementi = [];
    json['elementiDellaCategoria'].forEach((v) {
      _elementi?.add(Elemento.fromJson(v));
    });

  }

  Map<String, dynamic> toJsonSenzaId(){
    return{
      'nome':_nome,
      'idRistorante':_id_ristorante
    };
  }

  Map<String, dynamic> toJson(){
    return{
      'id':_id,
      'nome':_nome,
      'idRistorante':_id_ristorante
    };
  }
    void set_id(int id){_id=id;}
    void set_nome(String nome){_nome=nome;}
    void set_elementi(List<Elemento> elemento){_elementi=elemento;}

    int get_id(){return _id;}
    String get_nome(){return _nome;}
    List<Elemento>? get_elementi(){return _elementi;}
    int getIDRistorante(){return _id_ristorante;}

}
