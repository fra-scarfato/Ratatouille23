import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:ratatouille23/views/custom_widget/Finestra_errore.dart';
import 'package:ratatouille23/views/custom_widget/bottone_gestione_menu_admin.dart';
import 'package:ratatouille23/views/pagina_iniziale.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flag/flag.dart';

import '../controllers/Menu_controller.dart';
import '../controllers/Menu_view_controller.dart';
import '../controllers/Presa_ordinazione_view_controller.dart';
import '../models/Elemento_ordinato.dart';
import '../models/Ordinazione.dart';
import '../models/Utente.dart';
import '../models/menu/Categoria.dart';
import '../models/menu/Elemento.dart';
import 'custom_widget/Visualizza_riepilogo.dart';
import 'custom_widget/barra_superiore.dart';
import 'custom_widget/categorie_bar.dart';
import 'custom_widget/elementi_card.dart';
import 'custom_widget/elementi_card_bottom.dart';
import 'custom_widget/elementi_card_header.dart';
import 'custom_widget/elementi_card_presa_ordinazione.dart';
import 'custom_widget/bottone_arancione_con_testo.dart';
import 'custom_widget/finestra_nessun_elemento.dart';
import 'home.dart';

class Presa_ordinazione extends StatefulWidget {
  const Presa_ordinazione({super.key, required this.numeroTavolo, required this.utente});

  final String numeroTavolo;
  final Utente utente;

  @override
  Presa_ordinazione_state createState() => Presa_ordinazione_state();
}

class Presa_ordinazione_state extends State<Presa_ordinazione>{



  Menu_controller _menu_controller = new Menu_controller();
  //List<Categoria>? listaCategorie = [];
  final Presa_ordinazione_view_controller _presa_ordinazione_view_controller= Presa_ordinazione_view_controller();
  final Menu_view_controller _menu_view_controller= Menu_view_controller();

