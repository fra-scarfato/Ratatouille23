import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ratatouille23/views/custom_widget/bottone_gestione_menu_admin.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flag/flag.dart';

import 'custom_widget/barra_superiore.dart';
import 'custom_widget/categoria_card.dart';
import 'custom_widget/elementi_card.dart';
import 'custom_widget/elementi_card_bottom.dart';
import 'custom_widget/elementi_card_header.dart';
import 'home.dart';

class menu extends StatefulWidget {
  const menu({super.key});

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
  menu_ui createState() => menu_ui();
}

class menu_ui extends State<menu>{

  late List<Widget> elem=elementi();

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


        ],
      ),

      floatingActionButton: bottone_gestione_menu_admin(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
    list.add(elementi_card(nome: 'Risotto', costo: 4.0, descrizione: 'La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli ingredienti a disposizione dei soldati americani e la fantasia di un cuoco romano. Il risultato fu il prototipo degli spaghetti alla carbonara: uova, bacon (poi guanciale) e formaggio', allergeni: 'Uova e derivati, latte e derivati, cereali e derivati'),);
    list.add(elementi_card(nome: 'Risotto', costo: 4.0, descrizione: 'La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli ingredienti a disposizione dei soldati americani e la fantasia di un cuoco romano. Il risultato fu il prototipo degli spaghetti alla carbonara: uova, bacon (poi guanciale) e formaggio', allergeni: 'Uova e derivati, latte e derivati, cereali e derivati'),);
    list.add(elementi_card(nome: 'Risotto', costo: 4.0, descrizione: 'La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli ingredienti a disposizione dei soldati americani e la fantasia di un cuoco romano. Il risultato fu il prototipo degli spaghetti alla carbonara: uova, bacon (poi guanciale) e formaggio', allergeni: 'Uova e derivati, latte e derivati, cereali e derivati'),);
    list.add(elementi_card(nome: 'Risotto', costo: 4.0, descrizione: 'La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli ingredienti a disposizione dei soldati americani e la fantasia di un cuoco romano. Il risultato fu il prototipo degli spaghetti alla carbonara: uova, bacon (poi guanciale) e formaggio', allergeni: 'Uova e derivati, latte e derivati, cereali e derivati'),);
    list.add(elementi_card(nome: 'Risotto', costo: 4.0, descrizione: 'La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli ingredienti a disposizione dei soldati americani e la fantasia di un cuoco romano. Il risultato fu il prototipo degli spaghetti alla carbonara: uova, bacon (poi guanciale) e formaggio', allergeni: 'Uova e derivati, latte e derivati, cereali e derivati'),);

    return list;

  }





}