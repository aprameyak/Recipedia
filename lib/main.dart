import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cooking_app/auth/gate.dart';
// import 'package:cooking_app/src/rust/api/simple.dart';
// import 'package:cooking_app/src/rust/frb_generated.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: "assets/backend/credentials/.env");
  } catch (e) {
    // Proceed without local .env in dev/CI
    print('Could not load .env file: $e');
  }
  await Supabase.initialize(
    url: 'https://egdumlkkfxknccmvgzxo.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVnZHVtbGtrZnhrbmNjbXZnenhvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc5Njk2MDEsImV4cCI6MjA2MzU0NTYwMX0.9yT_wv-72Hlea4E0Rlo4p8V_aWObnvxksx1UOTdIQlc',
  );
  await Future.delayed(const Duration(milliseconds: 100));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CookingApp',
      theme: AppTheme.lightTheme,
      home: const AuthGate(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
