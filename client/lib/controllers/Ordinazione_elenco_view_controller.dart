import 'package:flutter/cupertino.dart';

import '../models/Ordinazione.dart';

class Ordinazione_elenco_view_controller with ChangeNotifier{
  List<Ordinazione>? _ordinazioni = [];

  set_ordinazioni(List<Ordinazione>? ord){_ordinazioni = ord; notifyListeners();}
  get_ordinazioni(){return _ordinazioni;}
}