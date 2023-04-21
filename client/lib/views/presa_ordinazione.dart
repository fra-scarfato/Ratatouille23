import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ratatouille23/views/custom_widget/bottone_gestione_menu_admin.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flag/flag.dart';

import '../models/Elemento_ordinato.dart';
import '../models/Ordinazione.dart';
import '../models/Utente.dart';
import '../models/menu/Elemento.dart';
import 'custom_widget/Visualizza_riepilogo.dart';
import 'custom_widget/barra_superiore.dart';
import 'custom_widget/categoria_card.dart';
import 'custom_widget/elementi_card.dart';
import 'custom_widget/elementi_card_bottom.dart';
import 'custom_widget/elementi_card_header.dart';
import 'custom_widget/elementi_card_presa_ordinazione.dart';
import 'custom_widget/bottone_arancione_con_testo.dart';
import 'home.dart';

class Presa_ordinazione extends StatefulWidget {
  const Presa_ordinazione({super.key});

// This widget is the root of your application.
  //@override
  // Widget build(BuildContext context) {
  //   SystemChrome.setPreferredOrientations([
  //     DeviceOrientation.landscapeLeft,
  //     DeviceOrientation.landscapeRight,
  //   ]);
  //   return MaterialApp(
  //     title: 'Flutter Demo',
  //     theme: ThemeData(
  //       primarySwatch: Colors.orange,
  //
  //     ),
  //     builder: (context, child) =>
  //         ResponsiveWrapper.builder(
  //           child,
  //           maxWidth: 1200,
  //           minWidth: 480,
  //           defaultScale: true,
  //           breakpoints: [
  //             ResponsiveBreakpoint.resize(480, name: MOBILE),
  //             ResponsiveBreakpoint.autoScale(800, name: TABLET),
  //             ResponsiveBreakpoint.resize(1000, name: DESKTOP),
  //           ],
  //
  //         ),
  //
  //
  //
  //     initialRoute: "/",
  //
  //   );
  // }

  @override
  Presa_ordinazione_state createState() => Presa_ordinazione_state();
}

class Presa_ordinazione_state extends State<Presa_ordinazione>{

  late List<Widget> elem=elementi();
  //List<Elemento_ordinato> elem_ord=[Elemento_ordinato(5656, Elemento(47,'pera','frutto dolce',1.5,'',37), 1),Elemento_ordinato(5656, Elemento(42,'mela','frutto dolce',1.3,'',31), 3)];



  @override
  Widget build(BuildContext context) {
    elementi();
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          barra_superiore(text: '',),
          SizedBox(height: 30,),
          Container(
              height: 67,
              width: MediaQuery.of(context).size.width,
              child:ListView(
                  scrollDirection: Axis.horizontal,
                  children: categorie()

              )
          ),
          SizedBox(height: 30,),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height-187,
            child: ReorderableListView(
              shrinkWrap: true,
              onReorder: (int oldIndex, int newIndex) { setState(() {
                if (newIndex > oldIndex) {
                  newIndex -= 1;
                }
                final items = elem.removeAt(oldIndex);
                elem.insert(newIndex, items);
              }); },
              children:[
                ...elem,

              ],

            ),
          ),
          //bottone_arancione_con_testo(text: 'Visualizza riepilogo', route: Visualizza_riepilogo(Ordinazione(001, 3, 'boh', elem_ord, Utente(01,'er','va','ap','so','amministratore',45)))),


        ],
      ),


    );
  }


  List<Widget> categorie() {
    List<Widget> list=[];
    for(int i=0; i<10; i++){
      list.add(categoria_card( nomeCategoria: 'Primi',));
      list.add(categoria_card(nomeCategoria: 'Secondi'));
      list.add(categoria_card(nomeCategoria: 'Contorni'));
      list.add(categoria_card(nomeCategoria: 'Dolci'));
    }

    return list;

  }

  List<Widget> elementi() {

    List<Widget> list=[];
    list.add(elementi_card_presa_ordinazione(nome: 'Risotto', costo: 4.0, descrizione: 'La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli ingredienti a disposizione dei soldati americani e la fantasia di un cuoco romano. Il risultato fu il prototipo degli spaghetti alla carbonara: uova, bacon (poi guanciale) e formaggio', allergeni: 'Uova e derivati, latte e derivati, cereali e derivati'),);
    list.add(elementi_card_presa_ordinazione(nome: 'Risotto', costo: 4.0, descrizione: 'La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli ingredienti a disposizione dei soldati americani e la fantasia di un cuoco romano. Il risultato fu il prototipo degli spaghetti alla carbonara: uova, bacon (poi guanciale) e formaggio', allergeni: 'Uova e derivati, latte e derivati, cereali e derivati'),);
    list.add(elementi_card_presa_ordinazione(nome: 'Risotto', costo: 4.0, descrizione: 'La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli ingredienti a disposizione dei soldati americani e la fantasia di un cuoco romano. Il risultato fu il prototipo degli spaghetti alla carbonara: uova, bacon (poi guanciale) e formaggio', allergeni: 'Uova e derivati, latte e derivati, cereali e derivati'),);
    list.add(elementi_card_presa_ordinazione(nome: 'Risotto', costo: 4.0, descrizione: 'La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli ingredienti a disposizione dei soldati americani e la fantasia di un cuoco romano. Il risultato fu il prototipo degli spaghetti alla carbonara: uova, bacon (poi guanciale) e formaggio', allergeni: 'Uova e derivati, latte e derivati, cereali e derivati'),);
    list.add(elementi_card_presa_ordinazione(nome: 'Risotto', costo: 4.0, descrizione: 'La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli ingredienti a disposizione dei soldati americani e la fantasia di un cuoco romano. Il risultato fu il prototipo degli spaghetti alla carbonara: uova, bacon (poi guanciale) e formaggio', allergeni: 'Uova e derivati, latte e derivati, cereali e derivati'),);

    return list;

  }





}