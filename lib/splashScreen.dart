import 'package:actividad_api/ejercicioJueves.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Widget example1 = FlutterSplashScreen.fadeIn(
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.grey,
      onInit: () { debugPrint("onInit"); },
      onEnd: () { debugPrint("onEnd"); },
      childWidget: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("imagenes/logo.png", width: size.width * .85)
          ]
        )
      ),
      nextScreen: const ejercicioJueves()

    );
    return MaterialApp(
      title: "Splash screen demo",
      home: example1,
      debugShowCheckedModeBanner: false
    );

  }
}
