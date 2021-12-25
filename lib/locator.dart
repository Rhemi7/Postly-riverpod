import 'package:Postly/core/check_points.dart';
import 'package:Postly/data/repository/database/hive_repository.dart';
import 'package:Postly/data/repository/database/hive_service.dart';
import 'package:Postly/features/post/data/data_sources/post_local_data_source.dart';
import 'package:Postly/features/post/data/data_sources/post_remote_data_source.dart';
import 'package:Postly/features/post/data/repositories/post_repository_impl.dart';
import 'package:Postly/features/post/domain/repositories/post_repository.dart';
import 'package:Postly/features/post/domain/usecases/get_post.dart';
import 'package:Postly/features/user/data/data_sources/user_local_data_source.dart';
import 'package:Postly/features/user/data/data_sources/user_remote_date_source.dart';
import 'package:Postly/features/user/data/repositories/user_repository_impl.dart';
import 'package:Postly/features/user/domain/repositories/user_repository.dart';
import 'package:Postly/features/user/presentation/notifier/user_notifier/user_notifier.dart';
import 'package:Postly/notifier/points_notifier/points_notifier.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';

import 'core/platform/network_info.dart';
import 'data/data_provider/api_client.dart';
import 'data/repository/data_repository/post_services.dart';
import 'data/repository/data_repository/user_services.dart';
import 'features/post/presentation/notifier/post_nofifier/post_notifier.dart';
import 'features/user/domain/usecases/get_user.dart';

GetIt sl = GetIt.instance;

Future<void> setUpLocator() async {
  //Hive
  sl.registerLazySingleton<HiveServices>(() => HiveServices());

  sl.registerLazySingleton<HiveRepository>(() => HiveRepository());
  sl.registerLazySingleton<UserServices>(() => UserServices());
  sl.registerLazySingleton<PostServices>(() => PostServices());
  sl.registerLazySingleton<ApiClient>(() => ApiClient());

  //Riverpod State notifiers
  sl.registerLazySingleton(() => PostNotifier(sl(), sl()));
  sl.registerLazySingleton(() => PointsNotifier(sl(), sl()));
  sl.registerLazySingleton(() => UserNotifier(sl()));

  //Post Datasource
  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl());
  sl.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImpl(hiveRepository: sl()));

  //Post repository
  sl.registerLazySingleton<PostRepository>(() => PostRepositoryImpl(
        postRemoteDataSource: sl(),
        postLocalDataSource: sl(),
        networkInfo: sl(),
      ));

  //User Repository
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
        networkInfo: sl(),
        userLocalDataSource: sl(),
        userRemoteDataSource: sl(),
      ));

  //User Data sources
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl());
  sl.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImpl(sl()));

  //Network info
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //checkPoints
  sl.registerLazySingleton<CheckPoints>(() => CheckPoints(sl()));

  //Usecases
  sl.registerLazySingleton<GetPost>(() => GetPost(sl()));
  sl.registerLazySingleton<GetUser>(() => GetUser(sl()));

  //Data connection
  sl.registerLazySingleton(() => DataConnectionChecker());
}
