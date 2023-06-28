import 'package:flutter/cupertino.dart';
import '../../models/Ordinazione.dart';

class Ordinazione_elenco_cucina_view_controller with ChangeNotifier{
  List<String>? _bottoni = <String>["IN ATTESA", "PRESI IN CARICO"];
  late String _selected = "IN ATTESA";
  List<Ordinazione>? _ordinazioni = [];

  set_ordinazioni(List<Ordinazione>? ord){_ordinazioni = ord; for(int i=0;i<_ordinazioni!.length;i++){print(_ordinazioni?[i].get_stato());}; notifyListeners();}
  set_selected(String string){_selected = string; notifyListeners();}
  set_stato(Ordinazione ord, String stato){
    // ord.set_stato(stato);
    int i = 0;
    while(_ordinazioni?[i] != ord){
      i++;
    }
    _ordinazioni?[i].set_stato(stato);
    for(int i=0;i<_ordinazioni!.length;i++){print(_ordinazioni?[i].get_stato());}
    notifyListeners();
  }

  get_selected(){return _selected;}
  get_bottoni(){return _bottoni;}
  get_ordinazioni(){return _ordinazioni;}
}