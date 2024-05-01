import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:actividad_api/getApi.dart';

import 'apiView.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.teal,
          automaticallyImplyLeading: false,
          title: Text(
            'Actividad API',
          ),
          centerTitle: true,
          elevation: 2,
        ),
        body: Stack(

            children: [
              Align(
                alignment: AlignmentDirectional(0,0),
                  child: Column(
                    children: [
                      SizedBox(height: size.height * .15),
                      Image.asset('imagenes/logo.png'), // Añade la ruta de tu imagen
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          getJsonData();

                        },
                        child: Text(
                          "Genera la llamada",
                          style: TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(30)),
                            fixedSize:
                            Size(size.width * 0.6, 45)),
                      )
                    ],
                  ),
              )


            ]));
  }

  Future<void> getJsonData() async {
    NetworkHelper networkHelper = NetworkHelper();
    debugPrint("DESDE GETJASONDATA ^^^");
    try {
      var data;
      data = await networkHelper.getData();
      print("DATOS JSON DESDE HOME");
      print(data);

      // Lee el valor de 'status'
      int status = data['status'];
      print('Status: $status');

      // Lee la lista de colores
      List<String> colores = List<String>.from(data['colores']);
      print('Colores: $colores');

      // Lee la lista de números
      List<int> numeros = List<int>.from(data['numeros']);
      print('Números: $numeros');

      print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
      print("^^^^^^^^^^^^^^^^^^^^^^^^^^HOME^^^^^^^^^^^^^^^^^^^^^^^^");
      print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");

      if (status != null && colores != null && numeros != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ApiView(
              key: UniqueKey(),
              status: status,
              colores: colores,
              numeros: numeros,
          ),
        ));
      }

    } catch (e) {
      print("No se pudo conectar");
    }
  }
}
