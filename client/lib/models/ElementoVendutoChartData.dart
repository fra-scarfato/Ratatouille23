class ElementoVendutoChartData {
  late String _nomeElemento;
  late int _numeroVendite;
  late double _guadagno;
  late int _id_elemento;

  ElementoVendutoChartData(this._nomeElemento, this._id_elemento, this._numeroVendite, this._guadagno);


  int get id_elemento => _id_elemento;

  set id_elemento(int value) {
    _id_elemento = value;
  }

  double get guadagno => _guadagno;

  set guadagno(double value) {
    _guadagno = value;
  }

  int get numeroVendite => _numeroVendite;

  set numeroVendite(int value) {
    _numeroVendite = value;
  }

  String get nomeElemento => _nomeElemento;

  set nomeElemento(String value) {
    _nomeElemento = value;
  }
}