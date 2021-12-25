import 'package:Postly/core/check_points.dart';
import 'package:Postly/data/repository/data_repository/post_services.dart';
import 'package:Postly/data/repository/data_repository/user_services.dart';
import 'package:Postly/data/repository/database/hive_interface.dart';
import 'package:Postly/data/repository/database/hive_repository.dart';
import 'package:Postly/data/repository/database/hive_service.dart';
import 'package:Postly/features/post/domain/usecases/get_post.dart';
import 'package:Postly/features/post/presentation/notifier/post_nofifier/post_notifier.dart';
import 'package:Postly/features/post/presentation/notifier/post_nofifier/post_state.dart';
import 'package:Postly/features/user/domain/usecases/get_user.dart';
import 'package:Postly/features/user/presentation/notifier/user_notifier/user_notifier.dart';
import 'package:Postly/features/user/presentation/notifier/user_notifier/user_state.dart';
import 'package:Postly/locator.dart';
import 'package:Postly/notifier/points_notifier/points_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

final hiveNotifierProvider =
    Provider<HiveRepository>((ref) => HiveRepository());

final hiveServiceProvider = Provider<HiveServices>((ref) => HiveServices());
final checkPointsProvider = Provider<CheckPoints>((ref) => CheckPoints(ref.watch(hiveServiceProvider)));

final pointsNotifierProvider = StateNotifierProvider(
    (ref) => PointsNotifier(ref.watch(hiveServiceProvider), ref.watch(checkPointsProvider)));

final postProvider = Provider<GetPost>((ref) => GetPost(sl()));

final userProvider = Provider<GetUser>((ref) => GetUser(sl()));

final postNotifierProvider =
    StateNotifierProvider<PostNotifier, PostState>((ref) => PostNotifier(
          ref.watch(postProvider),
          ref.watch(hiveServiceProvider),
        ));

final userServicesProvider = Provider<UserServices>((ref) => UserServices());

final userNotifierProvider =
    StateNotifierProvider<UserNotifier, UserState>((ref) => UserNotifier(
          ref.watch(userProvider),
        ));
