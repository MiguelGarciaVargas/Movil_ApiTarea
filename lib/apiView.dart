import 'package:actividad_api/home.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

class ApiView extends StatefulWidget {
  final int status;
  final List<String> colores;
  final List<int> numeros;

  const ApiView(
      {required Key key,
      required this.status,
      required this.colores,
      required this.numeros})
      : super(key: key);

  @override
  State<ApiView> createState() => _ApiViewState();
}

class _ApiViewState extends State<ApiView> {
  @override
  Widget build(BuildContext context) {
    debugPrint(">>>>>HOME<<<<<<<<<");

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Home(),
              ));
        },
        child: Icon(Icons.home),
        shape: CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Stack(
        children: [
          Align(
              alignment: AlignmentDirectional(0, 0),
              child: widget.status == 200 ? status200(widget: widget): errorStatus(status: widget.status)
              //child: errorStatus(status: 404)

          )
        ],
      ),
    );
  }
}

class errorStatus extends StatelessWidget {
  final int status;

  const errorStatus({
    super.key, required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return status==404 ? Container(
      child: Lottie.asset('imagenes/error404.json')
    ) :
    Container(
        child: Image.asset('imagenes/error500.jpg')
    );
  }
}

class status200 extends StatelessWidget {
  const status200({
    super.key,
    required this.widget,
  });

  final ApiView widget;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height / widget.numeros[0];
    double width = size.width / widget.numeros[0];
    return Padding(
      padding: EdgeInsets.all(10),
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.numeros[0],
            childAspectRatio: width / height,
          ),
          itemCount: widget.numeros[0] * widget.numeros[1],
          itemBuilder: (context, index) {
            int contColores = 0;
            return Card(
              color: Color(int.parse(widget.colores[index % widget.colores.length].replaceAll("#", "0xff"))),
              child: Center(
                child: Text("Miguel Angel Pablo Garcia Vargas"),
              ),
            );
          }),
    );
  }
}
