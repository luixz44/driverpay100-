import 'package:flutter/material.dart';
import 'api/api_client.dart';
import 'routes/app_routes.dart';

void main() async {
  // Garante a inicialização das rotinas do Flutter antes de rodar o app
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const DriverApp());
}

class DriverApp extends StatelessWidget {
  const DriverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'DriverApp - Gestão Financeira',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A73E8),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
      ),
      // Associa a árvore de rotas mapeada no appRouter
      routerConfig: appRouter,
    );
  }
}