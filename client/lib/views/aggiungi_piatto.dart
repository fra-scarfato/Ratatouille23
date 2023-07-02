import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ratatouille23/controllers/Menu_controller.dart';
import 'package:ratatouille23/models/menu/Categoria.dart';
import 'package:ratatouille23/models/menu/Elemento.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:ratatouille23/views/custom_widget/Finestra_attesa.dart';
import 'package:ratatouille23/views/custom_widget/Finestra_conferma.dart';
import '../models/Utente.dart';
import 'custom_widget/Finestra_errore.dart';
import 'custom_widget/barra_superiore.dart';
import 'menu.dart';

class aggiungi_piatto extends StatefulWidget {
  final List<Categoria>? listaCategorie;
  final Utente utente;
  final Menu_controller menu_controller;

  const aggiungi_piatto({super.key, required this.listaCategorie, required this.utente, required this.menu_controller, });

  @override
  aggiungi_piatto_state createState() => aggiungi_piatto_state();
}

class aggiungi_piatto_state extends State<aggiungi_piatto> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController costoController = TextEditingController();
  TextEditingController descrizioneController = TextEditingController();
  TextEditingController allergeniController = TextEditingController();
  String nome = '';
  String costo = '';
  String descrizione = '';
  String allergeni = '';
  String categoria = '';
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
                                      color: CupertinoColors.systemGrey3,
                                      width: 5.0
                                  ),
                                  borderRadius: BorderRadius.circular(50)
                              ),
                              hintText: 'Inserisci il nome',
                            ),
                            onChanged: (text){
                              setState(() {
                                nome=text;
                              });
                            }
                        ),
                        onSuggestionSelected: (suggestion) {
                          this.nomeController.text = suggestion;
                          nome = this.nomeController.text;
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                              title: Text(suggestion));
                        },
                        suggestionsCallback: (String pattern) async {
                          return await OpenFoodAPIClient.getSuggestions(
                              TagType.INGREDIENTS,
                              input: pattern,
                              language: OpenFoodFactsLanguage.ITALIAN
                          );
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
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: borderSideColorCosto, width: 5.0),
                                borderRadius: BorderRadius.circular(50)),
                            hintText: 'Inserisci il costo dell\'elemento',
                            hintStyle: TextStyle(color: hintColorCosto)),
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
                          this.allergeniController.text = suggestion;
                          allergeni = this.allergeniController.text;
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                              title: Text(suggestion));
                        },
                        suggestionsCallback: (String pattern) async {
                          return await OpenFoodAPIClient.getSuggestions(TagType.ALLERGENS, input: pattern, language: OpenFoodFactsLanguage.ITALIAN);
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
                          if (nome == '' || costo == '' || categoria == '') {
                            if (nome == '') {
                              setState(() {
                                borderSideColorNome = Colors.red;
                                hintColorNome = Colors.red;
                              });
                            }
                            if (costo == '') {
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
                            var attesa = Finestra_attesa(context);
                            FToast toast = FToast();
                            toast.init(context);
                            try{
                              Categoria? categoriaElemento = _menu_controller.trovaCategoriaElemento(categoria, widget.listaCategorie);
                              if(categoriaElemento != null){
                                double costoDouble = double.parse(costo);
                                Elemento elementoDaAggiungere = Elemento.senzaId(nome,descrizione,costoDouble,allergeni,categoriaElemento);
                                attesa.showDialogue();
                                await _menu_controller.aggiungiElemento(elementoDaAggiungere);
                                attesa.hideProgressDialogue();
                                Fluttertoast.cancel();
                                toast.showToast(
                                    child: Finestra_conferma(message: "Elemento aggiunto correttamente"),
                                    toastDuration: Duration(seconds: 2),
                                    gravity: ToastGravity.BOTTOM);
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => menu(utente: widget.utente,)),ModalRoute.withName("/pagina_iniziale"));
                              }
                            }catch (error){
                              attesa.hideProgressDialogue();
                              Fluttertoast.cancel();
                              toast.showToast(
                                  child: Finestra_errore(message: "Errore nell'aggiunta dell'elemento"),
                                  toastDuration: Duration(seconds: 2),
                                  gravity: ToastGravity.BOTTOM);
                           }
                          }

                        },
                        child: Text(
                          'AGGIUNGI PIATTO',
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

}
