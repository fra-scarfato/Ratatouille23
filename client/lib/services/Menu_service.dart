class Menu_service{
  List<Map<String, dynamic>> _menu=[];
  List<Map<String, dynamic>> _elementi=[];


  Future<void> inserisci_categoria(Map<String, dynamic> categoria) async {
    _menu.add(categoria);

    //TODO...
  }

  Future<void> rimuovi_categoria(int id) async {
    _menu.removeWhere((element) => element['id']==id);
  }

  Future<List<Map<String, dynamic>>> elenco_categorie() async {
    await Future.delayed(Duration(milliseconds: 800));
    return _menu;
  }

  Future<Map<String, dynamic>?> trova_categoria(int id) async {
    return _menu.firstWhere((elemento) => elemento['id'] == id);
  }

  Future<void> inserisci_elemento(int id, Map<String, dynamic> elemento) async {
    _elementi.add(elemento);

    //TODO...
  }

  Future<void> rimuovi_elemento(int id) async {
    _elementi.removeWhere((element) => element['id']==id);
  }

  Future<List<Map<String, dynamic>>> elenco_elementi() async {
    await Future.delayed(Duration(milliseconds: 800));
    return _elementi;
  }
/*
  Future<List<Map<String, dynamic>>> get_elementi_categoria(int id) async{
    await Future.delayed(Duration(milliseconds: 800));
    int i= _menu.indexWhere((categoria) => categoria['id']==id);
    return _menu[i]['elementi'];

  }

  Future<void> inserisci_elemento(int id_categoria, Map<String, dynamic> elemento)async{
    int i= _menu.indexWhere((element) => element['id']==id_categoria);
    List<Map<String, dynamic>> _elementi= _menu[i]['elementi'];
    _elementi.add(elemento);
    //TODO...
  }

  Future<void> rimuovi_elemento(int id_categoria, int id_elemento) async {
    var _elementi= get_elementi_categoria(id_categoria) as List;
    _elementi.removeWhere((element) => element['id']==id_elemento);
    //TODO...

  }

  Future<void> modifica_elemento(int id_categoria, int id_elemento, Map<String, dynamic> elemento) async {
    var _elementi= get_elementi_categoria(id_categoria) as List;
    int i = _elementi.indexWhere((element) => element['id']==id_elemento);
    _elementi[i]=elemento;
  }
  */
}