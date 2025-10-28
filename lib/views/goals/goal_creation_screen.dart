import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GoalCreationScreen extends StatefulWidget {
  const GoalCreationScreen({super.key});

  @override
  State<GoalCreationScreen> createState() => _GoalCreationScreenState();
}

class _GoalCreationScreenState extends State<GoalCreationScreen> {
  // Controlador para o campo de data
  TextEditingController _dateController = TextEditingController(
    text: '2026-12-31',
  );

  // Função para selecionar a data
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 365)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _dateController.text =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nova Meta de Economia')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Título
            const Text(
              'Defina Seus Objetivos',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // 1. Campo de Nome/Descrição
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nome da Meta (Ex: Viagem, Carro)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.star),
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 20),

            // 2. Campo de Valor Desejado
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Valor Total Desejado (R\$)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            // 3. Campo de Data Limite
            TextFormField(
              controller: _dateController,
              readOnly: true, // Impede a digitação manual
              decoration: InputDecoration(
                labelText: 'Data Limite',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.calendar_today),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_month),
                  onPressed: () => _selectDate(context),
                ),
              ),
              onTap: () => _selectDate(context),
            ),
            const SizedBox(height: 40),

            // Botão de Salvar (AGORA COM FEEDBACK)
            ElevatedButton.icon(
              onPressed: () {
                // 1. Mostrar mensagem de sucesso (POLIMENTO)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Meta criada com sucesso! Você está no caminho certo!',
                    ),
                    backgroundColor:
                        Colors.green, // Cor de destaque para sucesso
                  ),
                );
                // 2. Navegar de volta para a tela de Metas
                Future.delayed(const Duration(milliseconds: 500), () {
                  context.go('/goals');
                });
              },
              icon: const Icon(Icons.save),
              label: const Text('Criar Meta'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
              ),
            ),

            const SizedBox(height: 10),

            // Botão de Cancelar/Voltar
            TextButton(
              onPressed: () {
                context.pop(); // Volta para a tela anterior
              },
              child: const Text('Cancelar'),
            ),
          ],
        ),
      ),
    );
  }
}
