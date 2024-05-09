import 'package:flutter/material.dart';
import 'package:udict/leo_screen.dart';
import 'package:udict/linguee_screen.dart';
import 'package:udict/saved_screen.dart';
import 'package:udict/setup.dart';

class RouteGenerator {
  @override
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (ctx) {
          return ValueListenableBuilder(
              valueListenable: getIt<GlobalState>().currentDict,
              builder: (BuildContext context, int value, child) {
                int dictionary = getIt<GlobalState>().currentDict.value;
                return Scaffold(
                    bottomNavigationBar: NavigationBar(
                      surfaceTintColor: Colors.transparent,
                      selectedIndex: dictionary,
                      destinations: const [
                        NavigationDestination(label: 'Linguee', icon: Icon(Icons.dehaze)),
                        NavigationDestination(label: 'Leo', icon: Icon(Icons.grid_view)),
                        NavigationDestination(label: 'Saved', icon: Icon(Icons.folder_special)),
                      ],
                      onDestinationSelected: (int idx) {
                        if(idx < 2) {
                                getIt<GlobalState>().currentDict.value = idx;
                        } else
                        {
                                Navigator.of(ctx).pushNamed("/saved");
                        }

                      },
                      height: 60,
                      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                    ),
                    body: IndexedStack(index: dictionary, children: [
                      LingueeScreen(title: "kurwa"),
                      LeoScreen(title: "jaja")
                    ]));
              });
        });
      case "/saved":
        return MaterialPageRoute(builder: (ctx) => SavedScreen());
      default:
        return errorRoute("Unexpected error");

    }
  }

  static Route<dynamic> errorRoute(String errorMsg) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text(errorMsg),
        ),
      );
    });
  }
}
