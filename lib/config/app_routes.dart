import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Importe o MainScaffold (que você criou em /widgets)
import '../widgets/main_scaffold.dart'; // CORRETO: Sobe um nível e entra em widgets

// 1. Importe as 13 Telas (REMOVIDO O '/lib')
import '../views/auth/login_screen.dart'; // CORRETO
import '../views/auth/signup_screen.dart'; // CORRETO
import '../views/auth/recovery_screen.dart'; // CORRETO

import '../views/dashboard/dashboard_screen.dart'; // CORRETO
import '../views/transactions/history_screen.dart'; // CORRETO
import '../views/goals/goals_screen.dart'; // CORRETO
import '../views/reports/reports_screen.dart'; // CORRETO
import '../views/profile/profile_screen.dart'; // CORRETO

import '../views/transactions/expense_form_screen.dart'; // CORRETO
import '../views/transactions/revenue_form_screen.dart'; // CORRETO
import '../views/goals/goal_creation_screen.dart'; // CORRETO
import '../views/settings/recurring_screen.dart'; // CORRETO
import '../views/settings/categories_screen.dart'; // CORRETO

class AppRoutes {
  // O restante do código (GlobalKey e GoRouter) permanece o mesmo e está correto.
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    navigatorKey: _rootNavigatorKey,
    routes: [
      // ROTAS DE AUTENTICAÇÃO
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/recovery',
        builder: (context, state) => const RecoveryScreen(),
      ),

      // SHELL ROUTE
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return MainScaffold(child: child);
        },
        routes: [
          // 5 TELAS PRINCIPAIS
          GoRoute(
            path: '/dashboard',
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: '/history',
            builder: (context, state) => const HistoryScreen(),
          ),
          GoRoute(
            path: '/goals',
            builder: (context, state) => const GoalsScreen(),
          ),
          GoRoute(
            path: '/reports',
            builder: (context, state) => const ReportsScreen(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),

      // ROTAS DE FORMULÁRIO
      GoRoute(
        path: '/add-expense',
        builder: (context, state) => const ExpenseFormScreen(),
      ),
      GoRoute(
        path: '/add-revenue',
        builder: (context, state) => const RevenueFormScreen(),
      ),
      GoRoute(
        path: '/new-goal',
        builder: (context, state) => const GoalCreationScreen(),
      ),
      GoRoute(
        path: '/recurring',
        builder: (context, state) => const RecurringScreen(),
      ),
      GoRoute(
        path: '/categories',
        builder: (context, state) => const CategoriesScreen(),
      ),
    ],
  );
}
