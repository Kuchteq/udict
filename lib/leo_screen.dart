import 'package:flutter/material.dart';
import 'package:udict/leo_client_repository.dart';
import 'package:udict/search_bottom.dart';
import 'package:udict/setup.dart';
import 'package:udict/single_table_section.dart';

class LeoScreen extends StatefulWidget {
  const LeoScreen({super.key, required this.title});

  final String title;

  @override
  State<LeoScreen> createState() => _LeoScreenState();
}

class _LeoScreenState extends State<LeoScreen> {
  final LeoClientRepository leoClientRepository = getIt<LeoClientRepository>();

  void fetchResults(String text) {
    leoClientRepository.currentQuery = text;
    leoClientRepository.fetchTerm(text);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: ValueListenableBuilder(
                valueListenable: leoClientRepository.state,
                builder: (context, value, _) {
                  return value == ClientState.load
                      ? const CircularProgressIndicator()
                      : leoClientRepository.currentQuery != ""
                          ? Text("Results for ${leoClientRepository.currentQuery}")
                          : const SizedBox.shrink();
                })),
        floatingActionButton: SearchBottom(onSubmitted: fetchResults),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: StreamBuilder(
            stream: leoClientRepository.termStream.stream,
            builder: (context, snapshot) {
              //if (value == ClientState.load) return const CircularProgressIndicator();

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.menu_book, size: 40),
                    SizedBox(width: 10),
                    Text("Your best Leo dictionary"),
                  ],
                ));
              } else if (snapshot.hasError) {
                return const Center(
                    child: Text("Can't retrieve udictlation from Linguee Api"));
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
                                (context, index) => SingleTableSection(
                                    title: snapshot.data![index].display,
                                    translations: snapshot.data![index].translations))),
                        const SliverPadding(padding: EdgeInsets.only(top: 80))
                      ]),
                );
              }
              debugPrint(snapshot.data.toString());
              return const Center(child: Text("Nothing"));
            }));
  }
}
