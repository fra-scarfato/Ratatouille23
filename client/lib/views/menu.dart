import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flag/flag.dart';

import 'barra_superiore.dart';
import 'home.dart';

class menu extends StatefulWidget {
  const menu({super.key});

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,

      ),
      builder: (context, child) =>
          ResponsiveWrapper.builder(
            child,
            maxWidth: 1200,
            minWidth: 480,
            defaultScale: true,
            breakpoints: [
              ResponsiveBreakpoint.resize(480, name: MOBILE),
              ResponsiveBreakpoint.autoScale(800, name: TABLET),
              ResponsiveBreakpoint.resize(1000, name: DESKTOP),
            ],

          ),



      initialRoute: "/",

    );
  }

  @override
  menu_ui createState() => menu_ui();
}

class menu_ui extends State<menu>{
  late String nome; late double costo; late String descrizione; late String allergeni;
  late List<Widget> elem=elementi();
  /*@override
  void initState(){
    List<Widget> item= <Widget>[

      elementi_card('Risotto', 4.0, 'La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli ingredienti a disposizione dei soldati americani e la fantasia di un cuoco romano. Il risultato fu il prototipo degli spaghetti alla carbonara: uova, bacon (poi guanciale) e formaggio', 'Uova e derivati, latte e derivati, cereali e derivati'),
      elementi_card('Bruschetta', 4.0, 'La storia più attendibile su questo primo piatto', ' Pesce e derivati'),
      elementi_card('Pizza', 4.0, 'La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli ingredienti a disposizione dei soldati americani e la fantasia di un cuoco romano. Il risultato fu il prototipo degli spaghetti alla carbonara: uova, bacon (poi guanciale) e formaggio', 'Uova e derivati, latte e derivati, cereali e derivati,La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli, Uova e derivati, latte e derivati, cereali e derivati,La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli'),
      elementi_card('Panino', 4.0, 'La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli ingredienti a disposizione ', ' Pesce e derivati'),
      elementi_card('Risotto', 4.0, 'La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli ingredienti a disposizione dei soldati americani e la fantasia di un cuoco romano. Il risultato fu il prototipo degli spaghetti alla carbonara: uova, bacon (poi guanciale) e formaggio', 'Uova e derivati, latte e derivati, cereali e derivati'),
      elementi_card('Bruschetta', 4.0, 'La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli ingredienti a disposizione dei soldati americani e la fantasia di un cuoco romano. Il risultato fu il prototipo degli spaghetti alla carbonara: uova, bacon (poi guanciale) e formaggio', ' Pesce e derivati'),
      elementi_card('Risotto', 4.0, 'La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli ingredienti a disposizione dei soldati americani e la fantasia di un cuoco romano. Il risultato fu il prototipo degli spaghetti alla carbonara: uova, bacon (poi guanciale) e formaggio', 'Uova e derivati, latte e derivati, cereali e derivati'),
      elementi_card('Bruschetta', 4.0, 'La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli ingredienti a disposizione dei soldati americani e la fantasia di un cuoco romano. Il risultato fu il prototipo degli spaghetti alla carbonara: uova, bacon (poi guanciale) e formaggio', 'Uova e derivati, latte e derivati, cereali e derivati'),
      elementi_card('Pizza', 4.0, 'La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli ingredienti a disposizione dei soldati americani e la fantasia di un cuoco romano. Il risultato fu il prototipo degli spaghetti alla carbonara: uova, bacon (poi guanciale) e formaggio', ' Pesce e derivati'),
      elementi_card('Panino', 4.0, 'La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli ingredienti a disposizione dei soldati americani e la fantasia di un cuoco romano. Il risultato fu il prototipo degli spaghetti alla carbonara: uova, bacon (poi guanciale) e formaggio', ''),
      elementi_card('Risotto', 4.0, 'La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli ingredienti a disposizione dei soldati americani e la fantasia di un cuoco romano. Il risultato fu il prototipo degli spaghetti alla carbonara: uova, bacon (poi guanciale) e formaggio', ''),
      elementi_card('Bruschetta', 4.0, 'La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli ingredienti a disposizione dei soldati americani e la fantasia di un cuoco romano. Il risultato fu il prototipo degli spaghetti alla carbonara: uova, bacon (poi guanciale) e formaggio', ''),

    ];
  }*/

