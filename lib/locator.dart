import 'package:get_it/get_it.dart';
import 'package:mucbirsebepler/data/authApiClient.dart';
import 'package:mucbirsebepler/data/authRepository.dart';
import 'package:mucbirsebepler/data/dbApiClient.dart';
import 'package:mucbirsebepler/data/dbRepository.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository());
  getIt.registerLazySingleton<AuthApiClient>(() => AuthApiClient());
  getIt.registerLazySingleton<DbApiClient>(() => DbApiClient());
  getIt.registerLazySingleton<DbRepository>(() => DbRepository());
}
