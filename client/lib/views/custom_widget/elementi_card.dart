
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ratatouille23/controllers/Menu_controller.dart';
import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';
import 'package:translator/translator.dart';

import '../../models/Utente.dart';
import '../../models/menu/Categoria.dart';
import '../../models/menu/Elemento.dart';
import 'Finestra_conferma.dart';
import 'Finestra_errore.dart';
import 'modifica_piatto.dart';

class elementi_card extends StatefulWidget {
  final Key key = UniqueKey();
  final Utente utente;
  final Elemento elemento;
  final List<Categoria>? listaCategorie;
  final Menu_controller menu_controller;
  String nomeDaVisualizzare = "";
  String descrizioneDaVisualizzare = "";
  String allergeniDaVisualizzare = "";

  elementi_card(
      {super.key, required this.utente,
      required this.elemento,
      required this.listaCategorie,
      required this.menu_controller});

  @override
  elementi_card_ui createState() => elementi_card_ui();
}

class elementi_card_ui extends State<elementi_card> {

  @override
  void initState() {
    super.initState();
    widget.nomeDaVisualizzare = widget.elemento.nome;
    widget.descrizioneDaVisualizzare = widget.elemento.descrizione;
    widget.allergeniDaVisualizzare = widget.elemento.allergeni;
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: widget.menu_controller,
        builder: (context, child) {
          return Card(
            key: UniqueKey(),
            color: Colors.white,
            elevation: 24.0,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(33.0))),
            child: Padding(
              padding: const EdgeInsets.all(15), //apply padding to all four sides
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.nomeDaVisualizzare,
                        style: GoogleFonts.roboto(
                            color: Colors.orange,
                            fontSize: 36,
                            fontStyle: FontStyle.italic),
                      ),
                      const Spacer(),
                      Text(
                        'Costo: ${widget.elemento.costo}€',
                        style: GoogleFonts.roboto(
                            color: Colors.orange,
                            fontSize: 36,
                            fontStyle: FontStyle.italic),
                      ),
                      const SizedBox(
                        width: 170,
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => modifica_piatto(
                                        listaCategorie: widget.listaCategorie,
                                        utente: widget.utente,
                                        elemento: widget.elemento)));
                          },
                          icon: const Icon(
                            Icons.mode_edit_outlined,
                          ),iconSize: 50,),
                      IconButton(
                          onPressed: () async {
                            FToast toast = FToast();
                            toast.init(context);
                            try{
                              await widget.menu_controller.rimuoviElemento(widget.elemento);
                              toast.showToast(
                                  child: const Finestra_conferma(message: "Elemento rimosso"),
                                  toastDuration: const Duration(seconds: 2),
                                  gravity: ToastGravity.BOTTOM);
                            } catch (error) {
                              print(error.toString());
                              toast.showToast(
                                  child: const Finestra_errore(message: 'Impossibile rimuovere elemento'),
                                  toastDuration: const Duration(seconds: 2),
                                  gravity: ToastGravity.BOTTOM);
                            }
                          },
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ), iconSize: 50,),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 1161,
                    child: Text(widget.descrizioneDaVisualizzare,
                        style: GoogleFonts.roboto(
                            fontStyle: FontStyle.italic, fontSize: 27)),
                    //  )
                  ),
                  const SizedBox(height: 32),
                  // elementi_card_bottom(allergeni: widget.elemento.allergeni)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            widget.nomeDaVisualizzare = widget.elemento.nome;
                            widget.descrizioneDaVisualizzare = widget.elemento.descrizione;
                            widget.allergeniDaVisualizzare = widget.elemento.allergeni;
                          });
                        },
                        child: Flag.fromCode(FlagsCode.IT, height: 30, width: 35),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () async {
                          GoogleTranslator translator = GoogleTranslator();
                          Translation nomeTradotto = await translator.translate(widget.elemento.nome, from: 'it', to: 'en');
                          Translation descrizioneTradotto = await translator.translate(widget.elemento.descrizione, from: 'it', to: 'en');
                          Translation allergeniTradotto = await translator.translate(widget.elemento.allergeni, from: 'it', to: 'en');
                          setState(() {
                            widget.nomeDaVisualizzare = nomeTradotto.toString();
                            widget.descrizioneDaVisualizzare = descrizioneTradotto.toString();
                            widget.allergeniDaVisualizzare = allergeniTradotto.toString();
                          });
                        },
                        child: Flag.fromCode(FlagsCode.GB, height: 30, width: 35),
                      ),
                      //SizedBox(width: 451,),
                      const Spacer(),
                      Container(
                        width: 1020,
                        alignment: AlignmentDirectional.topEnd,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('Elenco allergeni:',
                                style: GoogleFonts.roboto(
                                    fontSize: 27,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.orange)),
                            Expanded(
                                child: Text( widget.allergeniDaVisualizzare,
                                    // overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.roboto(
                                        fontSize: 27, fontStyle: FontStyle.italic)))
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
    });

  }
}
