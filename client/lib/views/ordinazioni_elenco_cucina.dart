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
  Ordinazione_elenco_cucina_view_controller _ordinazione_elenco_cucina_view_controller = Ordinazione_elenco_cucina_view_controller();
  Ordinazione_controller _ordinazione_controller = new Ordinazione_controller();


  List<Elemento_ordinato> elem=[Elemento_ordinato(5656, Elemento(47,'pera','frutto dolce',1.5,'',Categoria(1,'n',[],1)), 1),Elemento_ordinato(5656, Elemento(42,'mela','frutto dolce',1.3,'',Categoria(1,'n',[],1)), 3)];


  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: _ordinazione_controller.getAll_ordini(widget.utente),
      builder: (BuildContext context, snapshot){
        Widget widget;
        if (snapshot.connectionState == ConnectionState.done){
        // _ordinazione_elenco_cucina_view_controller.set_ordinazioni([Ordinazione(001, 1, 'boh', elem, Utente(01,'er','va','ap','so',45)),
        //   Ordinazione(001, 2, 'boh', elem, Utente(01,'er','va','ap','so',45)),
        //   Ordinazione(001, 3, 'boh nota molto lunga per appesantire chi legge e chi scrive e per testtare la grafica che sembra fatta da un babbeo', elem, Utente(01,'er','va','ap','so',45)),
        //   Ordinazione(001, 4, 'boh', elem, Utente(01,'er','va','ap','so',45))]);
          _ordinazione_elenco_cucina_view_controller.set_ordinazioni(snapshot.data);
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
                  bottoneOrdini(_ordinazione_elenco_cucina_view_controller),

                ListenableBuilder(
                    listenable: _ordinazione_elenco_cucina_view_controller,
                    builder: (context, child) {
                      if(_ordinazione_elenco_cucina_view_controller.get_ordinazioni().isNotEmpty){
                        return ordinazioni_cucina_card(ord: _ordinazione_elenco_cucina_view_controller.get_ordinazioni(), richiesta: _ordinazione_elenco_cucina_view_controller.get_selected(), ordinazione_elenco_cucina_view_controller: _ordinazione_elenco_cucina_view_controller);
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

                ],
              ),
            ),
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
      }
    );
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
              if(ordinazione_elenco_cucina_view_controller.get_selected() != "IN ATTESA"){
                ordinazione_elenco_cucina_view_controller.set_selected("IN ATTESA");
                list[0] = true;
                list[1] = false;
              }
            },
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
                if(ordinazione_elenco_cucina_view_controller != "PRESI IN CARICO") {
                  ordinazione_elenco_cucina_view_controller.set_selected("PRESI IN CARICO");
                  list[1] = true;
                  list[0] = false;

                }
          },
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