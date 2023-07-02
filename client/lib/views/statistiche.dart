import 'package:flutter/material.dart';
import 'package:ratatouille23/models/ElementiVendutiData.dart';
import 'package:ratatouille23/views/custom_widget/barra_superiore.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../controllers/Statistiche_controller.dart';
import '../models/Utente.dart';

class statistiche extends StatefulWidget {
  final Utente utente;

  const statistiche({super.key, required this.utente});

  @override
  statistiche_ui createState() => statistiche_ui();
}

class statistiche_ui extends State<statistiche> {
  List<ElementiVendutiData> listaElementi = <ElementiVendutiData>[];
  Statistiche_controller statistiche_controller = Statistiche_controller();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: statistiche_controller.getData(widget.utente),
        builder: (BuildContext context, snapshot) {
          Widget widgetDaTornare;
          if (snapshot.connectionState == ConnectionState.done) {
            if(snapshot.data != null) {
              listaElementi = snapshot.data!;
            }
            widgetDaTornare = Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  barra_superiore(text: ""),
                  SizedBox(height: 20,),
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              color: Colors.white,
                              elevation: 24.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(33.0))),
                              child: SfCartesianChart(
                                title: ChartTitle(
                                    text: 'Pietanze che hanno fatto guadagnare di più',
                                    borderWidth: 2,
                                    alignment: ChartAlignment.center,
                                    textStyle: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Roboto',
                                      fontStyle: FontStyle.italic,
                                      fontSize: 14,
                                    )
                                ),
                                primaryXAxis: CategoryAxis(),
                                series: <ChartSeries>[
                                  ColumnSeries<ElementiVendutiData, String>(
                                      dataSource: listaElementi,
                                      xValueMapper:
                                          (ElementiVendutiData elementi, _) =>
                                              elementi.nomeElemento,
                                      yValueMapper:
                                          (ElementiVendutiData elementi, _) =>
                                              elementi.guadagno,
                                      dataLabelSettings:
                                          DataLabelSettings(isVisible: true))
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Card(
                              color: Colors.white,
                              elevation: 24.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(33.0))),
                              child: SfCircularChart(
                                legend: const Legend(isVisible: true),
                                title: ChartTitle(
                                    text: 'Pietanze più vendute',
                                    borderWidth: 2,
                                    alignment: ChartAlignment.center,
                                    textStyle: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Roboto',
                                      fontStyle: FontStyle.italic,
                                      fontSize: 14,
                                    )
                                ),
                                series: <CircularSeries>[
                                  PieSeries<ElementiVendutiData, String>(
                                      dataSource: listaElementi,
                                      xValueMapper: (ElementiVendutiData elementi, _) => elementi.nomeElemento,
                                      yValueMapper: (ElementiVendutiData elementi, _) => elementi.numeroVendite,
                                      dataLabelSettings: const DataLabelSettings(
                                          isVisible: true,
                                          textStyle: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Roboto',
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14,
                                          ),
                                          labelPosition: ChartDataLabelPosition.outside)
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
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
