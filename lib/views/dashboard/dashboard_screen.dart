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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Dashboard - Resumo Mensal e Gráficos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 16),

              // Cartão de resumo simples
              _SummaryCard(
                totalIncome: 2540.75,
                totalExpense: 1120.40,
                transactionsToday: 8,
              ),

              const SizedBox(height: 20),

              // Placeholder para gráfico (mantive comentário para futura integração com fl_chart)
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(
                    Icons.show_chart,
                    size: 48,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final double totalIncome;
  final double totalExpense;
  final int transactionsToday;

  const _SummaryCard({
    required this.totalIncome,
    required this.totalExpense,
    required this.transactionsToday,
  });

  @override
  Widget build(BuildContext context) {
    final incomeStyle = TextStyle(
      color: Colors.green[700],
      fontWeight: FontWeight.w600,
      fontSize: 16,
    );
    final expenseStyle = TextStyle(
      color: Colors.red[700],
      fontWeight: FontWeight.w600,
      fontSize: 16,
    );

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Coluna com renda / despesa
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hoje', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Text('Renda: R\$ ${_format(totalIncome)}', style: incomeStyle),
                const SizedBox(height: 6),
                Text('Despesa: R\$ ${_format(totalExpense)}', style: expenseStyle),
              ],
            ),

            // Indicador de número de transações
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Transações', style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 8),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Text(
                    transactionsToday.toString(),
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _format(double value) {
    return value.toStringAsFixed(2).replaceAll('.', ',');
  }
}
