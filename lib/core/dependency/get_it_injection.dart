import '../../helper/local_db/local_db.dart';
import '../../service/api_service.dart';
import '../network/connection_checker.dart';
import 'export_path.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {

  serviceLocator.registerFactory(() => InternetConnection());

  /// core
  serviceLocator.registerFactory<ConnectionChecker>(() => ConnectionCheckerImpl(serviceLocator()));

  /// ===================== DB =====================
  serviceLocator.registerFactory<DBHelper>(() => DBHelper());


  /// ================= Api client ================
  serviceLocator.registerFactory<ApiClient>(() => ApiClient());
}
