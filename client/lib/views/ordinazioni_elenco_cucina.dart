import 'package:flutter/material.dart';
import 'package:ratatouille23/controllers/Ordinazione_controller.dart';
import 'package:ratatouille23/views/custom_widget/ordini_bar.dart';

import '../models/Utente.dart';
import 'custom_widget/barra_superiore.dart';
import 'custom_widget/finestra_nessun_elemento.dart';
import 'custom_widget/ordinazioni_cucina_card.dart';

class ordinazioni_elenco_cucina extends StatefulWidget {
  final Utente utente;

  const ordinazioni_elenco_cucina({super.key, required this.utente});

  @override
  ordinazioni_elenco_cucina_ui createState() =>
      ordinazioni_elenco_cucina_ui();
}

class ordinazioni_elenco_cucina_ui extends State<ordinazioni_elenco_cucina> {
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
                    const barra_superiore(text: 'Lista ordinazioni'),
                    const SizedBox(height: 30),
                    ListenableBuilder(
                        listenable: _ordinazione_controller,
                        builder: (context, child) {
                          return bottoneOrdini(ordinazione_controller: _ordinazione_controller,);
                        }
                    ),
                    const SizedBox(height: 30),
                    ListenableBuilder(
                        listenable: _ordinazione_controller,
                        builder: (context, child) {
                          if (_ordinazione_controller.getListaOrdinazioniDaVisualizzare().isNotEmpty) {
                            return ordinazioni_cucina_card(
                                ord: _ordinazione_controller.getListaOrdinazioniDaVisualizzare(), ordinazione_controller: _ordinazione_controller, utente: widget.utente);
                          } else {
                            return const finestra_nessun_elemento(
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
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return widgetDaTornare;
        });
  }
}

