import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ratatouille23/controllers/Ordinazione_controller.dart';
import 'package:ratatouille23/services/Ordinazione_service.dart';
import 'package:ratatouille23/views/custom_widget/ordini_bar.dart';
import 'package:ratatouille23/views/ordinazioni_vuoto.dart';
import 'package:ratatouille23/views/custom_widget/ordinazioni_cucina_presi_in_carica_card.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import '../models/Elemento_ordinato.dart';
import '../models/Ordinazione.dart';
import '../models/Utente.dart';
import '../models/menu/Categoria.dart';
import '../models/menu/Elemento.dart';
import 'custom_widget/barra_superiore.dart';
import 'custom_widget/finestra_nessun_elemento.dart';
import 'custom_widget/ordinazioni_card.dart';
import 'custom_widget/ordinazioni_cucina_card.dart';

class ordinazioni_elenco_cucina extends StatefulWidget {
  final Utente utente;

  const ordinazioni_elenco_cucina({super.key, required this.utente});

  @override
  ordinazioni_elenco_cucina_state createState() =>
      ordinazioni_elenco_cucina_state();
}

class ordinazioni_elenco_cucina_state extends State<ordinazioni_elenco_cucina> {
  late Ordinazione_controller _ordinazione_controller;

  @override
  void initState() {
    _ordinazione_controller = Ordinazione_controller(utente: widget.utente);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _ordinazione_controller.connettiStompClient();
    return FutureBuilder(
        future: _ordinazione_controller.get_ordini_cucina(),
        builder: (BuildContext context, snapshot) {
          Widget widgetDaTornare;
          if (snapshot.connectionState == ConnectionState.done) {

            widgetDaTornare = Scaffold(
              body: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    barra_superiore(text: 'Lista ordinazioni'),
                    SizedBox(height: 30),
                    ListenableBuilder(
                        listenable: _ordinazione_controller,
                        builder: (context, child) {
                          return bottoneOrdini(ordinazione_controller: _ordinazione_controller,);
                        }
                    ),
                    SizedBox(height: 30),
                    ListenableBuilder(
                        listenable: _ordinazione_controller,
                        builder: (context, child) {
                          if (_ordinazione_controller.getListaOrdinazioniDaVisualizzare().isNotEmpty) {
                            return ordinazioni_cucina_card(
                                ord: _ordinazione_controller.getListaOrdinazioniDaVisualizzare(), ordinazione_controller: _ordinazione_controller, utente: widget.utente);
                          } else {
                            return finestra_nessun_elemento(
                                string1: 'NON CI SONO',
                                string2: 'ORDINAZIONI PRESENTI',
                                string3: '',
                                string4: 'ATTENEDERE',
                                string5: 'GLI OPERATORI DI SALA');
                          }
                        })
                  ],
                ),
              );
          } else {
            widgetDaTornare = Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return widgetDaTornare;
        });
  }
}

