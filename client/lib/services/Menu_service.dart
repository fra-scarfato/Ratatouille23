import 'dart:convert';

import 'package:ratatouille23/models/menu/Categoria.dart';
import 'package:http/http.dart' as http;
import 'package:ratatouille23/models/menu/Elemento.dart';

class Menu_service{

  Future<List<Categoria>> elenco_categorie() async {
    var response= await http.get(Uri.parse(''));
    if(response.statusCode==200){
      List<Categoria> categorie=[];
      List cat= json.decode(response.body);
      cat.map((c) => categorie.add(Categoria.fromJson(c))).toList();
      return categorie;
    }
    else{
      throw('error');
    }
  }

  Future<List<Elemento>> elenco_elementi() async {
    var response= await http.get(Uri.parse(''));
    if(response.statusCode==200){
      List<Elemento> elementi=[];
      List elem= json.decode(response.body);
      elem.map((e) => elementi.add(Elemento.fromJson(e))).toList();
      return elementi;
    }
    else{
      throw('error');
    }
  }

  Future<http.Response> aggiungi_nuova_categoria(Categoria categoria) async {
    return http.post(
        Uri.parse(''),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: categoria.toJson()
    );
  }

  Future<http.Response> aggiungi_nuovo_elemento(Elemento elemento) async {
    return http.post(
        Uri.parse(''),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: elemento.toJson()
    );
  }

  Future<http.Response> modifica_elemento(Elemento elemento) async{
    return http.put(
        Uri.parse(''),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: elemento.toJson()
    );
  }

  Future<http.Response> elimina_categoria(Categoria categoria) async {
    return http.delete(
        Uri.parse(''),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: categoria.toJson()
    );
  }

  Future<http.Response> elimina_elemento(Elemento elemento) async {
    return http.delete(
        Uri.parse(''),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: elemento.toJson()
    );
  }

/*
  Future<void> inserisci_categoria(Map<String, dynamic> categoria) async {
    _menu.add(categoria);

    //TODO...
  }

  Future<void> rimuovi_categoria(int id) async {
    _menu.removeWhere((element) => element['id']==id);
  }

  Future<List<Map<String, dynamic>>> elenco_categorie() async {
    await Future.delayed(Duration(milliseconds: 800));
    return _menu;
  }

  Future<Map<String, dynamic>?> trova_categoria(int id) async {
    return _menu.firstWhere((elemento) => elemento['id'] == id);
  }

  Future<void> inserisci_elemento(int id, Map<String, dynamic> elemento) async {
    _elementi.add(elemento);

    //TODO...
  }

  Future<void> rimuovi_elemento(int id) async {
    _elementi.removeWhere((element) => element['id']==id);
  }

  Future<List<Map<String, dynamic>>> elenco_elementi() async {
    await Future.delayed(Duration(milliseconds: 800));
    return _elementi;
  }

  Future<List<Map<String, dynamic>>> get_elementi_categoria(int id) async{
    await Future.delayed(Duration(milliseconds: 800));
    int i= _menu.indexWhere((categoria) => categoria['id']==id);
    return _menu[i]['elementi'];

  }

  Future<void> inserisci_elemento(int id_categoria, Map<String, dynamic> elemento)async{
    int i= _menu.indexWhere((element) => element['id']==id_categoria);
    List<Map<String, dynamic>> _elementi= _menu[i]['elementi'];
    _elementi.add(elemento);
    //TODO...
  }

  Future<void> rimuovi_elemento(int id_categoria, int id_elemento) async {
    var _elementi= get_elementi_categoria(id_categoria) as List;
    _elementi.removeWhere((element) => element['id']==id_elemento);
    //TODO...

  }

  Future<void> modifica_elemento(int id_categoria, int id_elemento, Map<String, dynamic> elemento) async {
    var _elementi= get_elementi_categoria(id_categoria) as List;
    int i = _elementi.indexWhere((element) => element['id']==id_elemento);
    _elementi[i]=elemento;
  }
  */
}