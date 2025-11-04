import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  // Lista de categorias simuladas (mutável agora)
  List<Map<String, dynamic>> categories = [
    {'name': 'Alimentação', 'type': 'expense', 'icon': Icons.fastfood},
    {'name': 'Transporte', 'type': 'expense', 'icon': Icons.directions_car},
    {'name': 'Salário', 'type': 'revenue', 'icon': Icons.work},
    {'name': 'Investimentos', 'type': 'revenue', 'icon': Icons.trending_up},
    {'name': 'Lazer', 'type': 'expense', 'icon': Icons.sports_esports},
  ];

  Future<void> _confirmDelete(int index) async {
    final category = categories[index];
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir categoria'),
        content: Text('Deseja excluir "${category['name']}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancelar')),
          TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Excluir')),
        ],
      ),
    );

    if (result == true) {
      setState(() {
        categories.removeAt(index);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Categoria excluída')),
      );
    }
  }

  Future<void> _showAddCategoryDialog() async {
    final TextEditingController nameController = TextEditingController();
    String type = 'expense';

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nova categoria'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Despesa'),
                    value: 'expense',
                    groupValue: type,
                    onChanged: (v) => setState(() => type = v ?? 'expense'),
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Receita'),
                    value: 'revenue',
                    groupValue: type,
                    onChanged: (v) => setState(() => type = v ?? 'revenue'),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancelar')),
          TextButton(
            onPressed: () {
              if (nameController.text.trim().isEmpty) return;
              // Retorna verdadeiro para indicar que foi criado
              Navigator.of(context).pop(true);
            },
            child: const Text('Criar'),
          ),
        ],
      ),
    );

    if (result == true) {
      setState(() {
        categories.add({
          'name': nameController.text.trim(),
          'type': type,
          'icon': type == 'expense' ? Icons.category : Icons.attach_money,
        });
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Categoria criada')),
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
              // ignore: use_build_context_synchronously
              context.go('/profile');
            }
          },
        ),
        title: const Text('Gerenciar Categorias'),
        actions: [
          // Botão para adicionar nova categoria
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: _showAddCategoryDialog,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isExpense = category['type'] == 'expense';

          final Color color = isExpense ? Colors.red.shade700 : Colors.green.shade700;

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: ListTile(
              leading: Icon(category['icon'] as IconData, color: color),
              title: Text(category['name'] as String),
              subtitle: Text(
                isExpense ? 'Despesa' : 'Receita',
                style: TextStyle(color: color, fontSize: 12),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, size: 20, color: Colors.grey),
                    onPressed: () {
                      // Ação de edição (poderia abrir um diálogo similar ao de criar)
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, size: 20, color: Colors.redAccent),
                    onPressed: () => _confirmDelete(index),
                  ),
                ],
              ),
              onLongPress: () => _confirmDelete(index),
            ),
          );
        },
      ),
    );
  }
}
