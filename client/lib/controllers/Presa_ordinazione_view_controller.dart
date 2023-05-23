import 'package:flutter/material.dart';
import 'package:ratatouille23/models/menu/Categoria.dart';

import '../models/menu/Elemento.dart';

class Presa_ordinazione_view_controller with ChangeNotifier{
  List<Categoria>? _categorie = <Categoria>[];
  List<Widget>? _elem = <Widget>[];//TODO
  late Categoria _selected ;

  set_categorie(List<Categoria>? cat){_categorie = cat; notifyListeners();}
  set_elem(List<Widget> el){_elem = el; notifyListeners();}
  set_selected(Categoria categoria){_selected = categoria; notifyListeners();}

  get_categorie(){return _categorie;}
  get_elem(){return _elem;}
  get_selected(){return _selected;}
}