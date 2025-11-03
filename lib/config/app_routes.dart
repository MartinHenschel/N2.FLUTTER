import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/main_scaffold.dart';

import '../views/auth/login_screen.dart';
import '../views/auth/signup_screen.dart';
import '../views/auth/recovery_screen.dart';

import '../views/dashboard/dashboard_screen.dart';
import '../views/transactions/history_screen.dart';
import '../views/goals/goals_screen.dart';
import '../views/reports/reports_screen.dart';
import '../views/profile/profile_screen.dart';

import '../views/transactions/expense_form_screen.dart';
import '../views/transactions/revenue_form_screen.dart';
import '../views/goals/goal_creation_screen.dart';
import '../views/settings/recurring_screen.dart';
import '../views/settings/categories_screen.dart';

class AppRoutes {
  
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/recovery',
        builder: (context, state) => const RecoveryScreen(),
      ),

      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return MainScaffold(child: child);
        },
        routes: [
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
