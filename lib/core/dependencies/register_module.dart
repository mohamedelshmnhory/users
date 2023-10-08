import 'package:injectable/injectable.dart';

import '../services/storage_service.dart';

@module
abstract class RegisterModule {
  StorageService get storageService => StorageServiceFactory.create();
}

// // Wherever you use storageService, you should await it:
// final storageService = await getIt<RegisterModule>().storageService;
