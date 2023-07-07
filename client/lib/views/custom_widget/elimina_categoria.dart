import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ratatouille23/views/custom_widget/barra_superiore.dart';

import '../../controllers/Menu_controller.dart';
import '../../models/Utente.dart';
import '../../models/menu/Categoria.dart';
import 'Finestra_conferma.dart';
import 'Finestra_errore.dart';

class Elimina_categoria extends StatefulWidget{
  final List<Categoria> listaCategorie;
  final Menu_controller menu_controller;
  final Utente utente;

  const Elimina_categoria({Key? key, required this.listaCategorie,required this.utente, required this.menu_controller}) : super(key : key);

  @override
  State<StatefulWidget> createState() => Elimina_categoria_ui();
}

class Elimina_categoria_ui extends State<Elimina_categoria> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const barra_superiore(text: ''),
          Column(
            children:
              createCard(),
          )
        ],
      ),
    );
  }

  List<Widget> createCard() {
    List<Widget> categorieCard;
    categorieCard = List.generate(widget.listaCategorie.length, (index) => categoria_card(menu_controller: widget.menu_controller, categoria: widget.listaCategorie[index]));
    return categorieCard;
  }

}

class categoria_card extends StatefulWidget {
  final Menu_controller menu_controller;
  final Categoria categoria;


  categoria_card({required this.menu_controller, required this.categoria});

  @override
  State<StatefulWidget> createState() => categoria_card_ui();
}

class categoria_card_ui extends State<categoria_card> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 24.0,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(33.0))),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Text(
              widget.categoria.get_nome(),
                style: GoogleFonts.roboto(
                    color: Colors.orange,
                    fontSize: 36,
                    fontStyle: FontStyle.italic)
            ),
            Spacer(),
            IconButton(onPressed: () async {
              FToast toast = FToast();
              toast.init(context);
              try{
                await widget.menu_controller.rimuoviCategoria(widget.categoria);
                toast.showToast(
                    child: const Finestra_conferma(message: "Elemento rimosso"),
                    toastDuration: const Duration(seconds: 2),
                    gravity: ToastGravity.BOTTOM);
                Navigator.popUntil(context, ModalRoute.withName("/menu"));
              } catch (error) {
                toast.showToast(
                    child: Finestra_errore(message: "Impossibile eliminare l'ordinazione.$error"),
                    toastDuration: const Duration(seconds: 2),
                    gravity: ToastGravity.BOTTOM);
              }
            },
              icon: Icon(Icons.delete_outline, color: Colors.red,), iconSize: 50,)
          ],
        ),
      ),
    );
  }

}