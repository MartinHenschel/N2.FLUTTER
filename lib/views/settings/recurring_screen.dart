import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'recurring_form_screen.dart';

class RecurringScreen extends StatefulWidget {
  const RecurringScreen({super.key});

  @override
  State<RecurringScreen> createState() => _RecurringScreenState();
}

class _RecurringScreenState extends State<RecurringScreen> {
  List<Map<String, dynamic>> recurringItems = [
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

  Future<void> _confirmDelete(int index) async {
    final item = recurringItems[index];
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir recorrente'),
        content: Text('Deseja excluir "${item['title']}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancelar')),
          TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Excluir')),
        ],
      ),
    );

    if (result == true) {
      setState(() {
        recurringItems.removeAt(index);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lançamento recorrente excluído')),
      );
    }
  }

  Future<void> _openNewRecurringForm() async {
    // Abre a tela de formulário e aguarda o resultado
    final result = await Navigator.of(context).push<Map<String, dynamic>>(
      MaterialPageRoute(builder: (context) => const RecurringFormScreen()),
    );

    if (result != null) {
      setState(() {
        recurringItems.add(result);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lançamento recorrente criado')),
      );
    }
  }

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
            onPressed: _openNewRecurringForm,
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

                final Color color = isExpense ? Colors.red.shade700 : Colors.green.shade700;
                final IconData icon = isExpense ? Icons.arrow_downward : Icons.arrow_upward;

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: ListTile(
                    leading: Icon(icon, color: color),
                    title: Text(
                      item['title'] as String,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Frequência: ${item['frequency']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'R\$ ${(item['amount'] as double).toStringAsFixed(2)}',
                          style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, size: 20, color: Colors.redAccent),
                          onPressed: () => _confirmDelete(index),
                        ),
                      ],
                    ),
                    onTap: () {
                      // Ação para editar o lançamento (poderia abrir o mesmo formulário passando os dados)
                    },
                  ),
                );
              },
            ),
    );
  }
}
