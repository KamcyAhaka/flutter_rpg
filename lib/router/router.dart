import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rpg/screens/auth/signin.dart';
import 'package:flutter_rpg/screens/auth/signup.dart';
import 'package:flutter_rpg/screens/bottom_navigation_scaffold_bar.dart';
import 'package:flutter_rpg/screens/dashboard/dashboard.dart';
import 'package:flutter_rpg/screens/home/home.dart';
import 'package:flutter_rpg/services/user_store.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final UserStore _userStore = UserStore(); // Create a UserStore instance

final User? user = _userStore.currentUser;


final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) =>
          BottomNavigationBarScaffold(child: child),
      routes: [
        GoRoute(
          path: '/',
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) => const Home(),
        ),
        GoRoute(
          path: '/dashboard',
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) => const Dashboard(),
					redirect: (BuildContext context, GoRouterState state) {
						if (user == null) {
							return '/auth/signin';
						} else {
							return null;
						}
					}
        ),
        GoRoute(
          path: '/community',
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) => const Home(),
        ),
      ],
    ),
    GoRoute(
      path: '/auth/signup',
      builder: (context, state) => const SignUp(),
    ),
    GoRoute(
      path: '/auth/signin',
      builder: (context, state) => const SignIn(),
    ),
  ],
);
