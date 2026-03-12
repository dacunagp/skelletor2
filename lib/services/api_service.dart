import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _url = 'https://gpconsultores.cl/apicollector/show_programs.php';
  static const String _auth = 'collector:gp2026';

  Future<Map<String, dynamic>> fetchPrograms() async {
    final String basicAuth = 'Basic ${base64Encode(utf8.encode(_auth))}';

    final response = await http.get(
      Uri.parse(_url),
      headers: {
        'Authorization': basicAuth,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load programs: ${response.statusCode}');
    }
  }
}
