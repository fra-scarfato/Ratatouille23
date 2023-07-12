import 'dart:convert';

import 'package:ratatouille23/models/menu/Categoria.dart';
import 'package:http/http.dart' as http;
import 'package:ratatouille23/models/menu/Elemento.dart';

import '../constants.dart';

class Menu_service {
  APIConstants apiConstants = APIConstants();

  Future<List<Categoria>> getCategorie(int id_ristorante) async {
    final queryParameter = {'idr': id_ristorante.toString()};
    final uri = Uri.http(apiConstants.baseURL, '/menu/get', queryParameter);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      List<Categoria> listaCategorie = (jsonDecode(utf8.decode(response.bodyBytes)) as List)
          .map((categoria) => Categoria.fromJson(categoria))
          .toList();
      return listaCategorie;
    } else {
      throw (response.statusCode);
    }
  }

  Future<void> aggiungiNuovaCategoria(Categoria categoria) async {
    final uri = Uri.http(apiConstants.baseURL, '/menu/category/add');
    var response = await http.post(
      uri,
      headers: apiConstants.header,
      body: jsonEncode(categoria.toJsonSenzaId()),
    );
    if (response.statusCode != 200) {
      throw (response.statusCode);
    }
  }

  Future<void> aggiungiNuovoElemento(Elemento elemento) async {
    final uri = Uri.http(apiConstants.baseURL, '/menu/element/add');
    var response = await http.post(
      uri,
      headers: apiConstants.header,
      body: jsonEncode(elemento.toJsonSenzaId()),
    );
    if (response.statusCode != 200) {
      throw (response.statusCode);
    }
  }

  Future<void> aggiornaVecchioElemento(Elemento elemento) async {
    final uri = Uri.http(apiConstants.baseURL, '/menu/element/update');
    var response = await http.put(
      uri,
      headers: apiConstants.header,
      body: jsonEncode(elemento.toJson()),
    );
    if (response.statusCode != 200) {
      throw (response.statusCode);
    }
  }

  Future<void> eliminaCategoria(Categoria categoriaDaEliminare) async {
    final uri = Uri.http(apiConstants.baseURL, '/menu/category/delete');
    var response = await http.delete(
      uri,
      headers: apiConstants.header,
      body: jsonEncode(categoriaDaEliminare.toJson()),
    );
    if (response.statusCode != 200) {
      throw (response.statusCode);
    }
  }

  Future<void> eliminaElemento(Elemento elementoDaEliminare) async {
    final uri = Uri.http(apiConstants.baseURL, '/menu/element/delete');
    var response = await http.delete(
      uri,
      headers: apiConstants.header,
      body: jsonEncode(elementoDaEliminare.toJsonSenzaCategoria()),
    );
    if (response.statusCode != 200) {
      throw (response.statusCode);
    }
  }
}
