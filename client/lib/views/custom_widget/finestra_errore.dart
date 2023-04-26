import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Finestra_errore extends StatefulWidget{
  @override
  Finestra_errore_ui createState() => Finestra_errore_ui();
}

class Finestra_errore_ui extends State<Finestra_errore>{
  @override
  Widget build(BuildContext context) {
    return showDialog(context: context, builder: builder)
  }

}