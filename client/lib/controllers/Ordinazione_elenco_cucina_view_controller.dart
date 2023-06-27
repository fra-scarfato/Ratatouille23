import 'package:flutter/cupertino.dart';

class Ordinazione_elenco_cucina_view_controller with ChangeNotifier{
  List<String>? _bottoni = <String>["IN ATTESA", "PRESI IN CARICO"];
  late String _selected = "IN ATTESA";

  set_selected(String string){_selected = string; notifyListeners();}

  get_selected(){return _selected;}
  get_bottoni(){return _bottoni;}
}