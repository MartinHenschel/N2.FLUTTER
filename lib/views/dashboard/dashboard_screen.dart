import 'package:flutter/material.dart';
// Se já adicionou o fl_chart no pubspec.yaml, descomente a linha abaixo
// import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold é o container principal da tela
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        // Você pode configurar a AppBar aqui ou deixar o MainScaffold cuidar disso
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Dashboard - Resumo Mensal e Gráficos',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            // ESPAÇO PARA IMPLEMENTAÇÃO DO FL_CHART:
            // Substitua esta linha pelo seu widget de gráfico (ex: PieChart)
            Text('Aqui vai o seu gráfico de balanço usando fl_chart'),
          ],
        ),
      ),
    );
  }
}
