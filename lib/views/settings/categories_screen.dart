import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  // Lista de categorias simuladas
  final List<Map<String, dynamic>> categories = const [
    {'name': 'Alimentação', 'type': 'expense', 'icon': Icons.fastfood},
    {'name': 'Transporte', 'type': 'expense', 'icon': Icons.directions_car},
    {'name': 'Salário', 'type': 'revenue', 'icon': Icons.work},
    {'name': 'Investimentos', 'type': 'revenue', 'icon': Icons.trending_up},
    {'name': 'Lazer', 'type': 'expense', 'icon': Icons.sports_esports},
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
        title: const Text('Gerenciar Categorias'),
        actions: [
          // Botão para adicionar nova categoria
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              // Ação para abrir um formulário de nova categoria
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isExpense = category['type'] == 'expense';

          final Color color = isExpense
              ? Colors.red.shade700
              : Colors.green.shade700;

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: ListTile(
              leading: Icon(category['icon'] as IconData, color: color),
              title: Text(category['name'] as String),
              subtitle: Text(
                isExpense ? 'Despesa' : 'Receita',
                style: TextStyle(color: color, fontSize: 12),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.edit, size: 20, color: Colors.grey),
                onPressed: () {
                  // Ação de edição
                },
              ),
              onLongPress: () {
                // Ação de exclusão
              },
            ),
          );
        },
      ),
    );
  }
}
