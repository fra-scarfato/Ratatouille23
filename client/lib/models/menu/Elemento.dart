class Elemento{

  late int _id;
  late String _nome;
  late String _descrizione;
  late double _costo;
  late String _allergeni;
  late int _id_categoria;

  Elemento(int id, String nome, String descrizione, double costo, String allergeni, int id_categoria){
    _id=id;
    _nome=nome;
    _descrizione=descrizione;
    _costo=costo;
    _allergeni=allergeni;
    _id_categoria=id_categoria;
  }

  Elemento.fromJson(Map<String, dynamic> json):
    _id=json['id'],
    _nome=json['nome'],
    _descrizione=json['descrizione'],
    _costo=json['costo'],
    _allergeni=json['allergeni'],
    _id_categoria=json['id_categoria'];

  Map<String, dynamic> toJson(){
    return{
      'id':_id,
      'nome':_nome,
      'descrizione':_descrizione,
      'costo':_costo,
      'allergeni':_allergeni,
      'id_categoria':_id_categoria
    };
  }


  void set_id(int id){_id=id;}
  void set_nome(String nome){_nome=nome;}
  void set_descrizione(String descrizione){_descrizione=descrizione;}
  void set_costo(double costo){_costo=costo;}
  void set_allergeni(String allergeni){_allergeni=allergeni;}
  void set_id_categoria(int id_categoria){_id_categoria=id_categoria;}

  int get_id(){return _id;}
  String get_nome(){return _nome;}
  String get_descrizone(){return _descrizione;}
  double get_costo(){return _costo;}
  String get_allergeni(){return _allergeni;}
  int get_id_categoria(){return _id_categoria;}


}