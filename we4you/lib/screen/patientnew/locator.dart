import 'package:get_it/get_it.dart';
import 'package:we4you/screen/patientnew/CRUDModel.dart';
import 'package:we4you/screen/patientnew/api.dart';

GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  locator.registerLazySingleton(() => Apiz('data'));

  locator.registerLazySingleton(() => CRUDModel());
}