  @override
  Widget build(BuildContext context) {
    elementi();
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          barra_superiore(),
          SizedBox(height: 30,),
          Container(
              height: 67,
              width: MediaQuery.of(context).size.width,
              child:ListView(
                  scrollDirection: Axis.horizontal,
                  children: categorie() /*<Widget>[
                categorie_card('Primi'),
                categorie_card('Secondi'),
                categorie_card('Contorni'),
                categorie_card('Frutta'),
                categorie_card('Dolci'),
                categorie_card('Primi'),
                categorie_card('Secondi'),
                categorie_card('Contorni'),
                categorie_card('Frutta'),
                categorie_card('Dolci'),
                categorie_card('Primi'),
                categorie_card('Secondi'),
                categorie_card('Contorni'),
                categorie_card('Frutta'),
                categorie_card('Dolci'),
              ]*/

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
              /*
              FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.orange,
              foregroundColor: Colors.black,

              child: Icon(
                Icons.sticky_note_2_outlined,
                size: 60
              ),
          )
              */

            ),
          ),


        ],
      ),

      floatingActionButton: ElevatedButton(

        onPressed: () {

        },
        child: Icon(
          Icons.sticky_note_2_outlined,
          color: Colors.black,
          size: 60,
        ),

        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          backgroundColor: Colors.orange,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),

        ),


      )/*FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.orange,
          foregroundColor: Colors.black,
          materialTapTargetSize: MaterialTapTargetSize.padded,
          child: Icon(
              Icons.sticky_note_2_outlined,
              size: 60
          ),
        )*/,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }


  List<Widget> categorie() {
    List<Widget> list=[];
    for(int i=0; i<10; i++){
      list.add(categorie_card('Primi'));
      list.add(categorie_card('Secondi'));
      list.add(categorie_card('Contorni'));
      list.add(categorie_card('Dolci'));
    }

    return list;

  }

  List<Widget> elementi() {

    List<Widget> list=[];
    list.add(elementi_card('Risotto', 4.0, 'La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli ingredienti a disposizione dei soldati americani e la fantasia di un cuoco romano. Il risultato fu il prototipo degli spaghetti alla carbonara: uova, bacon (poi guanciale) e formaggio', 'Uova e derivati, latte e derivati, cereali e derivati'),);
    list.add(elementi_card('Bruschetta', 4.0, 'La storia più attendibile su questo primo piatto', ' Pesce e derivati'));
    list.add(elementi_card('Pizza', 4.0, 'La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli ingredienti a disposizione dei soldati americani e la fantasia di un cuoco romano. Il risultato fu il prototipo degli spaghetti alla carbonara: uova, bacon (poi guanciale) e formaggio', 'Uova e derivati, latte e derivati, cereali e derivati,La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli, Uova e derivati, latte e derivati, cereali e derivati,La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli'),);
    list.add(elementi_card('Panino', 4.0, 'La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli ingredienti a disposizione ', ' Pesce e derivati'),);
    list.add(elementi_card('Risotto', 4.0, 'La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli ingredienti a disposizione dei soldati americani e la fantasia di un cuoco romano. Il risultato fu il prototipo degli spaghetti alla carbonara: uova, bacon (poi guanciale) e formaggio', 'Uova e derivati, latte e derivati, cereali e derivati'),);
    list.add(elementi_card('Bruschetta', 4.0, 'La storia più attendibile su questo primo piatto', ' Pesce e derivati'));
    list.add(elementi_card('Pizza', 4.0, 'La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli ingredienti a disposizione dei soldati americani e la fantasia di un cuoco romano. Il risultato fu il prototipo degli spaghetti alla carbonara: uova, bacon (poi guanciale) e formaggio', 'Uova e derivati, latte e derivati, cereali e derivati,La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli, Uova e derivati, latte e derivati, cereali e derivati,La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli'),);
    list.add(elementi_card('Panino', 4.0, 'La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli ingredienti a disposizione ', ' Pesce e derivati'),);
    list.add(elementi_card('Risotto', 4.0, 'La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli ingredienti a disposizione dei soldati americani e la fantasia di un cuoco romano. Il risultato fu il prototipo degli spaghetti alla carbonara: uova, bacon (poi guanciale) e formaggio', 'Uova e derivati, latte e derivati, cereali e derivati'),);
    list.add(elementi_card('Bruschetta', 4.0, 'La storia più attendibile su questo primo piatto', ' Pesce e derivati'));
    list.add(elementi_card('Pizza', 4.0, 'La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli ingredienti a disposizione dei soldati americani e la fantasia di un cuoco romano. Il risultato fu il prototipo degli spaghetti alla carbonara: uova, bacon (poi guanciale) e formaggio', 'Uova e derivati, latte e derivati, cereali e derivati,La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli, Uova e derivati, latte e derivati, cereali e derivati,La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli'),);
    list.add(elementi_card('Panino', 4.0, 'La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli ingredienti a disposizione ', ' Pesce e derivati'),);

    return list;

  }

  /*List<Widget> elementi2() {
    List<Widget> list=[
      elementi_card('Risotto', 4.0, 'La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli ingredienti a disposizione dei soldati americani e la fantasia di un cuoco romano. Il risultato fu il prototipo degli spaghetti alla carbonara: uova, bacon (poi guanciale) e formaggio', 'Uova e derivati, latte e derivati, cereali e derivati'),
      elementi_card('Bruschetta', 4.0, 'La storia più attendibile su questo primo piatto', ' Pesce e derivati'),
      elementi_card('Pizza', 4.0, 'La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli ingredienti a disposizione dei soldati americani e la fantasia di un cuoco romano. Il risultato fu il prototipo degli spaghetti alla carbonara: uova, bacon (poi guanciale) e formaggio', 'Uova e derivati, latte e derivati, cereali e derivati,La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli, Uova e derivati, latte e derivati, cereali e derivati,La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli'),
      elementi_card('Panino', 4.0, 'La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli ingredienti a disposizione ', ' Pesce e derivati'),
      elementi_card('Risotto', 4.0, 'La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli ingredienti a disposizione dei soldati americani e la fantasia di un cuoco romano. Il risultato fu il prototipo degli spaghetti alla carbonara: uova, bacon (poi guanciale) e formaggio', 'Uova e derivati, latte e derivati, cereali e derivati'),
      elementi_card('Bruschetta', 4.0, 'La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli ingredienti a disposizione dei soldati americani e la fantasia di un cuoco romano. Il risultato fu il prototipo degli spaghetti alla carbonara: uova, bacon (poi guanciale) e formaggio', ' Pesce e derivati'),
      elementi_card('Risotto', 4.0, 'La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli ingredienti a disposizione dei soldati americani e la fantasia di un cuoco romano. Il risultato fu il prototipo degli spaghetti alla carbonara: uova, bacon (poi guanciale) e formaggio', 'Uova e derivati, latte e derivati, cereali e derivati'),
      elementi_card('Bruschetta', 4.0, 'La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli ingredienti a disposizione dei soldati americani e la fantasia di un cuoco romano. Il risultato fu il prototipo degli spaghetti alla carbonara: uova, bacon (poi guanciale) e formaggio', 'Uova e derivati, latte e derivati, cereali e derivati'),
      elementi_card('Pizza', 4.0, 'La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli ingredienti a disposizione dei soldati americani e la fantasia di un cuoco romano. Il risultato fu il prototipo degli spaghetti alla carbonara: uova, bacon (poi guanciale) e formaggio', ' Pesce e derivati'),
      elementi_card('Panino', 4.0, 'La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli ingredienti a disposizione dei soldati americani e la fantasia di un cuoco romano. Il risultato fu il prototipo degli spaghetti alla carbonara: uova, bacon (poi guanciale) e formaggio', ''),
      elementi_card('Risotto', 4.0, 'La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli ingredienti a disposizione dei soldati americani e la fantasia di un cuoco romano. Il risultato fu il prototipo degli spaghetti alla carbonara: uova, bacon (poi guanciale) e formaggio', ''),
      elementi_card('Bruschetta', 4.0, 'La storia più attendibile su questo primo piatto, infatti, racconta l\'incontro tra gli ingredienti a disposizione dei soldati americani e la fantasia di un cuoco romano. Il risultato fu il prototipo degli spaghetti alla carbonara: uova, bacon (poi guanciale) e formaggio', ''),
    ];

    return list;

  }*/

  Card categorie_card(String label){
    return Card(
      color: Colors.yellow,
      shape: StadiumBorder(side: BorderSide(width: 1, color: Colors.black)),
      child: Padding(
        padding: EdgeInsets.all(8), //apply padding to all four sides
        child: Text(
          label,
          style: GoogleFonts.roboto(fontSize: 34, fontStyle: FontStyle.italic),
        ),
      ),

    );
  }

  Card elementi_card(String nome, double costo, String descrizione, String allergeni){
    return Card(
      key: UniqueKey(),
      color: Colors.white,
      elevation: 24.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(33.0))),
      child: Padding(
        padding: EdgeInsets.all(15), //apply padding to all four sides
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  nome,
                  style: GoogleFonts.roboto(color: Colors.orange, fontSize: 36, fontStyle: FontStyle.italic),
                ),
                Spacer(),
                Text(
                  'Costo: $costo\$',
                  style: GoogleFonts.roboto(color: Colors.orange, fontSize: 36, fontStyle: FontStyle.italic),
                ),
                SizedBox(width: 176,),
                IconButton(
                    onPressed: (){},
                    icon: Icon(
                      Icons.mode_edit_outlined,
                      size: 50,
                    )
                ),
                IconButton(
                    onPressed: (){},
                    icon: Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                      size: 50,
                    )
                ),


              ],
            ),
            SizedBox(height: 16),
            Container(
              width:1161,
              child: Text(
                  descrizione,
                  style: GoogleFonts.roboto(fontStyle: FontStyle.italic, fontSize: 27)
              ),
              //  )
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: (){},
                  child: Flag.fromCode(FlagsCode.IT, height: 30, width: 35),
                ),
                SizedBox(width: 8),
                InkWell(
                  onTap: (){},
                  child: Flag.fromCode(FlagsCode.GB, height: 30, width: 35),
                ),
                //SizedBox(width: 451,),
                Spacer(),
                Container(
                  width:1020,
                  alignment: AlignmentDirectional.topEnd,
                  child:Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Elenco allergeni:',
                          style: GoogleFonts.roboto(fontSize: 27, fontStyle: FontStyle.italic, color: Colors.orange)
                      ),
                      Expanded(child: Text(
                          allergeni,
                          // overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(fontSize: 27, fontStyle: FontStyle.italic)
                      )
                      )
                    ],
                    /*(
                        //text:'Elenco allergeni:',
                        style: GoogleFonts.roboto(fontSize: 27, fontStyle: FontStyle.italic, color: Colors.orange),
                        children: <TextSpan>[
                          new TextSpan(
                            text:'Elenco allergeni:'
                          ),
                          new TextSpan(text: '$allergeni',
                              style: GoogleFonts.roboto(fontSize: 27, fontStyle: FontStyle.italic))

                        ]
                    ),*/


                  ),
                ),

                /*Text(
                    allergeni,
                    style: GoogleFonts.roboto(fontSize: 27, fontStyle: FontStyle.italic))*/
              ],
            )
          ],
        ),
      ),

    );
  }




}