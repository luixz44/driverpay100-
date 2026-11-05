import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Importe as telas
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/auth/reset_password_screen.dart';
import '../screens/dashboard_screen.dart';
import '../screens/vehicles_screen.dart';
import '../screens/rides_screen.dart';
import '../screens/expenses_screen.dart';
import '../screens/obd2_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/reports_screen.dart';
import '../components/layout/app_layout.dart'; // Componente de Shell/Sidebar/Topbar

/// Notificador de estado global de autenticação para o GoRouter
class AuthStateNotifier extends ChangeNotifier {
  bool _isAuthenticated = false;
  bool _isLoading = true;

  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;

  void setAuthenticated(bool status) {
    _isAuthenticated = status;
    _isLoading = false;
    notifyListeners();
  }
}

final authStateNotifier = AuthStateNotifier();

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  refreshListenable: authStateNotifier,
  redirect: (BuildContext context, GoRouterState state) {
    if (authStateNotifier.isLoading) return null;

    final isLoggingIn = state.matchedLocation == '/login' ||
        state.matchedLocation == '/register' ||
        state.matchedLocation == '/reset-password';

    // PrivateRoute: Se não estiver autenticado e tentar acessar rotas privadas -> /login
    if (!authStateNotifier.isAuthenticated && !isLoggingIn) {
      return '/login';
    }

    // PublicRoute: Se estiver autenticado e tentar acessar login/registro -> /
    if (authStateNotifier.isAuthenticated && isLoggingIn) {
      return '/';
    }

    return null;
  },
  routes: <RouteBase>[
    // --- ROTAS PÚBLICAS (PublicRoute) ---
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/reset-password',
      builder: (context, state) => const ResetPasswordScreen(),
    ),

    // --- ROTAS PRIVADAS DENTRO DO LAYOUT PRINCIPAL (PrivateRoute + Shell) ---
    ShellRoute(
      builder: (context, state, child) {
        return AppLayout(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: '/vehicles',
          builder: (context, state) => const VehiclesScreen(),
        ),
        GoRoute(
          path: '/rides',
          builder: (context, state) => const RidesScreen(),
        ),
        GoRoute(
          path: '/expenses',
          builder: (context, state) => const ExpensesScreen(),
        ),
        GoRoute(
          path: '/obd2',
          builder: (context, state) => const OBD2Screen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: '/reports',
          builder: (context, state) => const ReportsScreen(),
        ),
      ],
    ),
  ],
);