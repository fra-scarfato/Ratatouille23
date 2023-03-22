import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class finestra_nessun_elemento extends StatelessWidget{
  final String string1;
  final String string2;
  final String string3;
  final String string4;
  final String string5;
  const finestra_nessun_elemento({super.key, required this.string1, required this.string2, required this.string3, required this.string4, required this.string5});
  Widget build(BuildContext context){
    return SizedBox(
        width: 545,
        height: 390,
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(33.0)),
                color: Colors.white
            ),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('$string1', style: GoogleFonts.roboto(fontSize: 36, fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
                Text('$string2',style: GoogleFonts.roboto(fontSize: 36, fontStyle: FontStyle.italic,fontWeight: FontWeight.bold)),
                Divider(color: Colors.orange,),
                Text('$string3', style: GoogleFonts.roboto(fontSize: 36, fontStyle: FontStyle.italic,),),
                Text('$string4',style: GoogleFonts.roboto(fontSize: 36, fontStyle: FontStyle.italic)),
                Text('$string5',style: GoogleFonts.roboto(fontSize: 36, fontStyle: FontStyle.italic)),
              ],
            )
        )
    );
  }
}