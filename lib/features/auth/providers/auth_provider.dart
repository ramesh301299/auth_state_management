import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/auth_service.dart';

final authServiceProvider = Provider((ref) => AuthService());

final authStateProvider =
    StateNotifierProvider<AuthNotifier, String?>((ref) => AuthNotifier(ref));

class AuthNotifier extends StateNotifier<String?> {
  final Ref ref;
  AuthNotifier(this.ref) : super(null);

  Future<void> signUp(String email, String password) async {
    final token =
        await ref.read(authServiceProvider).signUp(email, password);
    state = token;
    await _saveToken(token);
  }

  Future<void> signIn(String email, String password) async {
    final token =
        await ref.read(authServiceProvider).signIn(email, password);
    state = token;
    await _saveToken(token);
  }

  Future<void> signOut() async {
    state = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('idToken');
  }

  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('idToken');
    if (token != null) {
      state = token;
    }
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('idToken', token);
  }
}
