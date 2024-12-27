import 'dart:developer';
import 'package:healer_user/services/token.dart';
import 'package:http/http.dart' as http;

Future<String?> _validateToken() async {
  final token = await getValidToken();
  if (token == null) log('Token is null or invalid');
  return token;
}

Future<http.Response?> makeRequest(
  String url,
  String method, {
  Map<String, String>? headers,
  dynamic body,
}) async {
  final token = await _validateToken();
  if (token == null) return null;

  headers = {
    ...?headers,
    'Authorization': 'Bearer $token',
    "Content-Type": "application/json"
  };

  switch (method) {
    case 'GET':
      return await http.get(Uri.parse(url), headers: headers);
    case 'POST':
      return await http.post(Uri.parse(url), headers: headers, body: body);
    case 'PUT':
      return await http.put(Uri.parse(url), headers: headers, body: body);
    case 'DELETE':
      return await http.delete(Uri.parse(url), headers: headers);
    default:
      log('Unsupported HTTP method: $method');
      return null;
  }
}
