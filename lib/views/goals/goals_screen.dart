import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  List<Map<String, dynamic>> mockGoals = [
    {
      'title': 'Férias em Fernando de Noronha',
      'description': 'Viagem dos sonhos com a família',
      'target': 8000.0,
      'current': 2400.0,
      'dueDate': DateTime.now().add(const Duration(days: 200)),
    },
    {
      'title': 'Fundo de Emergência',
      'description': '3 meses de despesas',
      'target': 12000.0,
      'current': 7200.0,
      'dueDate': DateTime.now().add(const Duration(days: 365)),
    },
    {
      'title': 'Notebook novo',
      'description': 'Substituir o equipamento atual',
      'target': 4500.0,
      'current': 4500.0,
      'dueDate': DateTime.now().add(const Duration(days: 30)),
    },
  ];

  Future<void> _confirmDelete(int index) async {
    final goal = mockGoals[index];
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir meta'),
        content: Text('Deseja excluir "${goal['title']}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancelar')),
          TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Excluir')),
        ],
      ),
    );

    if (result == true) {
      setState(() {
        mockGoals.removeAt(index);
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Meta excluída')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Metas de Economia')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/new-goal'),
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text(
              'Suas Metas',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                itemCount: mockGoals.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final goal = mockGoals[index];
                  final double target = goal['target'] as double;
                  final double current = goal['current'] as double;
                  final double progress = (target == 0) ? 0 : (current / target).clamp(0.0, 1.0);

                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  goal['title'] as String,
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                'Meta: R\$ ${target.toStringAsFixed(0)}',
                                style: const TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            goal['description'] as String,
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 12),
                          LinearProgressIndicator(
                            value: progress,
                            minHeight: 8,
                            backgroundColor: Colors.grey.shade300,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              progress >= 1.0 ? Colors.green.shade700 : Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'R\$ ${current.toStringAsFixed(2)} de R\$ ${target.toStringAsFixed(2)}',
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      context.push('/new-goal');
                                    },
                                    icon: const Icon(Icons.edit, size: 20),
                                  ),
                                  IconButton(
                                    onPressed: () => _confirmDelete(index),
                                    icon: const Icon(Icons.delete, size: 20, color: Colors.redAccent),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
