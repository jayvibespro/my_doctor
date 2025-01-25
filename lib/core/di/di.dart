import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 08|01|2025
* */

final getIt = GetIt.instance;

@InjectableInit()
Future<void> initDependencies() async {
  $initGetIt(getIt);
}
