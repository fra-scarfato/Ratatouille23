import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ratatouille23/controllers/Ordinazione_controller.dart';
import 'package:ratatouille23/controllers/Ordinazione_elenco_view_controller.dart';
import 'package:ratatouille23/services/Ordinazione_service.dart';
import 'package:ratatouille23/views/ordinazioni_vuoto.dart';
import 'package:ratatouille23/views/custom_widget/ordinazioni_cucina_presi_in_carica_card.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import '../controllers/Ordinazione_elenco_cucina_view_controller.dart';
import '../models/Elemento_ordinato.dart';
import '../models/Ordinazione.dart';
import '../models/Utente.dart';
import '../models/menu/Categoria.dart';
import '../models/menu/Elemento.dart';
import 'custom_widget/barra_superiore.dart';
import 'custom_widget/finestra_nessun_elemento.dart';
import 'custom_widget/ordinazioni_card.dart';
import 'custom_widget/ordinazioni_cucina_card.dart';

class ordinazioni_elenco_cucina extends StatefulWidget{

  final Utente utente;

  const  ordinazioni_elenco_cucina({super.key, required this.utente});

  @override
  ordinazioni_elenco_cucina_state createState() => ordinazioni_elenco_cucina_state();
}

class ordinazioni_elenco_cucina_state extends State<ordinazioni_elenco_cucina>{
  Ordinazione_elenco_view_controller _ordinazione_elenco_view_controller = Ordinazione_elenco_view_controller();
  Ordinazione_elenco_cucina_view_controller _ordinazione_elenco_cucina_view_controller = Ordinazione_elenco_cucina_view_controller();
  Ordinazione_controller _ordinazione_controller = Ordinazione_controller();
  // List<Elemento_ordinato> elem=[Elemento_ordinato(5656, Elemento(47,'pera','frutto dolce',1.5,'',37), 1),Elemento_ordinato(5656, Elemento(42,'mela','frutto dolce',1.3,'',31), 3)];
  //
  // late List<Ordinazione> ord=[Ordinazione(001, 3, 'boh', elem, Utente(01,'er','va','ap','so','amministratore',45)),Ordinazione(001, 3, 'boh', elem, Utente(01,'er','va','ap','so','amministratore',45)),
  //   Ordinazione(001, 3, 'boh', elem, Utente(01,'er','va','ap','so','amministratore',45)),Ordinazione(001, 3, 'boh', elem, Utente(01,'er','va','ap','so','amministratore',45))]; //= ordinazione_controller.getAll_ordini() as List<Ordinazione>;//ord = getall_ordini
    //ord[1].set_stato('Preso in carica');
  /*@override
  void initState() {
    Future.delayed(Duration.zero,() async {
      ord = await ordinazione_service.elenco_ordinazioni();
    });
    super.initState();
  }*/

  List<Elemento_ordinato> elem=[Elemento_ordinato(5656, Elemento(47,'pera','frutto dolce',1.5,'',Categoria(1,'n',[],1)), 1),Elemento_ordinato(5656, Elemento(42,'mela','frutto dolce',1.3,'',Categoria(1,'n',[],1)), 3)];


