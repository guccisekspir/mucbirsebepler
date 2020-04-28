import 'package:get_it/get_it.dart';
import 'package:mucbirsebepler/data/authApiClient.dart';
import 'package:mucbirsebepler/data/authRepository.dart';


GetIt getIt= GetIt.instance;


void setupLocator(){
  getIt.registerLazySingleton<AuthRepository>(() =>AuthRepository());
  getIt.registerLazySingleton<AuthApiClient>(() =>AuthApiClient());
}