import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ratatouille23/controllers/Menu_view_controller.dart';
import 'package:ratatouille23/models/menu/Categoria.dart';
import 'package:ratatouille23/models/menu/Elemento.dart';
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
  final Menu_view_controller _menu_view_controller= Menu_view_controller();

  @override
  Widget build(BuildContext context) {
    Utente utente = widget.utente;
    return FutureBuilder(
      future: _menu_controller.getAllCategorie(utente.get_id_ristorante()),
      builder: (BuildContext context, snapshot) {
        Widget widget;
        if (snapshot.connectionState == ConnectionState.done) {
        // _menu_view_controller.set_categorie(
        //   [Categoria(0, "nome",
        //       [Elemento(0, "nome", "descrizione", 1, "allergeni", Categoria(0,"",[],0)),
        //         Elemento(1, "nome1", "descrizione1", 1, "allergeni", Categoria(0,"",[],0)),
        //         Elemento(2, "nome2", "descrizione", 1, "allergeni", Categoria(0,"",[],0)),
        //         Elemento(3, "nome3", "descrizione", 1, "allergeni", Categoria(0,"",[],0))],
        //       0),
        //   Categoria(1, "nome2",
        //       [Elemento(0, "nome4", "descrizione", 1, "allergeni", Categoria(0,"",[],0)),
        //         Elemento(1, "nome5", "descrizione1", 1, "allergeni", Categoria(0,"",[],0)),
        //         Elemento(2, "nome6", "descrizione", 1, "allergeni", Categoria(0,"",[],0)),
        //         Elemento(3, "nome7", "descrizione", 1, "allergeni", Categoria(0,"",[],0))],
        //       0),
        //   Categoria(2, "nome3",
        //       [Elemento(0, "nome8", "descrizione", 1, "allergeni", Categoria(0,"",[],0)),
        //         Elemento(1, "nome10", "descrizione1", 1, "allergeni", Categoria(0,"",[],0)),
        //         Elemento(2, "nome11", "descrizione", 1, "allergeni", Categoria(0,"",[],0)),
        //         Elemento(3, "nome12", "descrizione", 1, "allergeni", Categoria(0,"",[],0))],
        //       0),]
        // );
          //menu = snapshot.data;
          _menu_view_controller.set_categorie(snapshot.data);
          var menu = _menu_view_controller.get_categorie();
          // var elem = getElementiCards(context.read<Menu_view_controller>().get_categorie()[0]);
          // context.read<Menu_view_controller>().set_elem(elem);
          _menu_view_controller.set_selected(menu[0]);
          
          listaCategorie = menu;
          widget = Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                barra_superiore(
                  text: '',
                ),
                CategorieBar_parent(
                    listaCategorie: listaCategorie!,
                    menu_view_controller: _menu_view_controller
                    // fun: (Categoria categoria){
                    //  context.read<Menu_view_controller>().set_elem(getElementiCards(categoria));
                    //  print(categoria.get_nome());}
                ),
                SizedBox(
                  height: 30,
                ),
                //container_elementi(getElementiCards(context.watch<Menu_view_controller>().get_selected()))
                ListenableBuilder(
                    listenable: _menu_view_controller,
                    builder: (context, child){
                      var elem = getElementiCards(_menu_view_controller.get_selected());
                      return container_elementi(elem);
                    })
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
