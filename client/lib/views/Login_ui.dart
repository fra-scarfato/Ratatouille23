import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

class Login_ui extends StatefulWidget {

  const Login_ui({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,

      ),
      builder: (context, child) => ResponsiveWrapper.builder(
        child,
        maxWidth: 1200,
        minWidth: 480,
        defaultScale: true,
        breakpoints: [
          ResponsiveBreakpoint.resize(480, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.resize(1000, name: DESKTOP),
        ],
        background: RotatedBox(quarterTurns: 3, child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage("https://images.pexels.com/photos/7439978/pexels-photo-7439978.jpeg"),

            ),

          ),
        ),
        ),


      ),
      initialRoute: "/",

    );



  }


  @override
  Login createState() => Login();


}

class Login extends State<Login_ui>{

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String fullMail = '';
  String fullPassword = '';

  @override
  Widget build(BuildContext context){

    return Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text(
                    'Gestisci la tua attività in modo semplice e veloce',
                    style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(0.0, 10.0),
                            blurRadius: 3.0,
                            color: Colors.black,
                          ),
                        ]

                    )
                ),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 509,
                  height: 91,
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(50)
                      ),
                      hintText: 'Inserisci email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (text){
                      setState(() {
                        fullMail=text;
                      });
                    },
                  ) ,
                ),
                SizedBox(
                  width: 509,
                  height: 91,
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword ,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(50)
                      ),
                      hintText: 'Inserisci la password',
                    ),
                    onChanged: (text){
                      setState(() {
                        fullPassword=text;
                      });
                    },
                  ) ,
                ),
                ElevatedButton(
                    onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const home()));},
                    child: Text(
                      'ACCEDI',
                      style:TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),

                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),

                    )


                )
              ],
            )
        )
    );



  }
}