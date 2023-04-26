import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class categoria_card extends StatelessWidget {
  const categoria_card({
    Key? key,
    required this.nomeCategoria,
  }) : super(key: key);

  final String nomeCategoria;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.yellow,
      shape: StadiumBorder(side: BorderSide(width: 1, color: Colors.black)),
      child: Padding(
        padding: EdgeInsets.all(8), //apply padding to all four sides
        child: Text(
          nomeCategoria,
          style: GoogleFonts.roboto(fontSize: 34, fontStyle: FontStyle.italic),
        ),
      ),
    );
  }
}