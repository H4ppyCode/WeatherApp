import 'dart:convert';
import 'package:http/http.dart' as http;

class TimeService {
  static const BASE_URL = 'https://api.api-ninjas.com/v1/worldtime';
  static const API_KEY =
      'BsLXzFaYhcvLUlaMbkPoyg==bA4w50uJU0sSkjpp'; // Remplacez par votre clé API
// Remplacez par votre clé API

  Future<String> getCityTime(String cityName, String zone) async {
    final response = await http.get(
      Uri.parse('$BASE_URL?timezone=$zone/$cityName'),
      headers: {'X-Api-Key': API_KEY},
    );

    if (response.statusCode != 200) {
      throw Exception('Error fetching time data: ${response.reasonPhrase}');
    } else {
      final data = jsonDecode(response.body);
      return data['datetime'];
    }
  }
}
