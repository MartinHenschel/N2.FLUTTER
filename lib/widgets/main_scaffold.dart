import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScaffold extends StatelessWidget {
  // O widget 'child' é a tela atual (Dashboard, History, etc.) que será exibida acima da barra.
  final Widget child;

  const MainScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // A rota atual (ex: /dashboard) é pega do GoRouter para sabermos qual ícone destacar.
    final String location = GoRouterState.of(context).uri.toString();

    // Define os itens da barra de navegação
    final List<BottomNavigationBarItem> navItems = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.dashboard),
        label: 'Início',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.history),
        label: 'Histórico',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.track_changes),
        label: 'Metas',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.analytics),
        label: 'Relatórios',
      ),
      const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
    ];

    // Define os caminhos das 5 rotas principais na ordem correta
    const List<String> paths = [
      '/dashboard',
      '/history',
      '/goals',
      '/reports',
      '/profile',
    ];

    // Determina qual item deve estar ativo (selecionado)
    int getIndexForLocation(String location) {
      for (int i = 0; i < paths.length; i++) {
        // Verifica se a rota atual começa com o caminho da lista (útil para sub-rotas)
        if (location.startsWith(paths[i])) {
          return i;
        }
      }
      return 0; // Padrão: Dashboard
    }

    // Índice atualmente selecionado
    final int currentIndex = getIndexForLocation(location);

    return Scaffold(
      // O 'child' é a tela que está sendo exibida (Dashboard, History, etc.)
      body: child,

      // A barra de navegação em si
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType
            .fixed, // Garante que todos os ícones sejam exibidos
        currentIndex: currentIndex,
        items: navItems,
        onTap: (index) {
          // Quando um item é clicado, navega para o caminho correspondente
          context.go(paths[index]);
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Usar push para empilhar a tela de adicionar despesa.
          // Assim, `context.pop()` na tela de formulário funcionará e
          // o botão 'Cancelar' voltará corretamente para a tela anterior.
          context.push('/add-expense');
        },
        child: const Icon(Icons.add),
      ),
      // Posiciona o FAB flutuando acima da barra para não sobrepor o item central
      // (evita que o botão '+' fique em cima da opção 'Metas').
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
