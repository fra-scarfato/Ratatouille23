import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ratatouille23/views/menu_vuoto.dart';

class bottoni_menu_admin extends StatelessWidget{
  final Widget route;
  final IconData icon;
  const bottoni_menu_admin({required this.route, required this.icon});

  Widget build(BuildContext context){

    return ElevatedButton(

      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => route));

      },

      style: ElevatedButton.styleFrom(
        shape: StadiumBorder(),
        backgroundColor: Colors.orange,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 60,
      ),


    );
  }
}