import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RecurringScreen extends StatelessWidget {
  const RecurringScreen({super.key});

  // Lista de lançamentos recorrentes simulados
  final List<Map<String, dynamic>> recurringItems = const [
    {
      'title': 'Aluguel',
      'amount': 1500.00,
      'type': 'expense',
      'frequency': 'Mensal',
    },
    {
      'title': 'Salário (Receita)',
      'amount': 4000.00,
      'type': 'revenue',
      'frequency': 'Mensal',
    },
    {
      'title': 'Netflix',
      'amount': 55.90,
      'type': 'expense',
      'frequency': 'Mensal',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            } else {
              context.go('/profile');
            }
          },
        ),
        title: const Text('Lançamentos Recorrentes'),
        actions: [
          // Botão para adicionar novo recorrente
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              // Poderia navegar para um formulário de adição
            },
          ),
        ],
      ),
      body: recurringItems.isEmpty
          ? const Center(
              child: Text('Nenhum lançamento recorrente cadastrado.'),
            )
          : ListView.builder(
              itemCount: recurringItems.length,
              itemBuilder: (context, index) {
                final item = recurringItems[index];
                final isExpense = item['type'] == 'expense';

                final Color color = isExpense
                    ? Colors.red.shade700
                    : Colors.green.shade700;
                final IconData icon = isExpense
                    ? Icons.arrow_downward
                    : Icons.arrow_upward;

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  child: ListTile(
                    leading: Icon(icon, color: color),
                    title: Text(
                      item['title'] as String,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Frequência: ${item['frequency']}'),
                    trailing: Text(
                      'R\$ ${(item['amount'] as double).toStringAsFixed(2)}',
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () {
                      // Ação para editar o lançamento
                    },
                  ),
                );
              },
            ),
    );
  }
}
