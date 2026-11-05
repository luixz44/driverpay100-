import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../main.dart'; // Import do themeNotifier para alteração do tema
import '../../routes/app_routes.dart'; // Import do authStateNotifier para gestão do login

class NavItemData {
  final String path;
  final IconData icon;
  final String label;

  const NavItemData({
    required this.path,
    required this.icon,
    required this.label,
  });
}

/// Mapeamento dos itens de navegação[cite: 19]
const List<NavItemData> navItems = [
  NavItemData(path: '/', icon: Icons.dashboard_outlined, label: 'Dashboard'),
  NavItemData(path: '/vehicles', icon: Icons.directions_car_outlined, label: 'Veículos'),
  NavItemData(path: '/rides', icon: Icons.navigation_outlined, label: 'Corridas'),
  NavItemData(path: '/expenses', icon: Icons.credit_card_outlined, label: 'Despesas'),
  NavItemData(path: '/obd2', icon: Icons.memory_outlined, label: 'OBD2'),
  NavItemData(path: '/reports', icon: Icons.description_outlined, label: 'Relatórios'),
  NavItemData(path: '/profile', icon: Icons.person_outline, label: 'Perfil'),
];

/// Títulos dinâmicos do ecrã[cite: 19]
final Map<String, String> pageTitles = {
  '/': 'Dashboard',
  '/vehicles': 'Veículos',
  '/rides': 'Corridas',
  '/expenses': 'Despesas',
  '/obd2': 'OBD2 Bluetooth',
  '/reports': 'Relatórios',
  '/profile': 'Meu Perfil',
};

class AppLayout extends StatelessWidget {
  final Widget child;

  const AppLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouterState.of(context).matchedLocation;
    final title = pageTitles[currentPath] ?? 'DriverApp';
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // Topbar / AppBar[cite: 19]
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: [
          // Avatar e informações do utilizador[cite: 19]
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  radius: 18,
                  child: const Text(
                    'M',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 8),
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (MediaQuery.of(context).size.width > 600) {
                      return const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Motorista',
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'motorista@email.com',
                            style: TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      // Drawer responsável pela Sidebar no mobile e web[cite: 19]
      drawer: _buildSidebar(context, currentPath, isDark),
      body: SafeArea(child: child),
    );
  }

  Widget _buildSidebar(BuildContext context, String currentPath, bool isDark) {
    return Drawer(
      child: Column(
        children: [
          // Logótipo e cabeçalho da barra lateral[cite: 19]
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.directions_car, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'DriverApp',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Gestão de Motoristas',
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Botão para alternar tema (ThemeToggle)[cite: 19]
          ListTile(
            leading: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              size: 20,
            ),
            title: Text(isDark ? 'Modo Claro' : 'Modo Escuro'),
            onTap: () {
              themeNotifier.value = isDark ? ThemeMode.light : ThemeMode.dark;
            },
          ),
          const Divider(height: 1),

          // Lista de navegação principal[cite: 19]
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              children: navItems.map((item) {
                final isActive = currentPath == item.path;
                return ListTile(
                  leading: Icon(
                    item.icon,
                    size: 20,
                    color: isActive
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                  title: Text(
                    item.label,
                    style: TextStyle(
                      fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                      color: isActive
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                  selected: isActive,
                  selectedTileColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onTap: () {
                    Navigator.pop(context); // Fecha o menu lateral
                    context.go(item.path);
                  },
                );
              }).toList(),
            ),
          ),

          const Divider(height: 1),

          // Botão para fechar a sessão (Logout)[cite: 19]
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.logout, size: 20, color: Colors.red),
              title: const Text(
                'Sair',
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
              ),
              onTap: () {
                Navigator.pop(context);
                authStateNotifier.setAuthenticated(false);
                context.go('/login');
              },
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../main.dart';
import '../ui/theme_toggle.dart'; // Certifique-se de importar o ThemeToggle

class AppLayout extends StatelessWidget {
  final Widget child;

  const AppLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouterState.of(context).matchedLocation;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DriverApp',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: [
          // 1. O SEU THEMETOGGLE AQUI NA BARRA SUPERIOR:
          ThemeToggle(
            isDark: isDark,
            onToggle: () {
              themeNotifier.value = isDark ? ThemeMode.light : ThemeMode.dark;
            },
          ),

          const SizedBox(width: 8),

          // Avatar do utilizador
          const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 16,
              child: Text('M'),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              child: Center(
                child: Text('DriverApp', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ),

            // 2. OU SE PREFERIR DENTRO DO MENU LATERAL (DRAWER):
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(isDark ? 'Modo Escuro' : 'Modo Claro'),
                  ThemeToggle(
                    isDark: isDark,
                    onToggle: () {
                      themeNotifier.value = isDark ? ThemeMode.light : ThemeMode.dark;
                    },
                  ),
                ],
              ),
            ),

            const Divider(),

            // Outros itens de navegação aqui...
          ],
        ),
      ),
      body: SafeArea(child: child),
    );
  }
}