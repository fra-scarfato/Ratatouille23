import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ratatouille23/views/menu_vuoto.dart';
import 'bottoni_menu_admin.dart';

class slide_button extends StatelessWidget{

  final double vertical_offset;
  final double horizontal_offset;
  final String text;
  final Widget route;
  final IconData icon;
  const slide_button({required this.vertical_offset, required this.horizontal_offset, required this.text, required this.route, required this.icon});

  Widget build(BuildContext context){
    return  SlideAnimation(
        verticalOffset: vertical_offset,
        horizontalOffset: horizontal_offset,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[Text('$text', style: GoogleFonts.roboto(fontSize: 24,color: Colors.white),),
            SizedBox(height: 8),
            bottoni_menu_admin(route: route, icon: icon),] ,
        )
    );
  }
}