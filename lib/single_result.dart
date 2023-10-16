import 'package:flutter/material.dart';
import 'package:udict/linguee_response.dart';

import 'linguee_client_repository.dart';
import 'setup.dart';

class SingleResult extends StatelessWidget {
  final LingueeResponse response;
  const SingleResult({super.key, required this.response});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(crossAxisAlignment: WrapCrossAlignment.center, spacing: 8, children: [
            Text(response.text ?? "", style: textTheme.headlineMedium),
            Text(response.pos ?? ""),
            // Text("Prular: regelmaßig")
          ]),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: response.translations!
                .where((v) => v.featured == true)
                .map((translation) {
              return TranslationUnit(translation: translation);
            }).toList(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 10),
            child: Text("Less common", style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w300, fontStyle: FontStyle.italic)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Wrap(
              spacing: 8,
              children: response.translations!
                  .where((v) => v.featured == false)
                  .map((translation) {
                return Text(translation.text!);
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}

class TranslationUnit extends StatelessWidget {
  final Translation translation;
  const TranslationUnit({super.key, required this.translation});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
        padding: EdgeInsets.only(
          left: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      getIt<LingueeClientRepository>().fetchTerm(translation.text!);
                    },
                    child: Text(translation.text ?? "", style: textTheme.headlineSmall)),
                Text(translation.pos ?? "", style: textTheme.labelLarge),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: translation.examples!.map((example) {
                return ExampleUnit(example: example);
              }).toList(),
            )
          ],
        ));
  }
}

class ExampleUnit extends StatelessWidget {
  final Example example;
  const ExampleUnit({super.key, required this.example});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(flex: 1, child: Text(example.src)),
          SizedBox(width: 10),
          Flexible(flex: 1, child: Text(example.dst))
        ],
      ),
    );
  }
}
