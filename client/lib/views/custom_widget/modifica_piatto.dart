import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:ratatouille23/controllers/Menu_controller.dart';
import 'package:ratatouille23/models/menu/Categoria.dart';
import 'package:ratatouille23/models/menu/Elemento.dart';
import 'package:ratatouille23/views/custom_widget/Finestra_attesa.dart';

import '../../models/Utente.dart';
import '../menu.dart';
import 'Finestra_conferma.dart';
import 'Finestra_errore.dart';
import 'barra_superiore.dart';

class modifica_piatto extends StatefulWidget {
  final List<Categoria>? listaCategorie;
  final Utente utente;
  final Elemento elemento;


  const modifica_piatto({super.key, required this.listaCategorie, required this.utente, required this.elemento });

  @override
  modifica_piatto_state createState() => modifica_piatto_state();
}

class modifica_piatto_state extends State<modifica_piatto> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController costoController = TextEditingController();
  TextEditingController descrizioneController = TextEditingController();
  TextEditingController allergeniController = TextEditingController();
  String nome = '';
  String costo = '';
  String descrizione = '';
  String allergeni = '';
  String categoria = '';

  initState(){
    super.initState();
    nome = nomeController.text = widget.elemento.nome;
    costo = costoController.text = widget.elemento.costo.toString();
    descrizione = descrizioneController.text = widget.elemento.descrizione;
    allergeni = allergeniController.text = widget.elemento.allergeni;
  }

  List<String> items = []; //List<Categoria>
  String? selectedItem = 'Seleziona la categoria';
  Menu_controller _menu_controller = new Menu_controller();

  Color borderSideColorNome = CupertinoColors.systemGrey3;
  Color borderSideColorCosto = CupertinoColors.systemGrey3;
  Color borderSideColorCategoria = CupertinoColors.systemGrey3;
  Color hintColorNome = CupertinoColors.systemGrey3;
  Color hintColorCosto = CupertinoColors.systemGrey3;
  Color hintColorCategoria = CupertinoColors.systemGrey3;


  @override
  Widget build(BuildContext context) {
    items = _menu_controller.getCategorieAsString(widget.listaCategorie);
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,

        body:Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            barra_superiore(
              text: '',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 30,
                ),
                Column(
                  children: [
                    Text(
                      'Nome',
                      style: GoogleFonts.roboto(
                          fontSize: 44, color: Colors.orange),
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
                Spacer(),
                SizedBox(
                  width: 900,
                  height: 91,
                  child: TypeAheadFormField(
                    textFieldConfiguration: TextFieldConfiguration(
                        controller: nomeController,
                        keyboardType: TextInputType.name,
                        enableSuggestions: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: borderSideColorNome,
                                  width: 5.0
                              ),
                              borderRadius: BorderRadius.circular(50)
                          ),
                          hintText: 'Inserisci il nome',
                          hintStyle: TextStyle(color: hintColorNome),
                        ),
                        onChanged: (text){
                          setState(() {
                            nome=text;
                          });
                        }
                    ),
                    onSuggestionSelected: (suggestion) {
                      this.nomeController.text = suggestion;
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                          title: Text(suggestion));
                    },
                    suggestionsCallback: (String pattern) async {
                      return await OpenFoodAPIClient.getSuggestions(TagType.INGREDIENTS, input: pattern, language: OpenFoodFactsLanguage.ITALIAN);
                    },),
                ),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 30,
                ),
                Column(
                  children: [
                    Text(
                      'Costo',
                      style: GoogleFonts.roboto(
                          fontSize: 44, color: Colors.orange),
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
                Spacer(),
                SizedBox(
                  width: 900,
                  height: 91,
                  child: TextFormField(
                    controller: costoController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: borderSideColorCosto, width: 5.0),
                            borderRadius: BorderRadius.circular(50)),
                        hintText: 'Inserisci il costo dell\'elemento',
                        hintStyle: TextStyle(color: hintColorCosto),),
                    onChanged: (text) {
                      setState(() {
                        costo = text;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 30,
                ),
                Column(
                  children: [
                    Text(
                      'Descrizione',
                      style: GoogleFonts.roboto(
                          fontSize: 44, color: Colors.orange),
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
                Spacer(),
                SizedBox(
                  width: 900,
                  height: 91,
                  child: TextFormField(
                    controller: descrizioneController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: CupertinoColors.systemGrey3,
                              width: 5.0),
                          borderRadius: BorderRadius.circular(50)),
                      hintText: 'Inserisci la descrizione dell\' elemento',
                    ),
                    onChanged: (text) {
                      setState(() {
                        descrizione = text;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 30,
                ),
                Column(
                  children: [
                    Text(
                      'Allergeni',
                      style: GoogleFonts.roboto(
                          fontSize: 44, color: Colors.orange),
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
                Spacer(),
                SizedBox(
                  width: 900,
                  height: 91,
                  child: TypeAheadFormField(
                    textFieldConfiguration: TextFieldConfiguration(
                        controller: allergeniController,
                        keyboardType: TextInputType.name,
                        enableSuggestions: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: CupertinoColors.systemGrey3,
                                  width: 5.0
                              ),
                              borderRadius: BorderRadius.circular(50)
                          ),
                          hintText: 'Inserisci gli allergeni',
                        ),
                        onChanged: (text){
                          setState(() {
                            allergeni=text;
                          });
                        }
                    ),
                    onSuggestionSelected: (suggestion) {
                      allergeniController.text = suggestion;
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                          title: Text(suggestion));
                    },
                    suggestionsCallback: (String pattern) async {
                      return await OpenFoodAPIClient.getSuggestions(TagType.ALLERGENS, input: pattern, language: OpenFoodFactsLanguage.ITALIAN);
                    },)
                ),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 30,
                ),
                Text('Categoria',
                    style: GoogleFonts.roboto(
                        fontSize: 44, color: Colors.orange)),
                Spacer(),
                Container(
                  width: 900,
                  height: 61,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                          color: borderSideColorCategoria, width: 1)),
                  padding: EdgeInsets.only(left: 7.0, right: 4.0, top: 3.0),
                  child: DropDown(
                    items: items,
                    hint: Text(
                      categoria,
                      style: TextStyle(color: hintColorCategoria),
                    ),
                    icon: Icon(
                      Icons.expand_more,
                      color: Colors.black,
                    ),
                    isExpanded: true,
                    onChanged: (text) {
                      setState(() {
                        categoria = text!;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      if (nome == '' || costo == '' || !isNumber(costo) || categoria == '') {
                        if (nome == '') {
                          setState(() {
                            borderSideColorNome = Colors.red;
                            hintColorNome = Colors.red;
                          });
                        }
                        if (costo == '' || !isNumber(costo)) {
                          setState(() {
                            borderSideColorCosto = Colors.red;
                            hintColorCosto = Colors.red;
                          });
                        }
                        if (categoria == '') {
                          setState(() {
                            borderSideColorCategoria = Colors.red;
                            hintColorCategoria = Colors.red;
                          });
                        }
                      } else {
                        FToast toast = FToast();
                        var attesa = Finestra_attesa(context);
                        try{
                          Categoria? categoriaElemento = _menu_controller.trovaCategoriaElemento(categoria, widget.listaCategorie);
                          if(categoriaElemento != null){
                            double costoDouble = double.parse(costo);
                            Elemento elementoDaAggiornare = Elemento(widget.elemento.id, nome,descrizione,costoDouble,allergeni,categoriaElemento);
                            attesa.showDialogue();
                            await _menu_controller.modificaElemento(elementoDaAggiornare);
                            attesa.hideProgressDialogue();
                            Fluttertoast.cancel();
                            toast.showToast(
                                child: Finestra_conferma(message: "Modifica completata"),
                                toastDuration: Duration(seconds: 2),
                                gravity: ToastGravity.BOTTOM);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => menu(utente: widget.utente,)));
                          }
                        }catch (error){
                          attesa.hideProgressDialogue();
                          Fluttertoast.cancel();
                          toast.showToast(
                              child: Finestra_errore(message: "Modifica non riuscita"),
                              toastDuration: Duration(seconds: 2),
                              gravity: ToastGravity.BOTTOM);
                        }
                      }

                    },
                    child: Text(
                      'MODIFICA PIATTO',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 20),
                    )),
              ],
            ),
            SizedBox(
              height: 2,
            )
          ],
        )
    );
  }

  bool isNumber(String costo) {
    return (int.tryParse(costo) != null) && (int.tryParse(costo)! > 0);
  }

}
