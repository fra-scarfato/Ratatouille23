import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ratatouille23/controllers/Menu_controller.dart';
import 'package:ratatouille23/controllers/Presa_ordinazione_view_controller.dart';
import 'package:ratatouille23/views/custom_widget/visualizza_riepilogo_modifica.dart';

import '../../controllers/Ordinazione_controller.dart';
import '../../models/Elemento_ordinato.dart';
import '../../models/Ordinazione.dart';
import '../../models/Utente.dart';
import '../../models/menu/Categoria.dart';
import 'Finestra_errore.dart';
import 'barra_superiore.dart';
import 'categorie_bar.dart';
import 'elementi_card_modifica_ordinazione.dart';
import 'finestra_nessun_elemento.dart';

class Modifica_ordinazione extends StatefulWidget {
  Modifica_ordinazione(
      {super.key, required this.utente, required this.ordinazione, required this.ordinazione_controller});
  
  final Ordinazione_controller ordinazione_controller;
  final Utente utente;
  final Ordinazione ordinazione;
  final Menu_controller menu_controller = Menu_controller();
  final Presa_ordinazione_view_controller presa_ordinazione_view_controller = Presa_ordinazione_view_controller();

  @override
  Modifica_ordinazione_ui createState() => Modifica_ordinazione_ui();
}

class Modifica_ordinazione_ui extends State<Modifica_ordinazione>{

  @override
  Widget build(BuildContext context) {
    List<Elemento_ordinato> elementi_ordinati = [];

    return FutureBuilder(
      future: widget.menu_controller.getAllCategorie(widget.utente.get_id_ristorante()),
      builder: (BuildContext context, snapshot) {
        Widget widgetDaTornare;
        if (snapshot.connectionState == ConnectionState.done) {
          widget.presa_ordinazione_view_controller
              .set_categorie(widget.menu_controller.getCategorieDaVisualizzare());
          List<Categoria> menu = widget.menu_controller.getCategorieDaVisualizzare();
          if (menu.isNotEmpty) {
            widget.menu_controller.set_selected(menu[0]);
          }
          widgetDaTornare = Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const barra_superiore(
                  text: '',
                ),
                CategorieBar_parent(menu_controller: widget.menu_controller),
                const SizedBox(
                  height: 30,
                ),
                ListenableBuilder(
                    listenable: widget.menu_controller,
                    builder: (context, child) {
                      List<Widget> elem = [];
                      if (menu.isNotEmpty) {
                        elem = elementi_card_ordinazione(
                            widget.menu_controller.get_selected());
                        elementi_ordinati = widget.presa_ordinazione_view_controller
                            .get_list_elem_ord();
                      }
                      return container_elementi(elem);
                    }),
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                elementi_ordinati =
                    widget.presa_ordinazione_view_controller.get_list_elem_ord();

                if (elementi_ordinati.isNotEmpty) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Visualizza_riepilogo_modifica(
                              ordinazione: widget.ordinazione,
                              elementi_ordinati: elementi_ordinati,
                              utente: widget.utente, ordinazione_controller: widget.ordinazione_controller, )));
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
    int quantita;
    if (categoria.get_elementi()!.isNotEmpty) {
      for (var element in categoria.get_elementi()!) {
        int index = widget.ordinazione.get_lista_elementi().indexWhere((elementoOrdinato) => (elementoOrdinato.get_elemento().id == element.id));
        if(index != -1) {
          quantita = widget.ordinazione.get_lista_elementi()[index].get_quantita();
        } else {
          quantita = 0;
        }
        list.add(elementi_card_modifica_ordinazione(
            utente: widget.utente,
            elemento: element,
            quantita: quantita,
            presa_ordinazione_view_controller:
            widget.presa_ordinazione_view_controller));
      }
    }

    return list;
  }

  Widget container_elementi(List<Widget> elem) {
    Widget widgetDaTornare;
    if (elem.isNotEmpty) {
      widgetDaTornare = SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 187,
        child: ListView(
          shrinkWrap: true,
          children: [
            ...elem,
          ],
        ),
      );
    } else if (widget.menu_controller.getCategorieDaVisualizzare().isNotEmpty) {
      widgetDaTornare = const finestra_nessun_elemento(
          string1: 'NON CI SONO PIATTI',
          string2: 'NELLA CATEGORIA',
          string3: '',
          string4: '',
          string5: '');
    } else {
      widgetDaTornare = const finestra_nessun_elemento(
          string1: 'NON CI SONO PIATTI',
          string2: 'NEL TUO MENU',
          string3: '',
          string4: '',
          string5: '');
    }
    return widgetDaTornare;
  }
}