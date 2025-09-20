import 'package:flutter_batch_9_project/data/local_storage/auth_local_storage.dart';
import 'package:flutter_batch_9_project/data/local_storage/theme_local_storage.dart';
import 'package:flutter_batch_9_project/data/remote_data/network_service/network_service.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

final getIt = GetIt.instance;

Future<void> setupInjector() async {
  await hiveInjector();  
  localStorageInjector();
  networkInjector();
}

Future<void> hiveInjector() async {
  final appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  var box = await Hive.openBox('app');
  getIt.registerSingleton<Box>(box);
}

void localStorageInjector() {
  getIt.registerSingleton(AuthLocalStorage(getIt.get<Box>()));
  getIt.registerSingleton(ThemeLocalStorage(getIt.get<Box>()));
}

void networkInjector() {
  final networkService = NetworkService(
    getIt.get<AuthLocalStorage>()
  );
  getIt.registerSingleton(networkService);
  // TODO: create singleton
}