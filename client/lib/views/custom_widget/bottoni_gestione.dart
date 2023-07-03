import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class bottoni_gestione extends StatelessWidget{
  final Widget route;
  final String text;
  final String routeText;
  final Color color1;
  final Color color2;
  final IconData icon;
  const bottoni_gestione({super.key, required this.route, required this.routeText, required this.text, required this.color1, required this.color2, required this.icon});
  @override
  Widget build(BuildContext context){
    return InkWell(
        onTap: (){
          Navigator.push(context, createRoute(route, routeText));
        },
        child: Ink(
            height: (2*(MediaQuery.of(context).size.height))/5,
            width: (2*(MediaQuery.of(context).size.height))/5,
          // height: 350,
          // width: 350,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(33.0)),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                color1,
                color2
              ]
            ),
          ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: MediaQuery.of(context).size.height/4,
              // size: 225,
            ),
            Text(
              text,
              style: GoogleFonts.roboto(fontSize: /*40*/MediaQuery.of(context).size.height/25 ,fontStyle: FontStyle.italic)
            )
          ],
        )
        )
    );
  }

  Route createRoute(Widget page, String route) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 600),
      settings: RouteSettings(name: route),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}