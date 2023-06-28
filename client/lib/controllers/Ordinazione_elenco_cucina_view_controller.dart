import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../models/Ordinazione.dart';
import '../views/custom_widget/Finestra_attesa.dart';
import '../views/custom_widget/Finestra_conferma.dart';
import '../views/custom_widget/Finestra_errore.dart';
import '../controllers/Ordinazione_controller.dart';

class Ordinazione_elenco_cucina_view_controller with ChangeNotifier{
  List<String>? _bottoni = <String>["IN ATTESA", "PRESI IN CARICO"];
  late String _selected = "IN ATTESA";
  List<Ordinazione>? _ordinazioni = [];
  Ordinazione_controller _ordinazione_controller = new Ordinazione_controller();

  set_ordinazioni(List<Ordinazione>? ord){_ordinazioni = ord; for(int i=0;i<_ordinazioni!.length;i++){print(_ordinazioni?[i].get_stato());}; notifyListeners();}
  set_selected(String string){_selected = string; notifyListeners();}
  set_stato(Ordinazione ord, String stato) async {
    int i = 0;
    while(_ordinazioni?[i] != ord){
      i++;
    }
    _ordinazioni?[i].set_stato(stato);

    /**************************************************************************/

    var attesa = Finestra_attesa(context as BuildContext);
    FToast toast = FToast();
    toast.init(context as BuildContext);
    try{
      attesa.showDialogue();
      await _ordinazione_controller.modifica_ordinazione(
          _ordinazioni![i].get_id(),
          _ordinazioni![i].get_tavolo(),
          _ordinazioni![i].get_note(),
          stato,
          _ordinazioni![i].get_lista_elementi(),
          _ordinazioni![i].get_gestore_ordinazione()
      );
      attesa.hideProgressDialogue();
      Fluttertoast.cancel();
    }catch (error){
      attesa.hideProgressDialogue();
      Fluttertoast.cancel();
      toast.showToast(
          child: Finestra_errore(message: "Aggiunta non riuscita"),
          toastDuration: Duration(seconds: 2),
          gravity: ToastGravity.BOTTOM);
    }

    /*****************************************************************************/

    notifyListeners();
  }

  get_selected(){return _selected;}
  get_bottoni(){return _bottoni;}
  get_ordinazioni(){return _ordinazioni;}
}