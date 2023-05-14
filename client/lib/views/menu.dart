import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ratatouille23/models/menu/Categoria.dart';
import 'package:ratatouille23/views/custom_widget/bottone_gestione_menu_admin.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flag/flag.dart';

import '../controllers/Menu_controller.dart';
import '../models/Utente.dart';
import 'custom_widget/barra_superiore.dart';
import 'custom_widget/categorie_bar.dart';
import 'custom_widget/elementi_card.dart';
import 'custom_widget/elementi_card_bottom.dart';
import 'custom_widget/elementi_card_header.dart';
import 'custom_widget/finestra_nessun_elemento.dart';
import 'home.dart';

class menu extends StatefulWidget {
  final Utente utente;

  const menu({super.key, required this.utente});

  @override
  menu_ui createState() => menu_ui();
}

class menu_ui extends State<menu> {
  Menu_controller _menu_controller = new Menu_controller();
  List<Categoria>? listaCategorie = [];

  @override
  Widget build(BuildContext context) {
    Utente utente = widget.utente;
    return FutureBuilder(
      future: _menu_controller.getAllCategorie(utente.get_id_ristorante()),
      builder: (BuildContext context, snapshot) {
        Widget widget;
        if (snapshot.connectionState == ConnectionState.done) {
          List<Categoria>? menu = [];
          menu = snapshot.data;
          var elem = getElementiCards(menu![0]);
          listaCategorie = menu;
          widget = Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                barra_superiore(
                  text: '',
                ),
                CategorieBar(listaCategorie: listaCategorie!),
                SizedBox(
                  height: 30,
                ),
                container_elementi(elem)
              ],
            ),
            floatingActionButton: bottone_gestione_menu_admin(
                listaCategorie: menu, utente: utente),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        } else {
          widget = Container(
            color: Colors.white,
            child: Center(
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
      categoria.get_elementi()!.forEach((element) {
        list.add(elementi_card(
          utente: widget.utente,
          elemento: element,
          listaCategorie: listaCategorie,
        ));
      });
    }

    return list;
  }

  Widget container_elementi(var elem) {
    Widget widget;
    if (elem != []) {
      widget = Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 187,
        child: ReorderableListView(
          shrinkWrap: true,
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              if (newIndex > oldIndex) {
                newIndex -= 1;
              }

              final items = elem.removeAt(oldIndex);
              elem.insert(newIndex, items);
            });
          },
          children: [
            ...elem,
          ],
        ),
      );
    } else if (listaCategorie == []) {
      widget = finestra_nessun_elemento(
          string1: 'NON CI SONO PIATTI',
          string2: 'NELLA CATEGORIA',
          string3: '',
          string4: 'AGGIUNGI UN NUOVO PIATTO',
          string5: 'CLICCANDO IL BOTTONE');
    } else {
      widget = finestra_nessun_elemento(
          string1: 'NON CI SONO PIATTI',
          string2: 'NEL TUO MENU',
          string3: 'CREA UNA CATEGORIA E',
          string4: 'AGGIUNGI UN NUOVO PIATTO',
          string5: 'CLICCANDO IL BOTTONE');
    }
    return widget;
  }
}
