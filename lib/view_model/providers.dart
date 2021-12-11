import 'package:Postly/data/repository/data_repository/post_services.dart';
import 'package:Postly/data/repository/data_repository/user_services.dart';
import 'package:Postly/data/repository/database/hive_interface.dart';
import 'package:Postly/data/repository/database/hive_repository.dart';
import 'package:Postly/notifier/points_notifier/points_notifier.dart';
import 'package:Postly/notifier/post_nofifier/post_notifier.dart';
import 'package:Postly/notifier/post_nofifier/post_state.dart';
import 'package:Postly/notifier/user_notifier/user_notifier.dart';
import 'package:Postly/notifier/user_notifier/user_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final hiveNotifierProvider =
    Provider<HiveRepository>((ref) => HiveRepository());

final pointsNotifierProvider = StateNotifierProvider(
    (ref) => PointsNotifier(ref.watch(hiveNotifierProvider)));

final postServicesProvider = Provider<PostServices>((ref) => PostServices());

final postNotifierProvider =
    StateNotifierProvider<PostNotifier, PostState>((ref) => PostNotifier(
          ref.watch(postServicesProvider),
          ref.watch(hiveNotifierProvider),
        ));

final userServicesProvider = Provider<UserServices>((ref) => UserServices());

final userNotifierProvider =
    StateNotifierProvider<UserNotifier, UserState>((ref) => UserNotifier(
          ref.watch(userServicesProvider),
          ref.watch(hiveNotifierProvider),
        ));
