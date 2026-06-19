import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/habits/presentation/habits_screen.dart';
import '../../features/journal/presentation/journal_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/tasks/presentation/tasks_screen.dart';
import 'lifeos_shell.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) => LifeOSShell(child: child),
        routes: [
          GoRoute(path: '/', pageBuilder: (context, state) => _fade(const DashboardScreen())),
          GoRoute(path: '/tasks', pageBuilder: (context, state) => _fade(const TasksScreen())),
          GoRoute(path: '/habits', pageBuilder: (context, state) => _fade(const HabitsScreen())),
          GoRoute(path: '/journal', pageBuilder: (context, state) => _fade(const JournalScreen())),
          GoRoute(path: '/profile', pageBuilder: (context, state) => _fade(const ProfileScreen())),
        ],
      ),
    ],
  );
});

CustomTransitionPage<void> _fade(Widget child) => CustomTransitionPage(
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
          child: SlideTransition(
            position: Tween(begin: const Offset(0, 0.02), end: Offset.zero).animate(animation),
            child: child,
          ),
        );
      },
    );
