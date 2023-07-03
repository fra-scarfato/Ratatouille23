class TempoGuadagnoChartData{
  DateTime _data;
  double _guadagno;

  TempoGuadagnoChartData(this._data, this._guadagno);

  double get guadagno => _guadagno;

  set guadagno(double value) {
    _guadagno = value;
  }

  DateTime get data => _data;

  set data(DateTime value) {
    _data = value;
  }
}