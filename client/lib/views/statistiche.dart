import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ratatouille23/models/ElementoVendutoChartData.dart';
import 'package:ratatouille23/models/TempoGuadagnoChartData.dart';
import 'package:ratatouille23/models/UtentiChartData.dart';
import 'package:ratatouille23/views/custom_widget/barra_superiore.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../controllers/Statistiche_controller.dart';
import '../models/Utente.dart';
import 'custom_widget/finestra_nessun_elemento.dart';

class statistiche extends StatefulWidget {
  final Utente utente;

  const statistiche({super.key, required this.utente});

  @override
  statistiche_ui createState() => statistiche_ui();
}

class statistiche_ui extends State<statistiche> {
  List<ElementoVendutoChartData> listaElementi = <ElementoVendutoChartData>[];
  Statistiche_controller statistiche_controller = Statistiche_controller();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: statistiche_controller.prepareAndGetElementData(widget.utente),
        builder: (BuildContext context, snapshot) {
          Widget widgetDaTornare;
          if (snapshot.connectionState == ConnectionState.done) {
            if(snapshot.data != null) {
              listaElementi = snapshot.data!;
            }
            if(statistiche_controller.listaOrdinazioni.isNotEmpty) {

            }
            widgetDaTornare = Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const barra_superiore(text: ""),
                  const SizedBox(height: 20,),
                  (statistiche_controller.listaOrdinazioni.isNotEmpty) ?
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Card(
                                  color: Colors.white,
                                  elevation: 24.0,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(33.0))),
                                  child: SfCartesianChart(
                                    title: ChartTitle(
                                        text: 'Pietanze che hanno fatto guadagnare di più',
                                        borderWidth: 2,
                                        alignment: ChartAlignment.center,
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Roboto',
                                          fontStyle: FontStyle.italic,
                                          fontSize: 14,
                                        )
                                    ),
                                    primaryXAxis: CategoryAxis(
                                      autoScrollingDelta: 7,
                                      autoScrollingMode: AutoScrollingMode.start
                                    ),
                                    zoomPanBehavior: ZoomPanBehavior(
                                      enablePanning: true,
                                    ),
                                    primaryYAxis: NumericAxis(
                                      numberFormat: NumberFormat.simpleCurrency()
                                    ),
                                    series: <ChartSeries>[
                                      ColumnSeries<ElementoVendutoChartData, String>(
                                          dataSource: listaElementi,
                                          xValueMapper:
                                              (ElementoVendutoChartData elementi, _) =>
                                          elementi.nomeElemento,
                                          yValueMapper:
                                              (ElementoVendutoChartData elementi, _) =>
                                          elementi.guadagno,
                                          dataLabelSettings:
                                          const DataLabelSettings(isVisible: true))
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Card(
                                  color: Colors.white,
                                  elevation: 24.0,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(33.0))),
                                  child: SfCircularChart(
                                    legend: const Legend(isVisible: true),
                                    title: ChartTitle(
                                        text: 'Pietanze più vendute',
                                        borderWidth: 2,
                                        alignment: ChartAlignment.center,
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Roboto',
                                          fontStyle: FontStyle.italic,
                                          fontSize: 14,
                                        )
                                    ),
                                    series: <CircularSeries>[
                                      PieSeries<ElementoVendutoChartData, String>(
                                          dataSource: listaElementi,
                                          xValueMapper: (ElementoVendutoChartData elementi, _) => elementi.nomeElemento,
                                          yValueMapper: (ElementoVendutoChartData elementi, _) => elementi.numeroVendite,
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
                          Row(
                            children: [
                              Expanded(
                                child: Card(
                                  color: Colors.white,
                                  elevation: 24.0,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(33.0))),
                                  child: SfCartesianChart(
                                    title: ChartTitle(
                                        text: 'Ordinazioni registrate dagli addetti alla sala (Ordinazioni già evase)',
                                        borderWidth: 2,
                                        alignment: ChartAlignment.center,
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Roboto',
                                          fontStyle: FontStyle.italic,
                                          fontSize: 14,
                                        )
                                    ),
                                    primaryXAxis: CategoryAxis(),
                                    series: <ChartSeries>[
                                      BarSeries<AddettoAllaSalaChartData, String>(
                                          dataSource: statistiche_controller.addettoData,
                                          xValueMapper: (AddettoAllaSalaChartData addetto, _) => addetto.toString(),
                                          yValueMapper: (AddettoAllaSalaChartData addetto, _) => addetto.ordinazioniRegistrate,
                                          dataLabelSettings: const DataLabelSettings(isVisible: true),
                                          color: Colors.orangeAccent
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Card(
                                  color: Colors.white,
                                  elevation: 24.0,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(33.0))),
                                  child: SfCartesianChart(
                                    title: ChartTitle(
                                        text: 'Ordinazioni evase dagli addetti alla cucina',
                                        borderWidth: 2,
                                        alignment: ChartAlignment.center,
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Roboto',
                                          fontStyle: FontStyle.italic,
                                          fontSize: 14,
                                        )
                                    ),
                                    primaryXAxis: CategoryAxis(),
                                    series: <ChartSeries>[
                                      BarSeries<GestoreOrdinazioneChartData, String>(
                                          dataSource: statistiche_controller.gestoreData,
                                          xValueMapper: (GestoreOrdinazioneChartData gestore, _) => gestore.toString(),
                                          yValueMapper: (GestoreOrdinazioneChartData gestore, _) => gestore.ordinazioniEvase,
                                          dataLabelSettings: const DataLabelSettings(isVisible: true),
                                          color: Colors.deepOrangeAccent
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Card(
                            color: Colors.white,
                            elevation: 24.0,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(33.0))),
                            child: SfCartesianChart(
                              title: ChartTitle(
                                  text: 'Guadagni mensili',
                                  borderWidth: 2,
                                  alignment: ChartAlignment.center,
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontStyle: FontStyle.italic,
                                    fontSize: 14,
                                  )
                              ),
                              primaryXAxis: DateTimeAxis(
                                intervalType: DateTimeIntervalType.months,
                                autoScrollingMode: AutoScrollingMode.start,
                                autoScrollingDelta: 4,
                                rangePadding: ChartRangePadding.additional,
                                minimum: statistiche_controller.guadagniData.first.data,
                                dateFormat: DateFormat.yMMM()
                              ),
                              zoomPanBehavior: ZoomPanBehavior(
                                enablePanning: true,
                              ),
                              primaryYAxis: NumericAxis(
                                  numberFormat: NumberFormat.simpleCurrency()
                              ),
                              series: <ChartSeries>[
                                LineSeries<TempoGuadagnoChartData, DateTime>(
                                    dataSource: statistiche_controller.guadagniData,
                                    xValueMapper: (TempoGuadagnoChartData guadagno, _) => guadagno.data,
                                    yValueMapper: (TempoGuadagnoChartData guadagno, _) => guadagno.guadagno,
                                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ) : const finestra_nessun_elemento(
                      string1: 'NESSUNA ORDINAZIONE',
                      string2: 'EVASA',
                      string3: 'EVADI ALMENO UN',
                      string4: 'ORDINAZIONE E TORNA QUI',
                      string5: ''),
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
