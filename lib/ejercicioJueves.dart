import 'package:flutter/material.dart';

class ejercicioJueves extends StatefulWidget {
  const ejercicioJueves({super.key});

  @override
  State<ejercicioJueves> createState() => _ejercicioJuevesState();
}

class _ejercicioJuevesState extends State<ejercicioJueves> {
  @override
  double _height = 80.0;
  double _width = 80.0;
  var _color = Colors.blue;
  bool _resized = false;

  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RichText(
            text: TextSpan(
                text: 'Ejercicio de Widgets Terminado',
                style: _resized==false ? TextStyle(fontWeight: FontWeight.bold) : TextStyle(fontWeight: FontWeight.w100))),
          new AnimatedSize(
            curve: Curves.bounceInOut,
            child: new GestureDetector(
              onTap: () {
                setState(() {
                  if (_resized) {
                    _resized = false;
                    _color = Colors.blue;
                    _height = 80.0;
                    _width = 80.0;
                  } else {
                    _resized = true;
                    _color = Colors.blue;
                    _height = 320.0;
                    _width = 320.0;
                  }
                });
              },
              child: new Container(
                width: _width,
                height: _height,
                color: _color,
              ),
            ),
            duration: new Duration(seconds: 1),
          ),
        ],
      ),
    ));
  }
}
/*


 */
