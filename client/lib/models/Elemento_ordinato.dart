class Elemento_ordinato{
  late int _id_ordinazione;
  late int _id_elemento;
  late int _quantita;

  Elemento_ordinato(int id_ordinazione, int id_elemento, int quantita){
    _id_ordinazione=id_ordinazione;
    _id_elemento=id_elemento;
    _quantita=quantita;
  }

  Elemento_ordinato.fromJson(Map<String, dynamic> json):
      _id_ordinazione=json['id_ordinazione'],
      _id_elemento=json['id_elemento'],
      _quantita=json['quantita'];

  Map<String, dynamic> toJson(){
    return{
      'id_ordinazione':_id_ordinazione,
      'id_elemento':_id_elemento,
      'quantita':_quantita

    };
  }

  void set_id_ordinazione(int id_ordinazione){_id_ordinazione=id_ordinazione;}
  void set_id_elemento(int id_elemento){_id_elemento=id_elemento;}
  void incrementa_quantita(){_quantita++;}
  void decrementa_quantita(){_quantita--;}

  int get_id_ordinazione(){return _id_ordinazione;}
  int get__id_elemento(){return _id_elemento;}
  int get_quantita(){return _quantita;}
}