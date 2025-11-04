import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Importe para o Gráfico de Barras

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  // Dados completos (12 meses) - mocks
  final List<double> fullMonthlyExpenses = const [
    2500, // M-11
    2300,
    3000,
    2800,
    3500,
    3200,
    4000,
    2900,
    3100,
    2700,
    3300,
    3800, // M
  ];

  // Period options em meses
  final Map<String, int> periods = {
    'Últimos 3 meses': 3,
    'Últimos 6 meses': 6,
    'Últimos 12 meses': 12,
  };

  String selectedPeriodLabel = 'Últimos 6 meses';

  List<double> get displayedExpenses {
    final n = periods[selectedPeriodLabel] ?? 6;
    return fullMonthlyExpenses.sublist(fullMonthlyExpenses.length - n);
  }

  List<String> get displayedLabels {
    final monthsAbbr = ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'];
    final now = DateTime.now();
    // Build last 12 months labels ending at current month
    final fullLabels = List.generate(12, (i) {
      final dt = DateTime(now.year, now.month - 11 + i);
      return monthsAbbr[dt.month - 1];
    });
    final n = periods[selectedPeriodLabel] ?? 6;
    return fullLabels.sublist(fullLabels.length - n);
  }

  @override
  Widget build(BuildContext context) {
    final monthlyExpenses = displayedExpenses;

    return Scaffold(
      appBar: AppBar(title: const Text('Relatórios Analíticos')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Selector de período
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Despesas',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: selectedPeriodLabel,
                  items: periods.keys.map((label) {
                    return DropdownMenuItem<String>(
                      value: label,
                      child: Text(label),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val == null) return;
                    setState(() {
                      selectedPeriodLabel = val;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Compare seu gasto mensal e identifique tendências.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Apenas o gráfico
            SizedBox(
              height: 320,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: (monthlyExpenses.isEmpty) ? 0 : (monthlyExpenses.reduce((a, b) => a > b ? a : b) * 1.2),
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    show: true,
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (v, meta) => getTitles(v, meta, displayedLabels),
                        reservedSize: 30,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: leftTitles,
                      ),
                    ),
                  ),
                  gridData: const FlGridData(show: true, drawHorizontalLine: true, drawVerticalLine: false),
                  barGroups: monthlyExpenses.asMap().entries.map((entry) {
                    final index = entry.key;
                    final value = entry.value;
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: value,
                          color: Theme.of(context).colorScheme.error,
                          width: 18,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Função auxiliar para os títulos do Eixo X (Meses)
  Widget getTitles(double value, TitleMeta meta, List<String> labels) {
    const style = TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 10);
    Widget text;
    final idx = value.toInt();
    if (idx >= 0 && idx < labels.length) {
      text = Text(labels[idx], style: style);
    } else {
      text = const Text('', style: style);
    }
    return SideTitleWidget(axisSide: meta.axisSide, space: 4, child: text);
  }

  // Função auxiliar para os títulos do Eixo Y (Valores)
  Widget leftTitles(double value, TitleMeta meta) {
    if (value == meta.max) return Container();
    final String text = value == 0 ? 'R\$ 0' : 'R\$ ${value ~/ 1000}k';
    return Text(text, style: const TextStyle(color: Colors.grey, fontSize: 10), textAlign: TextAlign.left);
  }
}
