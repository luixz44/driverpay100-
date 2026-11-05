import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Importação das telas de cada módulo
import '../screens/auth_screen.dart';
import '../screens/users_screen.dart';
import '../screens/vehicles_screen.dart';
import '../screens/rides_screen.dart';
import '../screens/expenses_screen.dart';
import '../screens/obd2_screen.dart';
import '../screens/dashboard_screen.dart';
import '../screens/reports_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/dashboard',
  routes: <RouteBase>[
    // Rota Raiz / Status
    GoRoute(
      path: '/',
      builder: (context, state) => const DashboardScreen(),
    ),
    // Auth Router (/api/auth)
    GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthScreen(),
    ),
    // Users Router (/api/users)
    GoRoute(
      path: '/users',
      builder: (context, state) => const UsersScreen(),
    ),
    // Vehicles Router (/api/vehicles)
    GoRoute(
      path: '/vehicles',
      builder: (context, state) => const VehiclesScreen(),
    ),
    // Rides Router (/api/rides)
    GoRoute(
      path: '/rides',
      builder: (context, state) => const RidesScreen(),
    ),
    // Expenses Router (/api/expenses)
    GoRoute(
      path: '/expenses',
      builder: (context, state) => const ExpensesScreen(),
    ),
    // OBD2 Router (/api/obd2)
    GoRoute(
      path: '/obd2',
      builder: (context, state) => const Obd2Screen(),
    ),
    // Dashboard Router (/api/dashboard)
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
    // Reports Router (/api/reports)
    GoRoute(
      path: '/reports',
      builder: (context, state) => const ReportsScreen(),
    ),
  ],
);