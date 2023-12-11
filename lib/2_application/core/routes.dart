import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/2_application/core/go_router_observer.dart';
import 'package:todo_app/2_application/pages/home/home_page.dart';
import 'package:todo_app/2_application/pages/settings/settings_page.dart';

final GlobalKey<NavigatorState> _rootNavigationKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

final routes = GoRouter(
  initialLocation: '/home/dashboard',
  navigatorKey: _rootNavigationKey,
  observers: [GoRouterObserver()],
  routes: [
    GoRoute(
        path: '/home/settings',
        builder: (context, state) => const SettingsPage()),

    /// ShellRoute is used for:
    /// display routes in justa subsection of the screen
    /// alongside another widget that remain constant (like BtmNavBar that switches between routes)

    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => child,
      routes: [
        GoRoute(
          path: '/home/:tab',
          builder: (context, state) => HomePage(
            key: state
                .pageKey, // every time we have state change we have a new key and rebuild it
            tab: state.pathParameters['tab'] ?? 'dashboard',
          ),
        )
      ],
    ),
  ],
);
