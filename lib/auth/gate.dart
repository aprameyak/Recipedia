import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:chef_social/pages/login.dart';
import 'package:chef_social/pages/home.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        debugPrint('Auth State Event: ${snapshot.data?.event}');
        debugPrint('Auth State Session: ${snapshot.data?.session != null}');
        debugPrint('Connection State: ${snapshot.connectionState}');

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }

        final authState = snapshot.data;
        if (authState?.session != null) {
          return const HomePage();
        }

        return const LoginPage();
      },
    );
  }
}
