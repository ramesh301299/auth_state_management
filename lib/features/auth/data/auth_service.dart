import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/firebase_config.dart';

class AuthService {
  Future<String> signUp(String email, String password) async {
    final response = await http.post(
      Uri.parse(FirebaseConfig.signUpUrl),
      body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['idToken'];
    } else {
      final error = json.decode(response.body);
      throw Exception(error['error']['message'] ?? 'Sign up failed');
    }
  }

  Future<String> signIn(String email, String password) async {
    final response = await http.post(
      Uri.parse(FirebaseConfig.signInUrl),
      body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['idToken'];
    } else {
      final error = json.decode(response.body);
      throw Exception(error['error']['message'] ?? 'Sign in failed');
    }
  }
}
