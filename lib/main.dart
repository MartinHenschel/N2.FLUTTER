import 'package:flutter/material.dart';

// Importa a configuração de rotas (GoRouter)
import 'config/app_routes.dart';

// Importa o tema (AppTheme) que acabamos de criar
import 'config/app_theme.dart';

void main() {
  // Inicializa o aplicativo
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp.router é usado para integrar o GoRouter
    return MaterialApp.router(
      title: 'Controle de Gastos N2',

      // Aplica a configuração de tema
      theme: AppTheme.lightTheme,

      // Passa a configuração do GoRouter
      routerConfig: AppRoutes.router,

      // Remove o banner de debug (opcional, mas recomendado)
      debugShowCheckedModeBanner: false,
    );
  }
}
