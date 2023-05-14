import 'package:ratatouille23/services/Menu_service.dart';

import '../models/menu/Categoria.dart';
import '../models/menu/Elemento.dart';


class Menu_controller{
  late Menu_service _menu_service = Menu_service();

  Future<void> aggiungiCategoria(String nome, int idRistorante) async {
    try{
      var categoriaDaAggiungere = Categoria.senzaIdAndElementi(nome, idRistorante);
      _menu_service.aggiungiNuovaCategoria(categoriaDaAggiungere);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> rimuoviCategoria(Categoria categoriaDaRimuovere) async{
    try{
      _menu_service.eliminaCategoria(categoriaDaRimuovere);
    } catch (error) {
      rethrow;
    }
  }

  Future<List<Categoria>?> getAllCategorie(int id_ristornate) async {
    try{
      List<Categoria> listaCategorie = await _menu_service.getCategorie(id_ristornate);
      return listaCategorie;
    } catch (error) {
      rethrow;
    }
  }

  List<String> getCategorieAsString(List<Categoria>? listaCategorie) {
    List<String> listaCategorieAsString = [];
    if(listaCategorie!.isNotEmpty) {
      listaCategorie.forEach((categoria) {
        listaCategorieAsString.add(categoria.get_nome());
      });
    }
    return listaCategorieAsString;
  }

  Categoria? trovaCategoriaElemento(String nomeCategoria, List<Categoria>? listaCategorie){
    Categoria? categoriaElemento;
    listaCategorie!.forEach((categoria) {
      if(categoria.get_nome() == nomeCategoria) {
        categoriaElemento = categoria;
      }
    });
    return categoriaElemento;
  }

  Future<void> aggiungiElemento(Elemento elementoDaAggiungere) async {
    try{
      _menu_service.aggiungiNuovoElemento(elementoDaAggiungere);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> rimuoviElemento(Elemento elementoDaRimuovere) async{
    try{
      _menu_service.eliminaElemento(elementoDaRimuovere);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> modificaElemento(Elemento elementoDaAggiornare) async {
    try{
      _menu_service.aggiornaVecchioElemento(elementoDaAggiornare);
    } catch (error) {
      rethrow;
    }
  }




}