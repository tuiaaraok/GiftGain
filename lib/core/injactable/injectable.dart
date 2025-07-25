import 'package:injectable/injectable.dart';

// ignore: depend_on_referenced_packages
import 'package:get_it/get_it.dart';
import 'injectable.config.dart';

final getIt = GetIt.instance;
@InjectableInit(
  initializerName: 'init',
  asExtension: true,
  usesNullSafety: true,
)
// ignore: await_only_futures
Future<void> configureDependencies() async => await getIt.init();
