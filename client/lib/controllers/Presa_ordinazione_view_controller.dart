import 'package:flutter/material.dart';
import 'package:ratatouille23/models/Elemento_ordinato.dart';
import 'package:ratatouille23/models/menu/Categoria.dart';

import '../models/menu/Elemento.dart';

class Presa_ordinazione_view_controller with ChangeNotifier{
  List<Categoria>? _categorie = <Categoria>[];
  List<Elemento_ordinato> _list_elem_ord = <Elemento_ordinato>[];


  set_categorie(List<Categoria>? cat){
    _categorie = cat;
    for(int i = 0; i < _categorie!.length; i++){
      for(int j = 0; j < _categorie![i].get_elementi()!.length; j++){
        _list_elem_ord.add(
            Elemento_ordinato(_categorie![i].get_elementi()![j].id, _categorie![i].get_elementi()![j], 0)
        );
      }
    }
    notifyListeners();
  }

  set_list_elem_ord(List<Elemento_ordinato> el){_list_elem_ord = el; notifyListeners();}

  aggiungi_quantita(Elemento elemento){
    int i = 0;
    while(_list_elem_ord[i].get_elemento().id != elemento.id){
      i++;
    }
    _list_elem_ord[i].incrementa_quantita();
    notifyListeners();
  }

  set_quantita(Elemento elemento, int quantita){
    int i = 0;
    while(_list_elem_ord[i].get_elemento().id != elemento.id){
      i++;
    }
    _list_elem_ord[i].set_quantita(quantita);
  }

  rimuovi_quantita(Elemento elemento){
    int i = 0;
    while(_list_elem_ord[i].get_elemento().id != elemento.id){
      i++;
    }
    _list_elem_ord[i].decrementa_quantita();
    notifyListeners();
  }

  get_categorie(){return _categorie;}

  List<Elemento_ordinato> get_list_elem_ord(){
    List<Elemento_ordinato> ordinazioni = <Elemento_ordinato>[];
    for(int i=0; i < _list_elem_ord.length; i++){
      // print(_list_elem_ord[i].get_quantita());
      if(_list_elem_ord[i].get_quantita() > 0){
        ordinazioni.add(_list_elem_ord[i]);
      }
    }
    return ordinazioni.toList();
  }
  get_quantita(Elemento elemento){
      int i = 0;
      while(_list_elem_ord[i].get_elemento().id != elemento.id){
        i++;
      }
      return _list_elem_ord[i].get_quantita();
    }
}