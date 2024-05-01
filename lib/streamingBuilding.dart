import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class StreamingBuilding extends StatefulWidget {
  const StreamingBuilding({super.key});

  @override
  State<StreamingBuilding> createState() => _StreamingBuildingState();
}

class _StreamingBuildingState extends State<StreamingBuilding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              child: StreamBuilder(
                  stream:
                      FirebaseFirestore.instance.collection('user').snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    return ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        print(document.id);
                        print("Helllooo");

                        return Row(children: [
                          Expanded(
                            flex: 5,
                            child: Container(
                              height: 100,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.pinkAccent,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                //Ocupa el espacio minimo de los widgets hijos
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      //Text(document.id),
                                      Text(document['name']),
                                      Text("${document['age']}"),
                                      Container(child:
                                        Row( children: [
                                          IconButton(
                                            iconSize: 60,
                                            icon: const Icon(Icons.delete),
                                            onPressed: () async {
                                              final FirebaseFirestore db = FirebaseFirestore.instance;
                                              final CollectionReference users = db.collection('user');
                                              final DocumentSnapshot snapshot = await users.doc('runtime').get();

                                              await users.doc(document.id).delete();

                                              Navigator.push(context, MaterialPageRoute(builder: (context) => StreamingBuilding()));
                                            },
                                          ),
                                          IconButton(
                                            iconSize: 60,
                                            icon: const Icon(Icons.edit),
                                            onPressed: () async {
                                              final FirebaseFirestore db = FirebaseFirestore.instance;
                                              final CollectionReference users = db.collection('user');
                                              final DocumentSnapshot snapshot = await users.doc('runtime').get();


                                              editingFields(context, users, document, false);
                                            },
                                          ),
                                        ],),)

                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ]);

                        return ListTile(
                          title: Text(document['name']),
                          subtitle: Text("${document['age']}"),
                        );
                      }).toList(),
                    );
                  })),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final FirebaseFirestore db = FirebaseFirestore.instance;
          final CollectionReference users = db.collection('user');
          final DocumentSnapshot snapshot = await users.doc('runtime').get();


          editingFields(context, users, null, true);


        },
        child: Icon(Icons.add),
        shape: CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void editingFields(BuildContext context, CollectionReference<Object?> users, DocumentSnapshot<Object?>? document, bool isAdding) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController nameController = TextEditingController();
        final TextEditingController ageController = TextEditingController();
        return AlertDialog(
          title: Text("Edicion de user"),
          actions: <Widget>[
            Column(
              children: [
                FormFieldRegister(
                  nameController: nameController,
                  usedIcon: Icons.person,
                  labelText: "User"),
                FormFieldRegister(
                    nameController: ageController,
                    usedIcon: Icons.cake,
                    labelText: "Age"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                  TextButton(
                    onPressed: () {
                      debugPrint("Edit CANCELADO edit");
                      Navigator.of(context)
                          .pop(); // Cierra el AlertDialog
                    },
                    child: Text("Cancelar"),
                  ),
                    TextButton(
                      onPressed: () async {
                        Map<String, dynamic> editedUser = {
                          'name': nameController.text,
                          'age': ageController.text
                        };

                        debugPrint("guardado hecho edit");
                        isAdding ? await users.doc().set(editedUser) :document!=null ? await users.doc(document.id).update(editedUser) : Container();
                        Navigator.of(context)
                            .pop(); // Cierra el AlertDialog
                      },
                      child: Text("guardar"),
                    ),
                ],)

              ],
            )

          ],
        );
      },
    );
  }
}

class FormFieldRegister extends StatelessWidget {
  const FormFieldRegister({
    Key? key,
    required this.nameController,
    required this.usedIcon,
    required this.labelText,
  }) : super(key: key);

  final TextEditingController nameController;
  final IconData usedIcon;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: nameController,
        decoration: InputDecoration(
          icon: Icon(usedIcon),
          labelText: labelText,
          labelStyle: TextStyle(fontSize: 18.0),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Colors.deepOrangeAccent),
          ),
        ),
      ),
    );
  }
}
