import 'package:flutter/material.dart';

class ApiView extends StatefulWidget {
  const ApiView({super.key});

  @override
  State<ApiView> createState() => _ApiViewState();
}

class _ApiViewState extends State<ApiView> {
  @override
  Widget build(BuildContext context) {
    debugPrint(">>>>>HOME<<<<<<<<<");
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          lista.length == 0
              ? Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'imagenes/noHay.PNG'), // Ruta de la imagen de fondo
                fit: BoxFit
                    .cover, // Ajustar la imagen al tamaño de la pantalla
              ),
            ),
          )
              : Container(),
          listUsers(size: size, lista: lista)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Register()),
          );
        },
        child: Icon(Icons.add),
        shape: CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

    );
  }
}


class listUsers extends StatefulWidget {
  const listUsers({
    super.key,
    required this.size,
    required this.lista,
  });

  final Size size;
  final List<Map<String, dynamic>> lista;

  @override
  State<listUsers> createState() => _listUsersState();
}

class _listUsersState extends State<listUsers> {
  int i = 0, j = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: SizedBox(
        height: widget.size.height * 0.8,
        width: widget.size.width,
        child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: widget.lista.length,
            itemBuilder: (BuildContext context, int index) {
              i = index * 2;
              j = i + 1;

              // Obtén los primeros dos datos del singleton
              var datos1 = i < singleton.getList(false).length
                  ? singleton.getList(false)[i]
                  : null;

              var datos2 = j < singleton.getList(false).length
                  ? singleton.getList(false)[j]
                  : null;

              Map<String, dynamic>? datos1Map = datos1 != null
                  ? {
                '_id': datos1['_id'],
                'name': datos1['name'],
                'lastName': datos1['lastName'],
                'password': datos1['password'],
                'email': datos1['email'],
                'user': datos1['user'],
                'description': datos1['description'],
              }
                  : null;

              Map<String, dynamic>? datos2Map = datos2 != null
                  ? {
                '_id': datos2['_id'],
                'name': datos2['name'],
                'lastName': datos2['lastName'],
                'password': datos2['password'],
                'email': datos2['email'],
                'user': datos2['user'],
                'description': datos2['description'],
              }
                  : null;

              return Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Row(children: [
                    datos1Map != null
                        ? Expanded(
                      flex: 5,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => User(userData: datos1Map),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.pinkAccent,
                              borderRadius: BorderRadius.circular(30)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            //Ocupa el espacio minimo de los widgets hijos
                            children: [
                              Image.asset(
                                "imagenes/user.png",
                                width: widget.size.width * 0.3,
                              ),
                              Text(
                                  '${datos1Map['name']} ${datos1Map['lastName']}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25)),
                              Text(datos1Map['email'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15)),
                              Text(datos1Map['_id'].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 30)),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.star,
                                      color: Colors.yellowAccent,
                                      size: 14),
                                  Icon(
                                    Icons.heart_broken_outlined,
                                    size: 14,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                        : Container(),
                    SizedBox(
                      width: 15,
                    ),
                    datos2Map != null
                        ? Expanded(
                      /*Este es donde va la condicion de si o no*/
                      flex: 5,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.pinkAccent,
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          //Ocupa el espacio minimo de los widgets hijos
                          children: [
                            //'id#nombre#imagen.png#calif#favoritos#categoria'
                            Image.asset(
                              "imagenes/user.png",
                              width: widget.size.width * 0.3,
                            ),
                            Text(
                                '${datos2Map['name']} ${datos2Map['lastName']}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25)),
                            Text(datos2Map['email'],
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15)),
                            Text(datos2Map['_id'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 30)),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.star,
                                    color: Colors.yellowAccent, size: 14),
                                Icon(
                                  Icons.heart_broken_outlined,
                                  size: 14,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                        : Container()
                  ]));
            }),
      ),

    );
  }
}
