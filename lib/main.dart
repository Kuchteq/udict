import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:udict/leo_screen.dart';
import 'package:udict/linguee_client_repository.dart';
import 'package:udict/linguee_screen.dart';
import 'package:udict/single_result.dart';
import 'setup.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');

final goRouter = GoRouter(
  initialLocation: '/a',
  // * Passing a navigatorKey causes an issue on hot reload:
  // * https://github.com/flutter/flutter/issues/113757#issuecomment-1518421380
  // * However it's still necessary otherwise the navigator pops back to
  // * root on hot reload
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    // Stateful navigation based on:
    // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAKey,
          routes: [
            GoRoute(
              path: '/a',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: LingueeScreen(title: 'A'),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorBKey,
          routes: [
            // Shopping Cart
            GoRoute(
              path: '/b',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: LeoScreen(title: "afsa")),
            ),
          ],
        ),
      ],
    ),
  ],
);

// Stateful nested navigation based on:
// https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        surfaceTintColor: Colors.transparent,
        destinations: const [
          NavigationDestination(label: 'Linguee', icon: Icon(Icons.dehaze)),
          NavigationDestination(label: 'Leo', icon: Icon(Icons.grid_view)),
        ],
        onDestinationSelected: _goBranch,
        height: 60,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      ),
    );
  }
}

void main() {
  setupGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Lingua',
        routerConfig: goRouter,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
          brightness: Brightness.light,
          textTheme: TextTheme(
              headlineMedium: TextStyle(
                  color: lightColorScheme?.secondary, fontWeight: FontWeight.bold),
              headlineSmall: TextStyle(
                  color: lightColorScheme?.primary, fontWeight: FontWeight.bold),
              labelLarge:
                  TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.w400)),
        ),
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            textTheme: TextTheme(
              headlineMedium: TextStyle(
                  color: darkColorScheme?.secondary, fontWeight: FontWeight.bold),
              headlineSmall:
                  TextStyle(color: darkColorScheme?.primary, fontWeight: FontWeight.bold),
              labelLarge:
                  TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.w400),
            ),
            colorScheme: darkColorScheme,
            useMaterial3: true),
      );
    });
  }
}
