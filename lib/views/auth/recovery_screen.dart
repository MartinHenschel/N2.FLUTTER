import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RecoveryScreen extends StatelessWidget {
  const RecoveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recuperar Senha'), elevation: 0),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Título
              Text(
                'Recuperar Acesso',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),

              // Descrição
              const Text(
                'Digite seu e-mail abaixo para receber um link de redefinição de senha.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 50),

              // Campo de Email
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 30),

              // Botão de Envio (Navegação para Login)
              ElevatedButton(
                onPressed: () {
                  // Após "enviar" o link, o usuário é redirecionado para o Login.
                  context.go('/login');

                  // Opcional: Mostrar uma mensagem de sucesso
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Link de redefinição enviado para o seu e-mail!',
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Redefinir Senha'),
              ),

              const SizedBox(height: 20),

              // Link para Login
              TextButton(
                onPressed: () => context.go('/login'),
                child: const Text('Lembrou a senha? Voltar para Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
