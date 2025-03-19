import 'package:get_it/get_it.dart';

import 'local_storage_service.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<LocalStorageService>(
    () => LocalStorageService(),
  );
}
