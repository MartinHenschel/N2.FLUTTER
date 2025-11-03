import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meu Perfil')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. HEADER E INFORMAÇÕES DO USUÁRIO
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              child: const Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    // Poderia ser uma imagem de perfil, mas usamos um ícone para simular
                    child: Icon(Icons.person_rounded, size: 50),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Daniella Souza', // Nome de exemplo
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'danih_user@appgastos.com', // Email de exemplo
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 2. SEÇÃO DE CONFIGURAÇÕES (TELAS SECUNDÁRIAS)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Configurações',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Divider(),

                  // Item: Lançamentos Recorrentes (Navega para /recurring)
                  ListTile(
                    leading: const Icon(Icons.repeat),
                    title: const Text('Lançamentos Recorrentes'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      context.go('/recurring');
                    },
                  ),

                  // Item: Categorias (Navega para /categories)
                  ListTile(
                    leading: const Icon(Icons.category),
                    title: const Text('Gerenciar Categorias'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      context.go('/categories');
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 3. AÇÃO DE LOGOUT
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  // Ação de Logout: Volta para a tela de Login
                  context.go('/login');
                },
                icon: const Icon(Icons.logout),
                label: const Text('Sair da Conta'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(
                    double.infinity,
                    50,
                  ), // Botão de largura total
                  backgroundColor: Colors.red.shade400,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
