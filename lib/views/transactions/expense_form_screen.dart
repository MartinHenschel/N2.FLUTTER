import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExpenseFormScreen extends StatefulWidget {
  const ExpenseFormScreen({super.key});

  @override
  State<ExpenseFormScreen> createState() => _ExpenseFormScreenState();
}

class _ExpenseFormScreenState extends State<ExpenseFormScreen> {
  // Estado para o valor e a categoria selecionada
  String? _selectedCategory;
  TextEditingController _dateController = TextEditingController(
    text: '2025-05-23',
  );

  // Lista de categorias de exemplo (Idealmente viria de um serviço/provider)
  final List<String> _categories = [
    'Alimentação',
    'Transporte',
    'Moradia',
    'Lazer',
    'Saúde',
    'Educação',
    'Outros',
  ];

  // Função para selecionar a data
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2026),
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
      appBar: AppBar(title: const Text('Adicionar Despesa')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Título
            Text(
              'Nova Despesa',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(
                  context,
                ).colorScheme.error, // Vermelho para despesa
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // 1. Campo de Valor
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Valor (R\$)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.money_off),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            // 2. Campo de Descrição
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Descrição',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.description),
              ),
            ),
            const SizedBox(height: 20),

            // 3. Campo de Data (com seletor)
            TextFormField(
              controller: _dateController,
              readOnly: true, // Impede a digitação manual
              decoration: InputDecoration(
                labelText: 'Data',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.calendar_today),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_month),
                  onPressed: () => _selectDate(context),
                ),
              ),
              onTap: () => _selectDate(context), // Abre o seletor ao tocar
            ),
            const SizedBox(height: 20),

            // 4. Seletor de Categoria
            InputDecorator(
              decoration: const InputDecoration(
                labelText: 'Categoria',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.category),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedCategory,
                  hint: const Text('Selecione uma categoria'),
                  isDense: true,
                  isExpanded: true,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue;
                    });
                  },
                  items: _categories.map<DropdownMenuItem<String>>((
                    String value,
                  ) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Botão de Salvar (AGORA COM FEEDBACK)
            ElevatedButton.icon(
              onPressed: () {
                // 1. Mostrar mensagem de sucesso (POLIMENTO)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Despesa registrada com sucesso!'),
                    backgroundColor:
                        Colors.green, // Cor de destaque para sucesso
                  ),
                );
                // 2. Navegar de volta para a Dashboard
                Future.delayed(const Duration(milliseconds: 500), () {
                  context.go('/dashboard');
                });
              },
              icon: const Icon(Icons.save),
              label: const Text('Salvar Despesa'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.error, // Cor de destaque para despesa
                foregroundColor: Colors.white,
              ),
            ),

            const SizedBox(height: 10),

            // Botão de Cancelar/Voltar
            TextButton(
              onPressed: () {
                context.pop(); // Volta para a tela anterior (Dashboard)
              },
              child: const Text('Cancelar'),
            ),
          ],
        ),
      ),
    );
  }
}
