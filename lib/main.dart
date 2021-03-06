import 'package:Postly/locator.dart';
import 'package:Postly/utils/constants.dart';
import 'package:Postly/view_model/postly_view_model.dart';
import 'package:Postly/views/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as pp;

import 'features/post/data/models/posts/post.dart';
import 'features/user/data/models/address/address.dart';
import 'features/user/data/models/company/company.dart';
import 'features/user/data/models/geo/geo.dart';
import 'features/user/data/models/user/user.dart';

void main() async {
  await _openHive();
  await setUpLocator();
  runApp(ProviderScope(child: Postly()));
}

_openHive() async {
  WidgetsFlutterBinding.ensureInitialized();
  var appDocDir = await pp.getApplicationDocumentsDirectory();
  //Inotializing hive and registering adapter class of models saved locally
  Hive
    ..init(appDocDir.path)
    ..registerAdapter(UserAdapter())
    ..registerAdapter(AddressAdapter())
    ..registerAdapter(CompanyAdapter())
    ..registerAdapter(GeoAdapter())
    ..registerAdapter(PostAdapter());
}

class Postly extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Postly',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: kBackground,
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: kPrimaryColor,
        ),
        fontFamily: "Poppins-Regular",
      ),
      onGenerateRoute: _appRouter.onGenerateRoute,
    );

    // return ChangeNotifierProvider<PostlyViewModel>(
    //   create: (context) => PostlyViewModel(),
    //   child: MaterialApp(
    //     title: 'Postly',
    //     debugShowCheckedModeBanner: false,
    //     theme: ThemeData(
    //       visualDensity: VisualDensity.adaptivePlatformDensity,
    //       scaffoldBackgroundColor: kBackground,
    //       appBarTheme: AppBarTheme(
    //         elevation: 0,
    //         color: kPrimaryColor,
    //       ),
    //       fontFamily: "Poppins-Regular",
    //     ),
    //     onGenerateRoute: _appRouter.onGenerateRoute,
    //   ),
    // );
  }
}
