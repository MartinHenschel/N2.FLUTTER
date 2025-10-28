import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar Conta'), elevation: 0),
      body: Center(
        child: SingleChildScrollView(
          // Permite rolar se o teclado aparecer
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Título
              Text(
                'Cadastre-se',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),

              // Campo de Nome Completo
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nome Completo',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 20),

              // Campo de Email
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),

              // Campo de Senha
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),

              // Campo de Confirmação de Senha
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Confirmar Senha',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock_reset),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 30),

              // Botão de Cadastro (Navegação para Login)
              ElevatedButton(
                onPressed: () {
                  // Após o cadastro, o usuário é redirecionado para a tela de Login.
                  // Usamos go() para substituir a tela, impedindo que voltem
                  context.go('/login');
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Criar Conta'),
              ),

              const SizedBox(height: 20),

              // Link para Login
              TextButton(
                onPressed: () => context.go('/login'),
                child: const Text('Já tem uma conta? Faça Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
