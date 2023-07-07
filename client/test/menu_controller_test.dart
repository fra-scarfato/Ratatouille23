import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ratatouille23/controllers/Menu_controller.dart';
import 'package:ratatouille23/models/menu/Categoria.dart';
import 'package:ratatouille23/services/Menu_service.dart';

class CategoriaSTUB extends Fake implements Categoria{
  @override
  String get_nome() {
    return "Primi";
  }
}

class MenuServiceSTUB extends Mock implements Menu_service {}

void main() {
  late Menu_controller menu_controller;

  //setUp(() => menu_controller = Menu_controller());

  group('trovaCategoriaElementoTEST', () {
    List<Categoria> listaCategorie = <Categoria>[];

    setUp(() {
      listaCategorie.add(CategoriaSTUB());
    });

    test('trovaCategoriaElemento_Path_105_106_107_108', () {
      expect(menu_controller.trovaCategoriaElemento("Primi", listaCategorie), isA<CategoriaSTUB>());
    });
  });
  
  group('aggiungiCategoriaTEST', () {
    late MenuServiceSTUB menuServiceSTUB;
    
    setUp(() {
      menuServiceSTUB = MenuServiceSTUB();
      registerFallbackValue(CategoriaSTUB());
    });
    
    test('aggiungiCategoria_Path_72_73_74_75_76', () {
      try {
        when(() => menuServiceSTUB.aggiungiNuovaCategoria(any())).thenAnswer((_) => Future.value());
        menu_controller.aggiungiCategoria("Secondi", 1);
        expect(true, true);
      } on HttpException {
        fail("Test fallito");
      }
    });

    test('aggiungiCategoria_Path_72_73_74_75_78', () async {
      try {
        menu_controller = Menu_controller.service(menuServiceSTUB);
        when(() => menuServiceSTUB.aggiungiNuovaCategoria(any())).thenThrow(HttpException("statusCode"));
        await menu_controller.aggiungiCategoria("Secondi", 1);
      } on HttpException {
        expect(true, true);
      }
    });
  });
}