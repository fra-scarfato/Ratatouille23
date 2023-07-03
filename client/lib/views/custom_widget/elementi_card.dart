
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ratatouille23/controllers/Menu_controller.dart';
import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';

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

  elementi_card(
      {super.key, required this.utente,
      required this.elemento,
      required this.listaCategorie});

  @override
  elementi_card_state createState() => elementi_card_state();
}

class elementi_card_state extends State<elementi_card> {
  Menu_controller menu_controller = Menu_controller();

  @override
  void initState() {
    super.initState();
    menu_controller.setNomePerTraduzione(widget.elemento.nome);
    menu_controller.setDescrizionePerTraduzione(widget.elemento.descrizione);
    menu_controller.setAllergeniPerTraduzione(widget.elemento.allergeni);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: menu_controller,
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
                  //elementi_card_header(nome: widget.nome, costo: widget.costo),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        menu_controller.getNomePerTraduzione(),
                        style: GoogleFonts.roboto(
                            color: Colors.orange,
                            fontSize: 36,
                            fontStyle: FontStyle.italic),
                      ),
                      const Spacer(),
                      Text(
                        'Costo: ${widget.elemento.costo}\$',
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
                            size: 50,
                          )),
                      IconButton(
                          onPressed: () {
                            FToast toast = FToast();
                            toast.init(context);
                            try{
                              menu_controller.rimuoviElemento(widget.elemento);
                              toast.showToast(
                                  child: const Finestra_conferma(message: "Elemento rimosso"),
                                  toastDuration: const Duration(seconds: 2),
                                  gravity: ToastGravity.BOTTOM);
                            } catch (error) {
                              toast.showToast(
                                  child: const Finestra_errore(message: 'Impossibile rimuovere elemento'),
                                  toastDuration: const Duration(seconds: 2),
                                  gravity: ToastGravity.BOTTOM);
                            }
                          },
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                            size: 50,
                          )),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 1161,
                    child: Text(menu_controller.getDescrizionePerTraduzione(),
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
                          menu_controller.traduciInItaliano(widget.elemento);
                        },
                        child: Flag.fromCode(FlagsCode.IT, height: 30, width: 35),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () async {
                          await menu_controller.traduciInInglese(widget.elemento);
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
                                child: Text(menu_controller.getAllergeniPerTraduzione(),
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
