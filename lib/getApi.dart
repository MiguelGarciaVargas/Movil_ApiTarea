import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper();

  final String url = 'https://api.openrouteservice.org/v2/directions/';
  final String apiKey =
      '5b3ce3597851110001cf624806a2e235fb984c64871eb026605cbd30';

  Future getData() async {
    http.Response response = await http.get(Uri.parse('$url'));
    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
      return jsonDecode(data);
    } else if (response.statusCode == 404){
      print("NO SE PUDO CONECTAR ^^^404^^^");
      print(response.statusCode);
    } else if (response.statusCode == 500){
      print("Error sintactico ^^^500^^^");
      print(response.statusCode);
    }
  }
}