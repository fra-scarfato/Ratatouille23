import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class elementi_card_bottom extends StatefulWidget{
  final String allergeni;
  const elementi_card_bottom({Key? key, required this.allergeni}) : super(key: key);
  @override
  elementi_card_bottom_state createState() => elementi_card_bottom_state();
  }

class elementi_card_bottom_state extends State<elementi_card_bottom>{
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: (){},
          child: Flag.fromCode(FlagsCode.IT, height: 30, width: 35),
        ),
        SizedBox(width: 8),
        InkWell(
          onTap: (){},
          child: Flag.fromCode(FlagsCode.GB, height: 30, width: 35),
        ),
        //SizedBox(width: 451,),
        Spacer(),
        Container(
          width:1020,
          alignment: AlignmentDirectional.topEnd,
          child:Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('Elenco allergeni:',
                  style: GoogleFonts.roboto(fontSize: 27, fontStyle: FontStyle.italic, color: Colors.orange)
              ),
              Expanded(child: Text(
                  widget.allergeni,
                  // overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.roboto(fontSize: 27, fontStyle: FontStyle.italic)
              )
              )
            ],
          ),
        ),


      ],
    );
  }
}

