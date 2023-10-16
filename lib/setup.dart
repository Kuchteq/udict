import 'package:get_it/get_it.dart';
import 'package:udict/leo_client_repository.dart';

import 'linguee_client_repository.dart';

final getIt = GetIt.instance;


void setupGetIt() {
  // state management layer
  getIt.registerLazySingleton<LingueeClientRepository>(() => LingueeClientRepository());
  getIt.registerLazySingleton<LeoClientRepository>(() => LeoClientRepository());
}

