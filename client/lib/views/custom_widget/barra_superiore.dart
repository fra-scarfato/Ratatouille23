import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class barra_superiore extends StatelessWidget{
  final String text;
  const barra_superiore({Key? key, required this.text}): super(key: key);
  Widget build(BuildContext context){
    return Container(
        height: 60.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(100.0),
            bottomRight: Radius.circular(100.0),
          ),
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.orangeAccent,
                Colors.yellow
              ]
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 30,
            ),
            IconButton(
              onPressed: (){Navigator.pop(context);},
              icon: Icon(
                Icons.arrow_back_outlined,
                color: Colors.white,
                size: 30,
              ),
            ),
            Spacer(),
            Text(
              '$text',
              style:TextStyle(
                fontSize: 36,
                color: Colors.white,
              ),
            ),
            Spacer(),
          ],
        )
    );
  }
}