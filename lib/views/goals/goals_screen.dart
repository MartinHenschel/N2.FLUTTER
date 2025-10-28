import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Metas de Economia')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'UI/UX de Metas (Barra de Progresso)',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navega para o formulário de criação de metas
                context.push('/new-goal');
              },
              child: const Text('Criar Nova Meta'),
            ),
          ],
        ),
      ),
    );
  }
}
