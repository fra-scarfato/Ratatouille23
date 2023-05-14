import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ratatouille23/controllers/Amplify_controller.dart';
import 'package:ratatouille23/views/Home.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:flutter/services.dart';

// Generated in previous step

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: <SystemUiOverlay>[]);
  Amplify_controller amplify_controller = new Amplify_controller();
  amplify_controller.configureAmplify();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        debugShowCheckedModeBanner: false,
        scrollBehavior: MyCustomScrollBehavior(),
        builder: (context, child) => ResponsiveWrapper.builder(
          child,
          maxWidth: MediaQuery.of(context).size.width,//1200,
          minWidth: MediaQuery.of(context).size.width,//480,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(480, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          ],
          background: RotatedBox(quarterTurns: 3, child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/wallpaper_ratatouille.jpeg"),

            ),

            ),
          ),
          ),


        ),
        initialRoute: "/",
        home: Home()
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}