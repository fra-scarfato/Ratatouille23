import 'package:flutter/cupertino.dart';

import '../models/Elemento.dart';

class Elemento_controller extends ChangeNotifier{

  late Elemento _elemento;

  Elemento_controller(Elemento elemento){_elemento=elemento; notifyListeners();}

  void set_id(int id){_elemento.set_id(id); notifyListeners();}
  void set_nome(String nome){_elemento.set_nome(nome); notifyListeners();}
  void set_descrizione(String descrizione){_elemento.set_descrizione(descrizione); notifyListeners();}
  void set_costo(double costo){_elemento.set_costo(costo); notifyListeners();}
  void set_allergeni(String allergeni){_elemento.set_allergeni(allergeni); notifyListeners();}

  int get_id(){return _elemento.get_id();}
  String get_nome(){return _elemento.get_nome();}
  String get_descrizone(){return _elemento.get_descrizone();}
  double get_costo(){return _elemento.get_costo();}
  String get_allergeni(){return _elemento.get_allergeni();}

  Elemento aggiungi_elemento(int id, String nome, String descrizione, double costo, String allergeni, int id_categoria){
    return Elemento(id, nome, descrizione, costo, allergeni, id_categoria);
  }

  void elimina_elemento(){}
}