import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper();

  final String url = 'http://nrweb.com.mx/reportes/api_prueba.php?nombre=%22alejandro%22&hora=10';

  Future getData() async {
    http.Response response = await http.get(Uri.parse('$url'));
    if (response.statusCode == 200) {
      String data = response.body;
      print("DATOS JSON DESDE GETaPI");
      print(data);
      return jsonDecode(data);
    } else {
      // Manejo de errores
      String errorMessage = 'Error desconocido';
      if (response.statusCode == 404) {
        errorMessage = 'No se pudo conectar: 404';
      } else if (response.statusCode == 500) {
        errorMessage = 'Error sintáctico: 500';
      }
    }
  }
}