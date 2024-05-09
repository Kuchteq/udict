import 'package:flutter/material.dart';
import 'package:udict/linguee_client_repository.dart';
import 'package:udict/search_bottom.dart';
import 'package:udict/single_result.dart';
import 'setup.dart';

class LingueeScreen extends StatefulWidget {
  const LingueeScreen({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<LingueeScreen> createState() => _LingueeScreenState();
}

class _LingueeScreenState extends State<LingueeScreen> {
  void fetchResults(String text) {
    lingueeClient.currentQuery = text;
    lingueeClient.fetchTerm(text);
  }

  final LingueeClientRepository lingueeClient = getIt<LingueeClientRepository>();


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) { 
         LingueeClientRepository client =  getIt<LingueeClientRepository>();
         client.termStream.add(client.termsStack.value.removeLast());
      },
      child: Scaffold(
        appBar: AppBar(
          title: ValueListenableBuilder(
              valueListenable: lingueeClient.state,
              builder: (context, value, _) {
                return value == ClientState.load
                    ? const CircularProgressIndicator()
                    : lingueeClient.currentQuery != ""
                        ? Text("Results for ${lingueeClient.currentQuery}")
                        : const SizedBox.shrink();
              }),
          actions: [
            IconButton(
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Which server?'),
                      content: ValueListenableBuilder(
                          valueListenable: lingueeClient.server,
                          builder: (context, va, _) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                RadioListTile(
                                  title: const Text('Local'),
                                  value: "http://127.0.0.1:8000",
                                  groupValue: lingueeClient.server.value,
                                  onChanged: (value) {
                                    lingueeClient.server.value = value;
                                  },
                                ),
                                RadioListTile(
                                  title: const Text('Server'),
                                  value: "https://example.com/linguee",
                                  groupValue: lingueeClient.server.value,
                                  onChanged: (value) {
                                    lingueeClient.server.value = value;
                                  },
                                ),
                                RadioListTile(
                                  title: const Text('Public server'),
                                  value: "https://linguee-api.fly.dev",
                                  groupValue: lingueeClient.server.value,
                                  onChanged: (value) {
                                    lingueeClient.server.value = value;
                                  },
                                ),
                              ],
                            );
                          }),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Dismiss'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.settings))
          ],
        ),
        body: StreamBuilder(
          stream: lingueeClient.termStream.stream,
          builder: (context, snapshot) {
            //if (value == ClientState.load) return const CircularProgressIndicator();
      
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.menu_book, size: 40),
                  SizedBox(width: 10),
                  Text("Your Linguee's best client"),
                ],
              ));
            } else if (snapshot.hasError) {
              return const Center(child: Text("Can't retrieve udictlation from Linguee Api"));
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomScrollView(
                    // Center is a layout widget. It takes a single child and positions it
                    // in the middle of the parent.
                    slivers: [
                      SliverList(
                          delegate: SliverChildBuilderDelegate(
                              childCount: snapshot.data?.length,
                              (context, index) =>
                                  SingleResult(response: snapshot.data![index]))),
                      const SliverPadding(padding: EdgeInsets.only(top: 80))
                    ]),
              );
            }
            debugPrint(snapshot.data.toString());
            return const Center(child: Text("Nothing"));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SearchBottom(onSubmitted: fetchResults)
      ),
    );
  }
}
