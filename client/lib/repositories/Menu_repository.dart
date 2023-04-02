import 'package:ratatouille23/models/menu/Categoria.dart';
import 'package:ratatouille23/models/menu/Elemento.dart';
import 'package:ratatouille23/services/Menu_service.dart';

class Menu_repository{

  late Menu_service _menu_service;

  Menu_repository(Menu_service menu_service){_menu_service=menu_service;}

  Future<void> inserisci_categoria(Categoria categoria) async {
    await _menu_service.aggiungi_nuova_categoria(categoria);
  }

  Future<void> rimuovi_categoria(Categoria categoria) async{
    await _menu_service.elimina_categoria(categoria);
  }

  Future<List<Categoria>> elenco_categorie() async {
    return _menu_service.elenco_categorie();
  }

  Future<void> inserisci_elemento(Elemento elemento) async {
    await _menu_service.aggiungi_nuovo_elemento(elemento);
  }

  Future<void> rimuovi_elemento(Elemento elemento) async{
    await _menu_service.elimina_elemento(elemento);
  }

  Future<void> modifica_elemento(Elemento elemento) async {
    await _menu_service.modifica_elemento(elemento);
  }

  Future<List<Elemento>> elenco_elementi() async {
    return _menu_service.elenco_elementi();
  }
}