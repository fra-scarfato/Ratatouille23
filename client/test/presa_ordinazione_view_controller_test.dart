import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ratatouille23/controllers/Presa_ordinazione_view_controller.dart';
import 'package:ratatouille23/models/Elemento_ordinato.dart';
import 'package:ratatouille23/models/menu/Elemento.dart';

class ElementoSTUB extends Fake implements Elemento{
  int _id;

  ElementoSTUB(this._id);

  @override
  int get id => _id;
}

class ElementoOrdinatoSTUB extends Fake implements Elemento_ordinato{
  late int id;
  late int quantita;

  ElementoOrdinatoSTUB(int id) {
    this.id=id;
    quantita=0;
  }

  @override
  ElementoSTUB get_elemento() {
    return ElementoSTUB(id);
  }

  @override
  void set_quantita(int quantita) {
    this.quantita = quantita;
  }

  @override
  int get_quantita() {
    return quantita;
  }
}

void main(){
  late Presa_ordinazione_view_controller presa_ordinazione_view_controller;

  setUp(() => presa_ordinazione_view_controller = Presa_ordinazione_view_controller());

  group('set_quantitaTEST', () {
    setUp(() => presa_ordinazione_view_controller.set_list_elem_ord(<ElementoOrdinatoSTUB>[ElementoOrdinatoSTUB(0), ElementoOrdinatoSTUB(1)]));

    test('setQuantita_Path_38_39_', () {
      presa_ordinazione_view_controller.set_quantita(ElementoSTUB(1), 2);
      expect(presa_ordinazione_view_controller.list_elem_ord[1].get_quantita(), 2);
    });

  });

}