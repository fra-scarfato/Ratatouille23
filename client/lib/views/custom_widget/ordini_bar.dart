import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/Ordinazione_controller.dart';

class bottoneOrdini extends StatefulWidget {
  const bottoneOrdini({
    super.key,
    required this.ordinazione_controller,
  });

  final Ordinazione_controller ordinazione_controller;

  @override
  State<StatefulWidget> createState() => new OrdiniBar();
}

class OrdiniBar extends State<bottoneOrdini> {
  List<bool> list = [false, false];

  @override
  void initState() {
    list[0]=true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Expanded(
          child: ListTile(
            tileColor: Colors.yellow.shade200,
            selectedTileColor: Colors.yellow,
            selectedColor: Colors.black,
            selected: list[0],
            onTap: () {
              widget.ordinazione_controller.showOrdinazioniInAttesa();
              setState(() {
                list[0] = true;
                list[1] = false;
              });
            },
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(30)),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Ordini in attesa',
                  style: GoogleFonts.roboto(
                      fontSize: 24, fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
        ),
        Expanded(
            child: ListTile(
              tileColor: Colors.yellow.shade200,
              selectedTileColor: Colors.yellow,
              selectedColor: Colors.black,
              selected: list[1],
              onTap: () {
                widget.ordinazione_controller.showOrdinazioniPreseInCarico();
                setState(() {
                  list[0] = false;
                  list[1] = true;
                });
              },
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(30)),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Ordini presi in carica',
                    style: GoogleFonts.roboto(
                        fontSize: 24, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ))
      ],
    );
  }
}