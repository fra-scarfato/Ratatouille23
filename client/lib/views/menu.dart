import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ratatouille23/models/menu/Categoria.dart';
import 'package:ratatouille23/views/custom_widget/bottone_gestione_menu_admin.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flag/flag.dart';

import '../controllers/Menu_controller.dart';
import 'custom_widget/barra_superiore.dart';
import 'custom_widget/categoria_card.dart';
import 'custom_widget/elementi_card.dart';
import 'custom_widget/elementi_card_bottom.dart';
import 'custom_widget/elementi_card_header.dart';
import 'home.dart';

class menu extends StatefulWidget {
  const menu({super.key});

  @override
  menu_ui createState() => menu_ui();
}

class menu_ui extends State<menu> {
  Menu_controller _menu_controller = new Menu_controller();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _menu_controller.getAllCategorie(),
      builder: (BuildContext context, snapshot) {
        Widget widget;
        if (snapshot.connectionState == ConnectionState.done) {
          List<Categoria>? menu = [];
          menu = snapshot.data;
          var elem = getElementiCards(menu);
          widget = Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                barra_superiore(
                  text: '',
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                    height: 67,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        //TODO: Mi serve sapere in che categoria sono
                        children: getCategorieCards(menu))),
                SizedBox(
                  height: 30,
                ),
                Container(
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
                ),
              ],
            ),
            floatingActionButton: bottone_gestione_menu_admin(listaCategorie: menu,),
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

  List<Widget> getCategorieCards(List<Categoria>? listaCategorie) {
    List<Widget> list = [];
    if (listaCategorie!.isNotEmpty) {
      listaCategorie.forEach((element) {
        list.add(categoria_card(nomeCategoria: element.get_nome()));
      });
    }
    return list;
  }

  List<Widget> getElementiCards(List<Categoria>? listaCategorie) {
    //TODO: Sto prendendo gli elementi di tutte le categorie nella prima schermata. Devo sapere in che categoria sono e visualizzare solo gli elementi di quella categoria
    List<Widget> list = [];
    if (listaCategorie!.isNotEmpty) {
      listaCategorie.forEach((categoria) {
        if (categoria.get_elementi()!.isNotEmpty) {
          categoria.get_elementi()!.forEach((element) {
            list.add(elementi_card(
                nome: element.nome,
                costo: element.costo,
                descrizione: element.descrizione,
                allergeni: element.allergeni));
          });
        }
      });
    }
    return list;
  }
}
