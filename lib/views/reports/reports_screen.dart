import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Importe para o Gráfico de Barras

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  // Dados de Exemplo para o Gráfico de Barras (Despesas Mensais)
  final List<double> monthlyExpenses = const [
    2500, // Janeiro
    3000, // Fevereiro
    2800, // Março
    3500, // Abril
    3200, // Maio
    4000, // Junho
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Relatórios Analíticos')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Despesas nos Últimos 6 Meses',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Compare seu gasto mensal e identifique tendências.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 30),

            // Ocupa um espaço definido para o gráfico
            SizedBox(
              height: 300,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 5000, // Valor máximo do eixo Y
                  barTouchData: BarTouchData(
                    enabled: false,
                  ), // Desabilita interatividade simples
                  // Configuração dos Títulos (Eixos X e Y)
                  titlesData: FlTitlesData(
                    show: true,
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    // Eixo X: Meses
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: getTitles,
                        reservedSize: 30,
                      ),
                    ),
                    // Eixo Y: Valores
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: leftTitles,
                      ),
                    ),
                  ),

                  // Estilo da Grade
                  gridData: const FlGridData(
                    show: true,
                    drawHorizontalLine: true,
                    drawVerticalLine: false,
                  ),

                  // Dados das Barras
                  barGroups: monthlyExpenses.asMap().entries.map((entry) {
                    final index = entry.key;
                    final value = entry.value;
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: value,
                          color: Theme.of(context)
                              .colorScheme
                              .error, // Cor de destaque para despesa (vermelho)
                          width: 15,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Outros cards de relatório podem vir aqui...
            ListTile(
              leading: const Icon(Icons.compare),
              title: const Text('Comparativo Anual'),
              subtitle: const Text(
                'Veja seu desempenho comparado ao ano anterior.',
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Detalhe por Categoria'),
              subtitle: const Text('Análise detalhada de cada tipo de gasto.'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  // Função auxiliar para os títulos do Eixo X (Meses)
  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    final List<String> titles = ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun'];

    Widget text;
    if (value.toInt() >= 0 && value.toInt() < titles.length) {
      text = Text(titles[value.toInt()], style: style);
    } else {
      text = const Text('', style: style);
    }

    return SideTitleWidget(axisSide: meta.axisSide, space: 4, child: text);
  }

  // Função auxiliar para os títulos do Eixo Y (Valores)
  Widget leftTitles(double value, TitleMeta meta) {
    if (value == meta.max) return Container(); // Não exibe o título máximo

    // Simplifica a exibição do valor (R$ 1k, R$ 2k, etc.)
    final String text = value == 0 ? 'R\$ 0' : 'R\$ ${value ~/ 1000}k';

    return Text(
      text,
      style: const TextStyle(color: Colors.grey, fontSize: 10),
      textAlign: TextAlign.left,
    );
  }
}
