import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  // Obtenemos las variables del .env
  final String _baseUrl = dotenv.env['API_URL'] ?? 'URL_NO_CONFIGURADA';
  final String _user = dotenv.env['API_USER'] ?? 'USUARIO_NO_CONFIGURADO';
  final String _pass = dotenv.env['API_PASSWORD'] ?? 'PASS_NO_CONFIGURADA';

  // Generamos el Header de Authorization (Basic Auth)
  Map<String, String> get _headers {
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';
    return {
      'Authorization': basicAuth,
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  // --- MÉTODOS DE EJEMPLO ---

  // Obtener Programas (GET)
  Future<http.Response> fetchProgramas() async {
    final url = Uri.parse('$_baseUrl/programas'); // Cambia esto por tu endpoint real
    return await http.get(url, headers: _headers);
  }

  // Enviar o solicitar datos de Muestras (POST)
  Future<http.Response> postMuestras(String programa, List<String> estaciones) async {
    final url = Uri.parse('$_baseUrl/muestras/sincronizar'); // Cambia esto por tu endpoint real
    final body = jsonEncode({
      'programa': programa,
      'estaciones': estaciones,
    });
    
    return await http.post(url, headers: _headers, body: body);
  }
}