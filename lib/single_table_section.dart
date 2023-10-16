import 'package:flutter/material.dart';
import 'package:udict/leo_response.dart';

class SingleTableSection extends StatelessWidget {
  final String title;
  final List<Translation> translations;
  const SingleTableSection({super.key, required this.title, required this.translations});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title, style: textTheme.displaySmall?.copyWith(fontStyle:FontStyle.italic)),
        ),
        Material(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            elevation: 2,
            // color: color,
            // shadowColor: widget.shadowColor,
            surfaceTintColor: Theme.of(context).colorScheme.primaryContainer,
            type: MaterialType.card,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  children: translations
                      .map((v) => SingleRowResult(term: v.term, definition: v.definition))
                      .toList()),
            ))
      ]),
    );
  }
}

class SingleRowResult extends StatelessWidget {
  final String term;
  final String definition;
  const SingleRowResult({super.key, required this.term, required this.definition});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(flex: 1, child: TextButton(

  style: ButtonStyle(
    alignment: Alignment.centerLeft, // Align the text to the left
  ),
                onPressed: (){}, child:Text(term, style: textTheme.titleMedium ) )),
        Expanded(flex: 1, child: TextButton(
  style: ButtonStyle(
    alignment: Alignment.centerLeft, // Align the text to the left
  ),
                onPressed: (){}, child:Text(definition, style: textTheme.titleMedium ) )),
      ]),
    );
  }
}
