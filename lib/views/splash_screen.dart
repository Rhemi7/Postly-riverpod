import 'package:Postly/data/repository/database/hive_repository.dart';
import 'package:Postly/features/post/data/models/posts/post.dart';
import 'package:Postly/features/user/data/models/user/user.dart';
import 'package:Postly/locator.dart';
import 'package:Postly/utils/constants.dart';
import 'package:Postly/view_model/postly_view_model.dart';
import 'package:Postly/view_model/providers.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    controller.forward();

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse(from: 5.0);
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
        _prepareAppState();
      }
    });
    controller.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  var _hiveRepository = sl<HiveRepository>();

  // function checks to see if there is a user locally
  _prepareAppState() async {
    await HiveRepository.openHives([kUserBox, kPostBox, kPointsBox]);
    context.read(postNotifierProvider.notifier).getPosts();
    context.read(userNotifierProvider.notifier).getUser();
    context.read(pointsNotifierProvider.notifier).getPoints();

    // viewModel.setPosts(posts);
    // viewModel.posts = posts;
    Navigator.pushReplacementNamed(context, POST_SCREEN_ROUTE);
    User user;
    List<Post> posts = [];
    int point;

    try {
      // user = _hiveRepository.get<User>(key: kUser, name: kUserBox);
      // posts = _hiveRepository
      //     .get<List<Post>>(key: kPosts, name: kPostBox)
      //     .cast<Post>();
      // point = _hiveRepository.get<int>(key: kPoints, name: kPointsBox);
    } catch (ex) {
      print(ex);
    }
    // var viewModel = Provider.of<PostlyViewModel>(context, listen: false);

    // if (user == null) {
    //   //if there is no user, a  network call is made to get users and a random user selected
    //   print('user is null');
    //   // await viewModel.getUser();
    //   // await viewModel.getPost();
    //   context.read(userNotifierProvider.notifier).getUser();
    //   context.read(postNotifierProvider.notifier).getPosts();
    //
    //   Navigator.pushReplacementNamed(context, POST_SCREEN_ROUTE);
    // } else {
    //   // if there is a user locally, that user is set to the user property in view model
    //   // await viewModel.setUser(user);
    //   // await viewModel.setViewPoints(user.points);
    //   // await viewModel.getPost();
    //   context.read(postNotifierProvider.notifier).getPosts();
    //   context.read(userNotifierProvider.notifier).getUser();
    //   context.read(pointsNotifierProvider.notifier).getPoints();
    //
    //   // viewModel.setPosts(posts);
    //   // viewModel.posts = posts;
    //   Navigator.pushReplacementNamed(context, POST_SCREEN_ROUTE);
    //
    //   // this function checks the point of the user to decide if to show dialog or not
    //   // viewModel.checkPoints(context);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Image.asset(
            "assets/images/app_icon.png",
            height: controller.value * 100,
          ),
        ),
      ),
    );
  }
}
