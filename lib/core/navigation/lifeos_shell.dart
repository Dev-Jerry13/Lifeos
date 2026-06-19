import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/premium_scaffold.dart';
import '../widgets/quick_add_sheet.dart';

class LifeOSShell extends StatelessWidget {
  const LifeOSShell({required this.child, super.key});

  final Widget child;

  static const _routes = ['/', '/tasks', '/habits', '/journal', '/profile'];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final index = _routes.indexWhere((route) => route == location).clamp(0, _routes.length - 1) as int;
    return Scaffold(
      body: PremiumScaffold(child: SafeArea(child: child)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showQuickAddSheet(context),
        elevation: 2,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Quick add'),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) => context.go(_routes[value]),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard_rounded), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.check_circle_outline), selectedIcon: Icon(Icons.check_circle_rounded), label: 'Tasks'),
          NavigationDestination(icon: Icon(Icons.repeat_rounded), selectedIcon: Icon(Icons.local_fire_department_rounded), label: 'Habits'),
          NavigationDestination(icon: Icon(Icons.edit_note_rounded), selectedIcon: Icon(Icons.menu_book_rounded), label: 'Journal'),
          NavigationDestination(icon: Icon(Icons.person_outline_rounded), selectedIcon: Icon(Icons.person_rounded), label: 'Profile'),
        ],
      ),
    );
  }
}
