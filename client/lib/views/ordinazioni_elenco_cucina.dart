import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ratatouille23/controllers/Ordinazione_controller.dart';
import 'package:ratatouille23/services/Ordinazione_service.dart';
import 'package:ratatouille23/views/ordinazioni_vuoto.dart';
import 'package:ratatouille23/views/custom_widget/ordinazioni_cucina_presi_in_carica_card.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import '../models/Elemento_ordinato.dart';
import '../models/Ordinazione.dart';
import '../models/Utente.dart';
import '../models/menu/Elemento.dart';
import 'custom_widget/barra_superiore.dart';
import 'custom_widget/ordinazioni_card.dart';
import 'custom_widget/ordinazioni_cucina_card.dart';

class ordinazioni_elenco_cucina extends StatefulWidget{

  // @override
  // Widget build(BuildContext context) {
  //   SystemChrome.setPreferredOrientations([
  //     DeviceOrientation.landscapeLeft,
  //     DeviceOrientation.landscapeRight,
  //   ]);
  //   return MaterialApp(
  //     title: 'Flutter Demo',
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
  //     // initialRoute: "/",
  //
  //   );
  // }

  @override
  ordinazioni_elenco_cucina_state createState() => ordinazioni_elenco_cucina_state();
}

class ordinazioni_elenco_cucina_state extends State<ordinazioni_elenco_cucina>{
  Ordinazione_controller ordinazione_controller = Ordinazione_controller();
  Ordinazione_service ordinazione_service = Ordinazione_service();
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
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: Container(
          decoration: BoxDecoration(
            color: Colors.white
              /*image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/bubble.png"),
              )*/
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              barra_superiore(text: 'Lista ordinazioni'),
              SizedBox(height: 30),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height-195,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height-195,
                    //child: ordinazioni_cucina_card(ord: ord)
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height-195,
                    //child: ordinazioni_cucina_presi_in_carica_card(ord: ord)
                ),
              ],
            )
            ),
              /*Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height-195,
                child: ordinazioni_cucina_card(ord: ord),

              ),*/
              SizedBox(height: 10,),
              Container(
                width: 100,
                child: ElevatedButton(

                    onPressed: () {
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => const menu()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.circle, size: 25, color: Colors.orangeAccent,),
                        SizedBox(width: 5),
                        Icon(Icons.circle_outlined, size: 25, color: Colors.orangeAccent,),                    ],
                    ),
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  ),
                ),
              )
            ],
          )
      ),

    );

  }



}