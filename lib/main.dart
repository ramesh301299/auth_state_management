import 'package:auth_state_management/features/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/auth/providers/auth_provider.dart';
import 'features/auth/views/login_page.dart';


void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    ref.read(authStateProvider.notifier).loadToken();
  }

  @override
  Widget build(BuildContext context) {
    final token = ref.watch(authStateProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: token != null ? const HomePage() : const LoginPage(),
    );
  }
}
