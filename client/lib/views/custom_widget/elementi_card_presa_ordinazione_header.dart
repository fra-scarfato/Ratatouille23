import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/Presa_ordinazione_view_controller.dart';
import '../../models/Utente.dart';
import '../../models/menu/Elemento.dart';

class elementi_card_presa_ordinazione_header extends StatefulWidget {
  final String nome;
  final double costo;
  final Utente utente;
  final Elemento elemento;
  int quantita;
  final Presa_ordinazione_view_controller presa_ordinazione_view_controller;

  elementi_card_presa_ordinazione_header(
      {Key? key,
      required this.nome,
      required this.costo,
      required this.utente,
      required this.elemento,
      required this.presa_ordinazione_view_controller,
      required this.quantita})
      : super(key: key);
  @override
  elementi_card_presa_ordinazione_header_state createState() =>
      elementi_card_presa_ordinazione_header_state();
}

class elementi_card_presa_ordinazione_header_state
    extends State<elementi_card_presa_ordinazione_header> {
  @override
  Widget build(BuildContext context) {
    widget.presa_ordinazione_view_controller.set_quantita(widget.elemento, widget.quantita);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          widget.nome,
          style: GoogleFonts.roboto(
              color: Colors.orange, fontSize: 36, fontStyle: FontStyle.italic),
        ),
        const Spacer(),
        Text(
          'Costo: ${widget.costo}€',
          style: GoogleFonts.roboto(
              color: Colors.orange, fontSize: 36, fontStyle: FontStyle.italic),
        ),
        const SizedBox(
          width: 176,
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.remove_rounded,
                color: Colors.orangeAccent,
                size: 50,
              ),
              iconSize: 50,
              onPressed: () {
                if (widget.quantita > 0) {
                  setState(() {
                    widget.quantita--;
                  });
                  widget.presa_ordinazione_view_controller
                      .rimuovi_quantita(widget.elemento);
                }
              },
            ),
            ListenableBuilder(
                listenable: widget.presa_ordinazione_view_controller,
                builder: (context, child) {
                  widget.quantita = widget.presa_ordinazione_view_controller
                      .get_quantita(widget.elemento);
                  return Text(
                    '${widget.quantita}',
                    style: const TextStyle(fontSize: 50),
                  );
                }),
            IconButton(
              icon: const Icon(
                  Icons.add,
                  color: Colors.orangeAccent,
              ),
              iconSize: 50,
              onPressed: () {
                setState(() {
                  widget.quantita++;
                });
                widget.presa_ordinazione_view_controller
                    .aggiungi_quantita(widget.elemento);
              },
            ),
          ],
        )
      ],
    );
  }
}
