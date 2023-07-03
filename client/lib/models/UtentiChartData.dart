class AddettoAllaSalaChartData{
  late int _idAddetto;
  late String _nomeAddettoAllaSala;
  late final String _cognomeAddettoAllaSala;
  late int _ordinazioniRegistrate;


  AddettoAllaSalaChartData(
      this._idAddetto, this._nomeAddettoAllaSala, this._cognomeAddettoAllaSala, this._ordinazioniRegistrate);

  int get idAddetto => _idAddetto;

  set idAddetto(int value) {
    _idAddetto = value;
  }

  String get nomeAddettoAllaSala => _nomeAddettoAllaSala;

  int get ordinazioniRegistrate => _ordinazioniRegistrate;

  set ordinazioniRegistrate(int value) {
    _ordinazioniRegistrate = value;
  }

  set nomeAddettoAllaSala(String value) {
    _nomeAddettoAllaSala = value;
  }

  @override
  String toString() {
    return 'ID: $_idAddetto $_nomeAddettoAllaSala $_cognomeAddettoAllaSala';
  }
}

class GestoreOrdinazioneChartData{
  late int _idGestore;
  late String _nomeGestoreOrdinazione;
  late final String _cognomeGestoreOrdinazione;
  late int _ordinazioniEvase;

  GestoreOrdinazioneChartData(
      this._idGestore, this._nomeGestoreOrdinazione, this._cognomeGestoreOrdinazione, this._ordinazioniEvase);

  int get ordinazioniEvase => _ordinazioniEvase;

  set ordinazioniEvase(int value) {
    _ordinazioniEvase = value;
  }

  String get nomeGestoreOrdinazione => _nomeGestoreOrdinazione;

  set nomeGestoreOrdinazione(String value) {
    _nomeGestoreOrdinazione = value;
  }

  int get idGestore => _idGestore;

  set idGestore(int value) {
    _idGestore = value;
  }

  @override
  String toString() {
    return 'ID: $_idGestore $_nomeGestoreOrdinazione $_cognomeGestoreOrdinazione';
  }
}