  @override
  Widget build(BuildContext context) {
    Utente utente = widget.utente;
    int tavolo = int.parse(widget.numeroTavolo);
    List<Elemento_ordinato> elementi_ordinati = [];

    return FutureBuilder(
      future: _menu_controller.getAllCategorie(utente.get_id_ristorante()),
      builder: (BuildContext context, snapshot) {
        Widget widget;
        if (snapshot.connectionState == ConnectionState.done) {
        //   _menu_view_controller.set_categorie(
        //     [Categoria(0, "nome",
        //         [Elemento(0, "nome", "descrizione", 1, "allergeni", Categoria(0,"",[],0)),
        //           Elemento(1, "nome1", "descrizione1", 1, "allergeni", Categoria(0,"",[],0)),
        //           Elemento(2, "nome2", "descrizione", 1, "allergeni", Categoria(0,"",[],0)),
        //           Elemento(3, "nome3", "descrizione", 1, "allergeni", Categoria(0,"",[],0))],
        //         0),
        //       Categoria(1, "nome2",
        //           [Elemento(0, "nome4", "descrizione", 1, "allergeni", Categoria(0,"",[],0)),
        //             Elemento(1, "nome5", "descrizione1", 1, "allergeni", Categoria(0,"",[],0)),
        //             Elemento(2, "nome6", "descrizione", 1, "allergeni", Categoria(0,"",[],0)),
        //             Elemento(3, "nome7", "descrizione", 1, "allergeni", Categoria(0,"",[],0))],
        //           0),
        //       Categoria(2, "nome3",
        //           [/*Elemento(0, "nome8", "descrizione", 1, "allergeni", Categoria(0,"",[],0)),
        //         Elemento(1, "nome10", "descrizione1", 1, "allergeni", Categoria(0,"",[],0)),
        //         Elemento(2, "nome11", "descrizione", 1, "allergeni", Categoria(0,"",[],0)),
        //         Elemento(3, "nome12", "descrizione", 1, "allergeni", Categoria(0,"",[],0))*/],
        //           0),]
        // );
        _menu_view_controller.set_categorie(snapshot.data);
        _presa_ordinazione_view_controller.set_categorie(_menu_view_controller.get_categorie());
        List<Categoria>? menu = _menu_view_controller.get_categorie();
        if (menu!.isNotEmpty) {
          _menu_view_controller.set_selected(menu[0]);
        }
        widget = Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              barra_superiore(
                text: '',
              ),
              CategorieBar_parent(
                  listaCategorie: _menu_view_controller.get_categorie(),
                  menu_view_controller: _menu_view_controller
              ),
              SizedBox(
                height: 30,
              ),
              ListenableBuilder(
                  listenable: _menu_view_controller,
                  builder: (context, child){
                    List<Widget> elem = [];
                    if (menu.isNotEmpty) {
                      elem = elementi_card_ordinazione(_menu_view_controller.get_selected());
                      elementi_ordinati = _presa_ordinazione_view_controller.get_list_elem_ord();
                    }
                    return container_elementi(elem);
                  }
              ),
              // ElevatedButton(
              //
              //     onPressed: () {
              //       check_ordinazione(tavolo, _presa_ordinazione_view_controller.get_list_elem_ord(), utente);
              //     },
              //     child: Text(
              //       'Visualizza riepilogo',
              //       style:TextStyle(
              //         fontSize: 12,
              //         color: Colors.white,
              //       ),
              //     ),
              //
              //     style: ElevatedButton.styleFrom(
              //       shape: StadiumBorder(),
              //       backgroundColor: Colors.orange,
              //       padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              //
              //     )
              //
              // )
            ],

          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: (){
              elementi_ordinati = _presa_ordinazione_view_controller.get_list_elem_ord();
              print(elementi_ordinati.length);
              if(elementi_ordinati.length > 0){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Visualizza_riepilogo(tavolo: tavolo, elementi_ordinati: elementi_ordinati/*_presa_ordinazione_view_controller.get_list_elem_ord()*/, utente: utente)));
              } else {
                FToast toast = FToast();
                toast.init(context);
                return toast.showToast(
                    child: Finestra_errore(message: 'L\'ordine non puo essere vuoto!'),
                    toastDuration: Duration(seconds: 2),
                    gravity: ToastGravity.BOTTOM
                );
              }
            },
            label: Text('Visualizza riepilogo', style: TextStyle(color: Colors.white, fontSize: 24,),),
            backgroundColor: Colors.orangeAccent,
            hoverColor: Colors.orange,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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


  List<Widget> elementi_card_ordinazione(Categoria categoria){
    List<Widget> list = [];
    if (categoria.get_elementi()!.isNotEmpty) {
      categoria.get_elementi()!.forEach((element) {
        list.add(elementi_card_presa_ordinazione(
          utente: widget.utente,
          elemento: element,
          presa_ordinazione_view_controller: _presa_ordinazione_view_controller
        ));
      });
    }

    return list;
  }

  Widget  container_elementi(List<Widget> elem) {
    Widget widget;
    if (elem.length != 0) {
      widget = Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 187,
        child: ListView(
          shrinkWrap: true,
          children: [
            ...elem,
          ],
        ),
      );
    } else if (_menu_view_controller.get_categorie().length != 0) {
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

  check_ordinazione(int tavolo, List<Elemento_ordinato> get_list_elem_ord, Utente utente) {
    if(get_list_elem_ord.length != 0){
      return Visualizza_riepilogo(tavolo: tavolo, elementi_ordinati: _presa_ordinazione_view_controller.get_list_elem_ord(), utente: utente);
    } else {
      FToast toast = FToast();
      toast.init(context);
      return toast.showToast(
          child: Finestra_errore(message: 'L\'ordine non puo essere vuoto!'),
          toastDuration: Duration(seconds: 2),
          gravity: ToastGravity.BOTTOM
      );
    }
  }
}