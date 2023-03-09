import 'package:ratatouille23/models/Categoria.dart';
import 'package:ratatouille23/models/Elemento.dart';
import 'package:ratatouille23/services/Menu_service.dart';

class Menu_repository{

  late Menu_service _menu_service;

  Menu_repository(Menu_service menu_service){_menu_service=menu_service;}

  Future<void> inserisci_categoria(Categoria categoria) async {
    await _menu_service.inserisci_categoria(categoria.toJson());
  }

  Future<void> rimuovi_categoria(int id) async{
    await _menu_service.rimuovi_categoria(id);
  }

  Future<List<Categoria>> elenco_categorie() async {
    var categorie= await _menu_service.elenco_categorie();
    return categorie.map((categoria) => Categoria.fromJson(categoria)).toList();
  }

  Future<void> aggiungi_elemento_a_categoria(int id, Elemento elemento) async {
    var categoria= await _menu_service.trova_categoria(id);
    if(categoria != null){
      Map<String, dynamic> elementi= categoria['elementi'];
      elementi.addAll(elemento.toJson());
      _menu_service.inserisci_elemento(id, elemento.toJson());
    }
  }
}