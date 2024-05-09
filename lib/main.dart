import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:udict/route_generator.dart';
import 'setup.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupGetIt();
  registerDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MaterialApp(
        initialRoute: "/",
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
        title: 'Lingua',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
          brightness: Brightness.light,
          snackBarTheme:
              SnackBarThemeData(backgroundColor: Colors.black.withOpacity(0.5)),
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
