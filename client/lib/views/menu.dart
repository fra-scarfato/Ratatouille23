import 'package:flutter/material.dart';
import 'package:ratatouille23/models/menu/Categoria.dart';
import 'package:ratatouille23/views/custom_widget/bottone_gestione_menu_admin.dart';

import '../controllers/Menu_controller.dart';
import '../models/Utente.dart';
import 'custom_widget/barra_superiore.dart';
import 'custom_widget/categorie_bar.dart';
import 'custom_widget/elementi_card.dart';
import 'custom_widget/finestra_nessun_elemento.dart';

class menu extends StatefulWidget {
  final Utente utente;

  const menu({super.key, required this.utente});

  @override
  menu_ui createState() => menu_ui();
}

class menu_ui extends State<menu> {
  final Menu_controller _menu_controller = Menu_controller();
  List<Categoria> listaCategorie = [];

  @override
  Widget build(BuildContext context) {
    Utente utente = widget.utente;
    return FutureBuilder(
      future: _menu_controller.getAllCategorie(utente.get_id_ristorante()),
      builder: (BuildContext context, snapshot) {
        Widget widget;
        if (snapshot.connectionState == ConnectionState.done) {
          listaCategorie = _menu_controller.getCategorieDaVisualizzare();
          if(listaCategorie.isNotEmpty) {
            _menu_controller.set_selected(listaCategorie[0]);
          }
          widget = Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const barra_superiore(
                  text: '',
                ),
                ListenableBuilder(
                  listenable: _menu_controller,
                  builder: (context, child) {
                    return CategorieBar_parent(
                        menu_controller: _menu_controller);
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                ListenableBuilder(
                    listenable: _menu_controller,
                    builder: (context, child) {
                      List<Widget> elem = [];
                      if (listaCategorie.isNotEmpty) {
                        elem = getElementiCards(
                            _menu_controller.get_selected());
                      }
                      return container_elementi(elem);
                    })
              ],
            ),
            floatingActionButton: bottone_gestione_menu_admin(
                listaCategorie: listaCategorie, utente: utente, menu_controller: _menu_controller, ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        } else {
          widget = Container(
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return widget;
      },
    );
  }

  List<Widget> getElementiCards(Categoria categoria) {
    //TODO: Sto prendendo gli elementi di tutte le categorie nella prima schermata. Devo sapere in che categoria sono e visualizzare solo gli elementi di quella categoria
    List<Widget> list = [];
    if (categoria.get_elementi()!.isNotEmpty) {
      for (var element in categoria.get_elementi()!) {
        element.categoria = categoria;
        list.add(elementi_card(
          utente: widget.utente,
          elemento: element,
          listaCategorie: _menu_controller.getCategorieDaVisualizzare(), menu_controller: _menu_controller,
        ));
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
    } else if (listaCategorie.isNotEmpty) {
      widget = const finestra_nessun_elemento(
          string1: 'NON CI SONO PIATTI',
          string2: 'NELLA CATEGORIA',
          string3: '',
          string4: 'AGGIUNGI UN NUOVO PIATTO',
          string5: 'CLICCANDO IL BOTTONE');
    } else {
      widget = const finestra_nessun_elemento(
          string1: 'NON CI SONO PIATTI',
          string2: 'NEL TUO MENU',
          string3: 'CREA UNA CATEGORIA E',
          string4: 'AGGIUNGI UN NUOVO PIATTO',
          string5: 'CLICCANDO IL BOTTONE');
    }
    return widget;
  }
}
