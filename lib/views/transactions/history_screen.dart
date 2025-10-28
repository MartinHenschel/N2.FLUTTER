import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  // Lista de dados de transações de exemplo
  final List<Map<String, dynamic>> transactions = const [
    {
      'title': 'Conta de Luz',
      'amount': 150.50,
      'date': '2025-05-20',
      'type': 'expense',
      'icon': Icons.lightbulb_outline,
    },
    {
      'title': 'Salário Mensal',
      'amount': 3500.00,
      'date': '2025-05-18',
      'type': 'revenue',
      'icon': Icons.work,
    },
    {
      'title': 'Mercado da Semana',
      'amount': 220.00,
      'date': '2025-05-17',
      'type': 'expense',
      'icon': Icons.shopping_cart,
    },
    {
      'title': 'Almoço no Restaurante',
      'amount': 55.00,
      'date': '2025-05-17',
      'type': 'expense',
      'icon': Icons.restaurant,
    },
    {
      'title': 'Bônus de Projeto',
      'amount': 500.00,
      'date': '2025-05-15',
      'type': 'revenue',
      'icon': Icons.monetization_on,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Lançamentos'),
        // Ícone de filtro no AppBar
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Ação de filtro
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];

          // Define a cor e o ícone com base no tipo de transação (receita/despesa)
          final Color color = transaction['type'] == 'expense'
              ? Colors.red.shade700
              : Colors.green.shade700;
          final String sign = transaction['type'] == 'expense' ? '-' : '+';

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: ListTile(
              leading: Icon(transaction['icon'] as IconData, color: color),
              title: Text(
                transaction['title'] as String,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(transaction['date'] as String),
              trailing: Text(
                '$sign R\$ ${(transaction['amount'] as double).toStringAsFixed(2)}',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                // Ação para ver detalhes da transação (opcional para a N2)
              },
            ),
          );
        },
      ),
    );
  }
}
