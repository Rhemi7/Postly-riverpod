import 'package:Postly/data/repository/database/hive_repository.dart';
import 'package:Postly/data/repository/database/hive_service.dart';
import 'package:Postly/features/post/data/data_sources/post_local_data_source.dart';
import 'package:Postly/features/post/data/data_sources/post_remote_data_source.dart';
import 'package:Postly/features/post/data/repositories/post_repository_impl.dart';
import 'package:Postly/features/post/domain/repositories/post_repository.dart';
import 'package:Postly/features/post/domain/usecases/get_post.dart';
import 'package:Postly/notifier/points_notifier/points_notifier.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';

import 'core/platform/network_info.dart';
import 'data/data_provider/api_client.dart';
import 'data/repository/data_repository/post_services.dart';
import 'data/repository/data_repository/user_services.dart';
import 'features/post/presentation/notifier/post_nofifier/post_notifier.dart';

GetIt sl = GetIt.instance;

Future<void> setUpLocator() async {
  sl.registerLazySingleton<HiveServices>(() => HiveServices());

  sl.registerLazySingleton<HiveRepository>(() => HiveRepository());
  sl.registerLazySingleton<UserServices>(() => UserServices());
  sl.registerLazySingleton<PostServices>(() => PostServices());
  sl.registerLazySingleton<ApiClient>(() => ApiClient());

  sl.registerLazySingleton(() => PostNotifier(sl(), sl()));
  sl.registerLazySingleton(() => PointsNotifier(sl()));
  // sl.registerLazySingleton(() => UserN)

  sl.registerLazySingleton<PostRepository>(() => PostRepositoryImpl(
      postRemoteDataSource: sl(),
      postLocalDataSource: sl(),
      networkInfo: sl()));

  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl());
  sl.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImpl(hiveRepository: sl()));
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerLazySingleton<GetPost>(() => GetPost(sl()));

  sl.registerLazySingleton(() => DataConnectionChecker());
}
