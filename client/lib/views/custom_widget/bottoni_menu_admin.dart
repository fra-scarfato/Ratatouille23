import 'package:flutter/material.dart';

class bottoni_menu_admin extends StatelessWidget{
  final Widget route;
  final IconData icon;
  const bottoni_menu_admin({super.key, required this.route, required this.icon});

  @override
  Widget build(BuildContext context){

    return ElevatedButton(

      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => route));

      },

      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
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