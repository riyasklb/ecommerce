import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpService {
  static Future<http.Response?> request({
    required String url,
    String method = 'GET',
    Map<String, String>? headers,
    dynamic body,
  }) async {
    try {
      http.Response response;
      headers ??= {'Content-Type': 'application/json'};

      switch (method.toUpperCase()) {
        case 'POST':
          response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(body));
          break;
        case 'PUT':
          response = await http.put(Uri.parse(url), headers: headers, body: jsonEncode(body));
          break;
        case 'DELETE':
          response = await http.delete(Uri.parse(url), headers: headers);
          break;
        case 'GET':
        default:
          response = await http.get(Uri.parse(url), headers: headers);
          break;
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response;
      } else {
        return null; // Let the UI handle errors
      }
    } catch (e) {
      return null;
    }
  }
}