  @override
  Widget build(BuildContext context) {

    _ordinazione_elenco_view_controller.set_ordinazioni([Ordinazione(001, 3, 'boh', elem, Utente(01,'er','va','ap','so',45)),
      Ordinazione(001, 3, 'boh', elem, Utente(01,'er','va','ap','so',45)),
      Ordinazione(001, 3, 'boh nota molto lunga per appesantire chi legge e chi scrive e per testtare la grafica che sembra fatta da un babbeo', elem, Utente(01,'er','va','ap','so',45)),
      Ordinazione(001, 3, 'boh', elem, Utente(01,'er','va','ap','so',45))]);

    return FutureBuilder(
      // future: _ordinazione_controller.getAll_ordini(widget.utente),
      builder: (BuildContext context, snapshot){
        Widget widget;
        // if (snapshot.connectionState == ConnectionState.done){
        //   _ordinazione_elenco_view_controller.set_ordinazioni(snapshot.data);
          List<Ordinazione> ord = _ordinazione_elenco_view_controller.get_ordinazioni();
          widget = Scaffold(
            body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/bubble.png"),
                  )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  barra_superiore(text: 'Lista ordinazioni'),
                  SizedBox(height: 30),
                  // Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     mainAxisSize: MainAxisSize.max,
                  //     children: [
                  //       // Button(_ordinazione_elenco_cucina_view_controller, 0),
                  //       // Button(_ordinazione_elenco_cucina_view_controller, 1),
                  //       ...bottoni(_ordinazione_elenco_cucina_view_controller),
                  //     ],
                  // ),

                bottoneOrdini(_ordinazione_elenco_cucina_view_controller),

                ListenableBuilder(
                    listenable: _ordinazione_elenco_cucina_view_controller,
                    builder: (context, child) {
                      if(ord.isNotEmpty){
                        return ordinazioni_cucina_card(ord: ord, richiesta: _ordinazione_elenco_cucina_view_controller.get_selected(),);
                      } else {
                        return finestra_nessun_elemento(
                            string1: 'NON CI SONO',
                            string2: 'ORDINAZIONI PRESENTI',
                            string3: '',
                            string4: '',
                            string5: '');
                      }
                    }
                )
                  // Container(
                  //           width: MediaQuery.of(context).size.width,
                  //           height: MediaQuery.of(context).size.height-195,
                  //           child: Container(
                  //                   width: MediaQuery.of(context).size.width,
                  //                   height: MediaQuery.of(context).size.height-195,
                  //                   child: ListenableBuilder(
                  //                     listenable: _ordinazione_elenco_view_controller,
                  //                     builder: (context, child) {
                  //                       if(ord.isNotEmpty){
                  //                         return ordinazioni_cucina_card(ord: ord);
                  //                       } else {
                  //                         return finestra_nessun_elemento(
                  //                             string1: 'NON CI SONO',
                  //                             string2: 'ORDINAZIONI PRESENTI',
                  //                             string3: '',
                  //                             string4: '',
                  //                             string5: '');
                  //                       }
                  //                     },
                  //                   )
                  //               ),

                ],
              ),
            ),
          );

        // } else {
        //   widget = Container(
        //     color: Colors.white,
        //     child: Center(
        //       child: CircularProgressIndicator(),
        //     ),
        //   );
        // }
        return widget;
      }
    );


    // return Scaffold(
    //   backgroundColor: Colors.transparent,
    //   resizeToAvoidBottomInset: false,
    //   body: Container(
    //       decoration: BoxDecoration(
    //         color: Colors.white
    //           /*image: DecorationImage(
    //             fit: BoxFit.cover,
    //             image: AssetImage("assets/images/bubble.png"),
    //           )*/
    //       ),
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         children: [
    //           barra_superiore(text: 'Lista ordinazioni'),
    //           SizedBox(height: 30),
    //       Container(
    //         width: MediaQuery.of(context).size.width,
    //         height: MediaQuery.of(context).size.height-195,
    //         child: ListView(
    //           scrollDirection: Axis.horizontal,
    //           children: [
    //             Container(
    //                 width: MediaQuery.of(context).size.width,
    //                 height: MediaQuery.of(context).size.height-195,
    //                 //child: ordinazioni_cucina_card(ord: ord)
    //             ),
    //             Container(
    //                 width: MediaQuery.of(context).size.width,
    //                 height: MediaQuery.of(context).size.height-195,
    //                 //child: ordinazioni_cucina_presi_in_carica_card(ord: ord)
    //             ),
    //           ],
    //         )
    //         ),
    //           /*Container(
    //             width: MediaQuery.of(context).size.width,
    //             height: MediaQuery.of(context).size.height-195,
    //             child: ordinazioni_cucina_card(ord: ord),
    //
    //           ),*/
    //           SizedBox(height: 10,),
    //           Container(
    //             width: 100,
    //             child: ElevatedButton(
    //
    //                 onPressed: () {
    //                   //Navigator.push(context, MaterialPageRoute(builder: (context) => const menu()));
    //                 },
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     Icon(Icons.circle, size: 25, color: Colors.orangeAccent,),
    //                     SizedBox(width: 5),
    //                     Icon(Icons.circle_outlined, size: 25, color: Colors.orangeAccent,),                    ],
    //                 ),
    //               style: ElevatedButton.styleFrom(
    //                 shape: StadiumBorder(),
    //                 backgroundColor: Colors.white,
    //                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    //               ),
    //             ),
    //           )
    //         ],
    //       )
    //   ),
    //
    // );

  }

  Widget Button(Ordinazione_elenco_cucina_view_controller ordinazione_elenco_cucina_view_controller, int index){

    List<bool> list = [];
    @override
    void initState() {
      if (ordinazione_elenco_cucina_view_controller.get_bottoni()) {
        for(int i=0; i<ordinazione_elenco_cucina_view_controller.get_bottoni().length; i++){
          list.add(false);
        }
        list[0]=true;
      }
      super.initState();
    }

    return ElevatedButton(
        onPressed: (){
          ordinazione_elenco_cucina_view_controller.set_selected(ordinazione_elenco_cucina_view_controller.get_bottoni()[index]);
          setState(() {
            for(int i=0; i<list.length; i++){
              if(i!=index){
                list[i]=false;
              } else {
                list[index]=true;
              }
            }
          });},
        child: ListTile(
          tileColor: Colors.yellow.shade200,
          selectedTileColor: Colors.yellow,
          selectedColor: Colors.black,
          selected: list[index],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                ordinazione_elenco_cucina_view_controller.get_bottoni()[index],
                style: GoogleFonts.roboto(fontSize: 34, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        )
    );
  }

  Row bottoni(Ordinazione_elenco_cucina_view_controller ordinazione_elenco_cucina_view_controller){

    List<bool> list = [];
    for(int i=0; i<ordinazione_elenco_cucina_view_controller.get_bottoni().length; i++){
      list.add(false);
    }
    list[0]=true;
    super.initState();

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children:
        List.generate(
          ordinazione_elenco_cucina_view_controller.get_bottoni().length,
              (index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 250,
              child: ListTile(
                tileColor: Colors.yellow.shade200,
                selectedTileColor: Colors.yellow,
                selectedColor: Colors.black,
                selected: list[index],
                onTap: (){
                  ordinazione_elenco_cucina_view_controller.set_selected(ordinazione_elenco_cucina_view_controller.get_bottoni()[index]);
                  setState(() {
                    for(int i=0; i<list.length; i++){
                      if(i!=index){
                        list[i]=false;
                      } else {
                        list[index]=true;
                      }
                    }
                  });},
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ordinazione_elenco_cucina_view_controller.get_bottoni()[index],
                      style: GoogleFonts.roboto(fontSize: 34, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Row bottoneOrdini(Ordinazione_elenco_cucina_view_controller ordinazione_elenco_cucina_view_controller){
    List<bool> list = [true, false];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: ListTile(
            tileColor: Colors.yellow.shade200,
            selectedTileColor: Colors.yellow,
            selectedColor: Colors.black,
            selected: list[0],
            onTap: (){
              ordinazione_elenco_cucina_view_controller.set_selected('IN ATTESA');
              setState(() {
                list[0] = true;
                list[1] = false;
              });},
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Ordini in attesa',
                  style: GoogleFonts.roboto(fontSize: 24, fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
        ),
        Expanded(
            child:ListTile(
              tileColor: Colors.yellow.shade200,
              selectedTileColor: Colors.yellow,
              selectedColor: Colors.black,
              selected: list[1],
              onTap: (){
                ordinazione_elenco_cucina_view_controller.set_selected('PRESI IN CARICO');
                setState(() {
                  list[1] = true;
                  list[0] = false;
                });},
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Ordini presi in carica',
                    style: GoogleFonts.roboto(fontSize: 24, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            )
        )
      ],
    );

  }




}