import 'package:flutter/foundation.dart';

import '../models/Categoria.dart';
import '../models/Elemento.dart';

class Categoria_controller extends ChangeNotifier{

  late Categoria _categoria;

  Categoria_controller(Categoria categoria){_categoria=categoria; notifyListeners();}

  void set_id(int id){_categoria.set_id(id); notifyListeners();}
  void set_nome(String nome){_categoria.set_nome(nome); notifyListeners();}
  void set_elementi(List<Elemento> elementi){_categoria.set_elementi(elementi); notifyListeners();}

  int get_id(){return _categoria.get_id();}
  String get_nome(){return _categoria.get_nome();}
  List<Elemento> get_elementi(){return _categoria.get_elementi();}

  Categoria aggiungi_categoria(int id, String nome, List<Elemento> elementi, int id_ristorante){
    return Categoria(id, nome, elementi, id_ristorante);
  }

  void rimuovi_categoria(){}
}