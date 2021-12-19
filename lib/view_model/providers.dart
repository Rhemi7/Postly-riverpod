import 'package:Postly/data/repository/data_repository/post_services.dart';
import 'package:Postly/data/repository/data_repository/user_services.dart';
import 'package:Postly/data/repository/database/hive_interface.dart';
import 'package:Postly/data/repository/database/hive_repository.dart';
import 'package:Postly/features/post/domain/usecases/get_post.dart';
import 'package:Postly/locator.dart';
import 'package:Postly/notifier/points_notifier/points_notifier.dart';
import 'package:Postly/notifier/post_nofifier/post_notifier.dart';
import 'package:Postly/notifier/post_nofifier/post_state.dart';
import 'package:Postly/notifier/user_notifier/user_notifier.dart';
import 'package:Postly/notifier/user_notifier/user_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

final hiveNotifierProvider =
    Provider<HiveRepository>((ref) => HiveRepository());

final pointsNotifierProvider = StateNotifierProvider(
    (ref) => PointsNotifier(ref.watch(hiveNotifierProvider)));

final postProvider = Provider<GetPost>((ref) => GetPost(sl()));

final postNotifierProvider =
    StateNotifierProvider<PostNotifier, PostState>((ref) => PostNotifier(
          ref.watch(postProvider),
          ref.watch(hiveNotifierProvider),
        ));

final userServicesProvider = Provider<UserServices>((ref) => UserServices());

final userNotifierProvider =
    StateNotifierProvider<UserNotifier, UserState>((ref) => UserNotifier(
          ref.watch(userServicesProvider),
          ref.watch(hiveNotifierProvider),
        ));
