import 'dart:convert';

import 'package:ratatouille23/models/menu/Categoria.dart';
import 'package:http/http.dart' as http;
import 'package:ratatouille23/models/menu/Elemento.dart';

class Menu_service {
  final String authority = "localhost:8080";
  final header = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Access-Control-Allow-Origin': '*',
  };

  Future<List<Categoria>> getCategorie(int id_ristorante) async {
    final queryParameter = {'idr': id_ristorante.toString()};
    final uri = Uri.http(authority, '/menu/get', queryParameter);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      List<Categoria> listaCategorie = (jsonDecode(response.body) as List)
          .map((categoria) => Categoria.fromJson(categoria))
          .toList();
      return listaCategorie;
    } else {
      throw (response.statusCode);
    }
  }

  void aggiungiNuovaCategoria(Categoria categoria) async {
    final uri = Uri.http(authority, '/menu/category/add');
    var response = await http.post(
      uri,
      headers: header,
      body: jsonEncode(categoria.toJsonSenzaId()),
    );
    if (response.statusCode != 200) {
      throw (response.statusCode);
    }
  }

  void aggiungiNuovoElemento(Elemento elemento) async {
    final uri = Uri.http(authority, '/menu/element/add');
    var response = await http.post(
      uri,
      headers: header,
      body: jsonEncode(elemento.toJsonSenzaId()),
    );
    if (response.statusCode != 200) {
      throw (response.statusCode);
    }
  }

  void aggiornaVecchioElemento(Elemento elemento) async {
    final uri = Uri.http(authority, '/menu/element/update');
    var response = await http.put(
      uri,
      headers: header,
      body: jsonEncode(elemento.toJsonSenzaId()),
    );
    if (response.statusCode != 200) {
      throw (response.statusCode);
    }
  }

  void eliminaCategoria(Categoria categoriaDaEliminare) async {
    final uri = Uri.http(authority, '/menu/category/delete');
    var response = await http.delete(
      uri,
      headers: header,
      body: jsonEncode(categoriaDaEliminare.toJsonSenzaId()),
    );
    if (response.statusCode != 200) {
      throw (response.statusCode);
    }
  }

  void eliminaElemento(Elemento elementoDaEliminare) async {
    final uri = Uri.http(authority, '/menu/element/delete');
    var response = await http.delete(
      uri,
      headers: header,
      body: jsonEncode(elementoDaEliminare.toJsonSenzaCategoria()),
    );
    if (response.statusCode != 200) {
      throw (response.statusCode);
    }
  }
}
