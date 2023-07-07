import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ratatouille23/controllers/Ordinazione_controller.dart';
import 'package:ratatouille23/views/custom_widget/Finestra_errore.dart';

import '../controllers/Menu_controller.dart';
import '../controllers/Presa_ordinazione_view_controller.dart';
import '../models/Elemento_ordinato.dart';
import '../models/Utente.dart';
import '../models/menu/Categoria.dart';
import 'custom_widget/Visualizza_riepilogo.dart';
import 'custom_widget/barra_superiore.dart';
import 'custom_widget/categorie_bar.dart';
import 'custom_widget/elementi_card_presa_ordinazione.dart';
import 'custom_widget/finestra_nessun_elemento.dart';

class Presa_ordinazione extends StatefulWidget {
  const Presa_ordinazione(
      {super.key, required this.numeroTavolo, required this.utente, required this.ordinazione_controller});

  final String numeroTavolo;
  final Utente utente;
  final Ordinazione_controller ordinazione_controller;

  @override
  Presa_ordinazione_ui createState() => Presa_ordinazione_ui();
}

class Presa_ordinazione_ui extends State<Presa_ordinazione> {
  final Menu_controller _menu_controller = Menu_controller();
  final Presa_ordinazione_view_controller _presa_ordinazione_view_controller =
      Presa_ordinazione_view_controller();

  @override
  Widget build(BuildContext context) {
    Utente utente = widget.utente;
    int tavolo = int.parse(widget.numeroTavolo);
    List<Elemento_ordinato> elementi_ordinati = [];

    return FutureBuilder(
      future: _menu_controller.getAllCategorie(utente.get_id_ristorante()),
      builder: (BuildContext context, snapshot) {
        Widget widgetDaTornare;
        if (snapshot.connectionState == ConnectionState.done) {
          _presa_ordinazione_view_controller
              .set_categorie(_menu_controller.getCategorieDaVisualizzare());
          List<Categoria> menu = _menu_controller.getCategorieDaVisualizzare();
          if (menu.isNotEmpty) {
            _menu_controller.set_selected(menu[0]);
          }
          widgetDaTornare = Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const barra_superiore(
                  text: '',
                ),
                CategorieBar_parent(menu_controller: _menu_controller),
                const SizedBox(
                  height: 30,
                ),
                ListenableBuilder(
                    listenable: _menu_controller,
                    builder: (context, child) {
                      List<Widget> elem = [];
                      if (menu.isNotEmpty) {
                        elem = elementi_card_ordinazione(
                            _menu_controller.get_selected());
                        elementi_ordinati = _presa_ordinazione_view_controller
                            .get_list_elem_ord();
                      }
                      return container_elementi(elem);
                    }),
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                elementi_ordinati =
                    _presa_ordinazione_view_controller.get_list_elem_ord();

                if (elementi_ordinati.isNotEmpty) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Visualizza_riepilogo(
                              tavolo: tavolo,
                              elementi_ordinati:
                                  elementi_ordinati /*_presa_ordinazione_view_controller.get_list_elem_ord()*/,
                              utente: utente, ordinazione_controller: widget.ordinazione_controller,)));
                } else {
                  FToast toast = FToast();
                  toast.init(context);
                  return toast.showToast(
                      child: const Finestra_errore(
                          message: 'L\'ordine non puo essere vuoto!'),
                      toastDuration: const Duration(seconds: 2),
                      gravity: ToastGravity.BOTTOM);
                }
              },
              label: const Text(
                'Visualizza riepilogo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              backgroundColor: Colors.orangeAccent,
              hoverColor: Colors.orange,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        } else {
          widgetDaTornare = Container(
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return widgetDaTornare;
      },
    );
  }

  List<Widget> elementi_card_ordinazione(Categoria categoria) {
    List<Widget> list = [];
    if (categoria.get_elementi()!.isNotEmpty) {
      for (var element in categoria.get_elementi()!) {
        list.add(elementi_card_presa_ordinazione(
            utente: widget.utente,
            elemento: element,
            presa_ordinazione_view_controller:
                _presa_ordinazione_view_controller));
      }
    }

    return list;
  }

  Widget container_elementi(List<Widget> elem) {
    Widget widget;
    if (elem.isNotEmpty) {
      widget = SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 187,
        child: ListView(
          shrinkWrap: true,
          children: [
            ...elem,
          ],
        ),
      );
    } else if (_menu_controller.getCategorieDaVisualizzare().isNotEmpty) {
      widget = const finestra_nessun_elemento(
          string1: 'NON CI SONO PIATTI',
          string2: 'NELLA CATEGORIA',
          string3: '',
          string4: '',
          string5: '');
    } else {
      widget = const finestra_nessun_elemento(
          string1: 'NON CI SONO PIATTI',
          string2: 'NEL TUO MENU',
          string3: '',
          string4: '',
          string5: '');
    }
    return widget;
  }

  check_ordinazione(
      int tavolo, List<Elemento_ordinato> get_list_elem_ord, Utente utente) {
    if (get_list_elem_ord.isNotEmpty) {
      return Visualizza_riepilogo(
          tavolo: tavolo,
          elementi_ordinati:
              _presa_ordinazione_view_controller.get_list_elem_ord(),
          utente: utente, ordinazione_controller: widget.ordinazione_controller,);
    } else {
      FToast toast = FToast();
      toast.init(context);
      return toast.showToast(
          child: const Finestra_errore(message: 'L\'ordine non puo essere vuoto!'),
          toastDuration: const Duration(seconds: 2),
          gravity: ToastGravity.BOTTOM);
    }
  }
}
