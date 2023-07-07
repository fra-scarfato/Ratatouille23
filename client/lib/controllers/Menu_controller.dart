import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:ratatouille23/services/Menu_service.dart';
import 'package:translator/translator.dart';

import '../models/menu/Categoria.dart';
import '../models/menu/Elemento.dart';


class Menu_controller extends ChangeNotifier{
  late Menu_service _menu_service;
  List<Categoria> _listaCategorie = <Categoria>[];
  String nomePerTraduzione = "";
  String descrizionePerTraduzione = "";
  String allergeniPerTraduzione = "";

  Categoria selected = Categoria.vuota();

  Menu_service get menu_service => _menu_service;

  Menu_controller() {
    _menu_service = Menu_service();
  }

  Menu_controller.service(this._menu_service);

  String getNomePerTraduzione() {
    return nomePerTraduzione;
  }

  String getDescrizionePerTraduzione() {
    return descrizionePerTraduzione;
  }

  String getAllergeniPerTraduzione() {
    return allergeniPerTraduzione;
  }

  void setNomePerTraduzione(String nome) {
    nomePerTraduzione = nome;
  }

  void setDescrizionePerTraduzione(String descrizione) {
    descrizionePerTraduzione = descrizione;
  }

  void setAllergeniPerTraduzione(String allergeni) {
    allergeniPerTraduzione = allergeni;
  }

  List<Categoria> getCategorieDaVisualizzare() {
    return _listaCategorie;
  }

  Future<void> traduciInInglese(Elemento elemento) async {
    GoogleTranslator translator = GoogleTranslator();
    Translation nomeTradotto = await translator.translate(elemento.nome, from: 'it', to: 'en');
    Translation descrizioneTradotto = await translator.translate(elemento.descrizione, from: 'it', to: 'en');
    Translation allergeniTradotto = await translator.translate(elemento.allergeni, from: 'it', to: 'en');
    nomePerTraduzione = nomeTradotto.toString();
    descrizionePerTraduzione = descrizioneTradotto.toString();
    allergeniPerTraduzione = allergeniTradotto.toString();
    notifyListeners();
  }

  void traduciInItaliano(Elemento elemento) {
    nomePerTraduzione = elemento.nome;
    descrizionePerTraduzione = elemento.descrizione;
    allergeniPerTraduzione = elemento.allergeni;
    notifyListeners();
  }

  Future<void> aggiungiCategoria(String nome, int idRistorante) async {
    try{
      var categoriaDaAggiungere = Categoria.senzaIdAndElementi(nome, idRistorante);
      _listaCategorie.add(categoriaDaAggiungere);
      await _menu_service.aggiungiNuovaCategoria(categoriaDaAggiungere);
      notifyListeners();
    } on HttpException {
      rethrow;
    }
  }

  Future<void> rimuoviCategoria(Categoria categoriaDaRimuovere) async{
    try{
      _listaCategorie.removeWhere((categoria) => categoria.get_id() == categoriaDaRimuovere.get_id());
      await _menu_service.eliminaCategoria(categoriaDaRimuovere);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<List<Categoria>?> getAllCategorie(int idRistornate) async {
    try{
      _listaCategorie = await _menu_service.getCategorie(idRistornate);
      return _listaCategorie;
    } catch (error) {
      rethrow;
    }
  }

  List<String> getCategorieAsString(List<Categoria>? listaCategorie) {
    List<String> listaCategorieAsString = [];
    if(listaCategorie!.isNotEmpty) {
      for (var categoria in listaCategorie) {
        listaCategorieAsString.add(categoria.get_nome());
      }
    }
    return listaCategorieAsString;
  }

  Categoria trovaCategoriaElemento(String nomeCategoria, List<Categoria>? listaCategorie){
    int i=0;
    while(listaCategorie?[i].get_nome() != nomeCategoria) {
      i=i+1;
    }
    return listaCategorie![i];
  }

  Future<void> aggiungiElemento(Elemento elementoDaAggiungere) async {
    try{
      await _menu_service.aggiungiNuovoElemento(elementoDaAggiungere);
      for (var categoria in _listaCategorie) {
        if(categoria.get_id() == elementoDaAggiungere.categoria.get_id()) {
          categoria.get_elementi()?.add(elementoDaAggiungere);
        }
      }
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> rimuoviElemento(Elemento elementoDaRimuovere) async{
    try{
      await _menu_service.eliminaElemento(elementoDaRimuovere);
      elementoDaRimuovere.categoria = get_selected();
      for (var categoria in _listaCategorie) {
        if(categoria.get_id() == elementoDaRimuovere.categoria.get_id()) {
          int? index = categoria.get_elementi()?.indexWhere((element) => element.id == elementoDaRimuovere.id);
          categoria.get_elementi()?.removeAt(index!);
        }
      }
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> modificaElemento(Elemento elementoDaAggiornare) async {
    try{
      await _menu_service.aggiornaVecchioElemento(elementoDaAggiornare);
    } catch (error) {
      rethrow;
    }
  }

  Categoria get_selected() {return selected;}

  void set_selected(Categoria categoriaSelezionata) {selected = categoriaSelezionata; notifyListeners();}




}