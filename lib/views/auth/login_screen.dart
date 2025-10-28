import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrar'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'UI/UX da Tela de Login',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Navega para a dashboard após login (Navegação N2)
                context.go('/dashboard');
              },
              child: const Text('Fazer Login'),
            ),
            TextButton(
              onPressed: () => context.go('/signup'),
              child: const Text('Criar conta'),
            ),
          ],
        ),
      ),
    );
  }
}
