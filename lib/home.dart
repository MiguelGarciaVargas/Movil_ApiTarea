
import 'package:flutter/material.dart';
import 'package:burguer_classic/constantes.dart' as con;
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'getApi.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        //En columna principal se puede usar single child scroll view
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("imagenes/Welcome 1.png"),
                    fit: BoxFit.cover)),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: size.height * .01,
                bottom: size.height * .01,
                right: size.width * .01,
                left: size.width * .01),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      "imagenes/Welcome 2.png",
                      width: size.width * 0.25,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: size.height * 0.05,
                          bottom: size.height * 0.05,
                          left: size.height * 0.01,
                          right: size.height * 0.01),
                      child: Container(
                        decoration: BoxDecoration(
                            color: con.blanco,
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 50, top: 20, right: 50, bottom: 20),
                          child: Align(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        try {
                                          print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
                                          print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
                                          print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
                                          var data;
                                          data = await networkHelper.getData();
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                  const Home()));
                                          print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
                                          print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
                                          print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
                                        } catch (e) {
                                          print("No se pudo conectar");
                                        }
                                      },
                                      child: Text(
                                        "Genera la llamada",
                                        style: TextStyle(
                                            color: con.blanco, fontSize: 20),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: con.naranja,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(30)),
                                          fixedSize:
                                          Size(size.width * 0.6, 45)),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getJsonData() async {
    NetworkHelper networkHelper = NetworkHelper(    );

    try {
      print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
      print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
      print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
      var data;
      data = await networkHelper.getData();
      print(data);

      print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
      print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
      print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
    } catch (e) {
      print("No se pudo conectar");
    }
  }
}
