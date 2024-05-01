import 'package:actividad_api/apiView.dart';
import 'package:actividad_api/ejercicioJueves.dart';
import 'package:actividad_api/firebase_options.dart';
import 'package:actividad_api/splashScreen.dart';
import 'package:actividad_api/streamingBuilding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final CollectionReference users = db.collection('user');
  final DocumentSnapshot snapshot = await users.doc('runtime').get();

  /*
  final Map<String, dynamic> userFields = {
    'name': 'alejandro',
    'age': '28'
  };
  await users.doc().set(userFields);

  final Map<String, dynamic> userFields = {
    'name': 'oscar alejandro',
  };
  await users.doc('newUser').update(userFields);

  await users.doc('newUser').delete();*/


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StreamingBuilding(),
    );
  }
}
