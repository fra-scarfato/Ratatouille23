import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ratatouille23/controllers/Utente_controller.dart';
import 'package:ratatouille23/models/Utente.dart';
import 'package:ratatouille23/services/Utente_service.dart';

class UtenteServiceSTUB extends Mock implements Utente_service {}
class UtenteSTUB extends Fake implements Utente{}


void main() {
  late Utente_controller utente_controller;
  late UtenteServiceSTUB utente_service_stub;

  setUp(() {
    utente_service_stub = UtenteServiceSTUB();
    utente_controller = Utente_controller(utente_service_stub);
  });

  group('aggiungiUtenteTEST', () {
    setUp(() {
      registerFallbackValue(UtenteSTUB());
    });

    test('testAggiungiUtente_Path_32_33_36', () async {
      try{
        await utente_controller.aggiungiUtente("12345", "Scarfato", "email", "ruolo", 1);
        fail("Test fallito");
      } on Exception {
        expect(true, true);
      }
    });


    test('testAggiungiUtente_Path_32_33_34', () async {
      try{
        when(() => utente_service_stub.aggiungi(any())).thenAnswer((_) => Future.value());
        await utente_controller.aggiungiUtente("Francesco", "Scarfato", "email", "ruolo", 1);
        expect(true, true);
      } on Exception {
        fail("Test fallito");
      }
    });

    test('testAggiungiUtente_Path_32_33_34_36', () async {
      try{
        //response.statusCode!=200
        when(() => utente_service_stub.aggiungi(any())).thenThrow(Exception());
        await utente_controller.aggiungiUtente("Francesco", "Scarfato", "email", "ruolo", 1);
      } on Exception {
        expect(true, true);
      }
    });
  });

}
