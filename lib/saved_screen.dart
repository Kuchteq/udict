import 'package:flutter/material.dart';
import 'package:udict/linguee_response.dart';
import 'package:udict/single_result.dart';

import 'setup.dart';

class SavedTranslation extends StatelessWidget {
  final String term;
  final Translation translation;
  const SavedTranslation({super.key, required this.term, required this.translation});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Wrap(crossAxisAlignment: WrapCrossAlignment.center, spacing: 8, children: [
            Text(term ?? "", style: textTheme.headlineMedium),
            // Text(response.pos ?? ""),
            // Text("Prular: regelmaßig")
          ]),
          TranslationUnit(translation: translation, source: "")
        ]));
  }
}

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  final GlobalState globalState = getIt<GlobalState>();
  List<SavedTranslations> saved = [];

  void requestSaved() async {
      saved = await SavedTranslations.fetch();
    setState(() {
            saved=saved;
    });
  }

  @override
  void initState() {
    // Add a listener to the FocusNode to check keyboard visibility changes.
    // keyFocusNode.addListener(onKeyFocusChange);
    super.initState();
    requestSaved();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Saved translations")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            slivers: [
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      childCount: saved.length,
                      (context, i) => SavedTranslation(
                          term: saved[i].source, translation: saved[i].translation)))
            ]),
      ),
    );
  }
}
