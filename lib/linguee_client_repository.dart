import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:udict/linguee_response.dart';

class LingueeClientRepository {
  String? currentQuery = "";
  ValueNotifier<String?> server = ValueNotifier("https://example.com/linguee");

  ValueNotifier<ClientState> state = ValueNotifier<ClientState>(ClientState.start);
  ValueNotifier<List<List<LingueeResponse>>> termsStack =
      ValueNotifier<List<List<LingueeResponse>>>([]);
  StreamController<List<LingueeResponse>> termStream = StreamController();
  List<LingueeResponse> currentResponses =
      <LingueeResponse>[]; // In reality they're also previous responses

  void fetchTerm(String query) async {
    if (currentResponses != []) {
      termsStack.value.add(currentResponses);
    }
    currentResponses = [];
    state.value = ClientState.load;
    final response = await http.get(Uri.parse(
        '${server.value}/api/v2/translations?query=$query&src=de&dst=en&guess_direction=true'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      jsonDecode(utf8.decode(response.bodyBytes)).forEach((v) {
        currentResponses.add(LingueeResponse.fromJson(v));
      });
      termStream.sink.add(currentResponses);
      state.value = ClientState.done;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      termStream.sink.addError(ErrorTypes.lingueeBlock);
      state.value = ClientState.done;
      throw Exception('Stupid Linguee blocking requests');
    }
  }
}

enum ClientState {
  start,
  load,
  done,
}

enum ErrorTypes { lingueeBlock, noResults }
