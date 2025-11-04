import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RecurringFormScreen extends StatefulWidget {
  const RecurringFormScreen({super.key});

  @override
  State<RecurringFormScreen> createState() => _RecurringFormScreenState();
}

class _RecurringFormScreenState extends State<RecurringFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  TextEditingController _startDateController = TextEditingController(text: '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2,'0')}-${DateTime.now().day.toString().padLeft(2,'0')}');

  String _type = 'expense';
  String _frequency = 'Mensal';
  String? _selectedCategory;

  final List<String> _frequencies = ['Diária', 'Semanal', 'Mensal', 'Anual'];
  final List<String> _categories = [
    'Alimentação',
    'Transporte',
    'Moradia',
    'Lazer',
    'Salário',
    'Investimentos',
  ];

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _startDateController.text = "${picked.year}-${picked.month.toString().padLeft(2,'0')}-${picked.day.toString().padLeft(2,'0')}";
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _startDateController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final Map<String, dynamic> item = {
      'title': _titleController.text.trim(),
      'amount': double.tryParse(_amountController.text.replaceAll(',', '.')) ?? 0.0,
      'type': _type,
      'frequency': _frequency,
      'startDate': _startDateController.text,
      'category': _selectedCategory,
    };

    Navigator.of(context).pop(item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Lançamento Recorrente'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Título', border: OutlineInputBorder()),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Informe um título' : null,
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Valor (R\$)', border: OutlineInputBorder(), prefixIcon: Icon(Icons.attach_money)),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Informe um valor' : null,
              ),

              const SizedBox(height: 12),

              // Tipo (Despesa / Receita)
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Despesa'),
                      value: 'expense',
                      groupValue: _type,
                      onChanged: (v) => setState(() => _type = v ?? 'expense'),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Receita'),
                      value: 'revenue',
                      groupValue: _type,
                      onChanged: (v) => setState(() => _type = v ?? 'revenue'),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Data início
              TextFormField(
                controller: _startDateController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Data de início',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.calendar_today),
                  suffixIcon: IconButton(icon: const Icon(Icons.calendar_month), onPressed: () => _selectStartDate(context)),
                ),
                onTap: () => _selectStartDate(context),
              ),

              const SizedBox(height: 12),

              // Frequência
              InputDecorator(
                decoration: const InputDecoration(labelText: 'Frequência', border: OutlineInputBorder()),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _frequency,
                    items: _frequencies.map((f) => DropdownMenuItem(value: f, child: Text(f))).toList(),
                    onChanged: (v) => setState(() => _frequency = v ?? _frequency),
                    isExpanded: true,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Categoria
              InputDecorator(
                decoration: const InputDecoration(labelText: 'Categoria (opcional)', border: OutlineInputBorder()),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedCategory,
                    hint: const Text('Selecione uma categoria'),
                    isExpanded: true,
                    items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                    onChanged: (v) => setState(() => _selectedCategory = v),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.save),
                label: const Text('Salvar Recorrente'),
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
              ),

              const SizedBox(height: 8),

              TextButton(
                onPressed: () => context.pop(),
                child: const Text('Cancelar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
