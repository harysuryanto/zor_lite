import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'screens/add_plan_screen.dart';
import 'screens/detail_plan_screen.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Firebase configurations from FlutterFire CLI
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// Turn off the # in the URLs on the web
  GoRouter.setUrlPathStrategy(UrlPathStrategy.path);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User?>.value(
          value: FirebaseAuth.instance.authStateChanges(),
          initialData: null,
        ),
      ],
      child: CupertinoApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Zor Lite',
        theme: CupertinoThemeData(
          brightness: Brightness.light,
          primaryColor: CupertinoColors.systemOrange,
          barBackgroundColor: CupertinoColors.systemGrey.withOpacity(0.2),
        ),
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
      ),
    );
  }

  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/detail-plan',
        builder: (context, state) {
          final String planId = state.queryParams['planId']!;
          final String planName = state.queryParams['planName']!;

          return DetailPlanScreen(planId: planId, planName: planName);
        },
      ),
      GoRoute(
        path: '/add-plan',
        builder: (context, state) => const AddPlanScreen(),
      ),
    ],
    initialLocation: '/',
    // redirect: (state) {
    //   /// Check wheter the user has logged in or not
    //   final bool isLoggedIn = FirebaseAuth.instance.currentUser != null;

    //   /// Check wheter the user is in login screen
    //   final inLoginScreen = state.subloc == '/login';

    //   /// Will redirect to login screen if the user is not logged in
    //   /// and is not in login screen
    //   if (!isLoggedIn && !inLoginScreen) {
    //     return '/login';
    //   }

    //   /// Will redirect to home screen if the user has logged in
    //   /// and is in login screen
    //   if (isLoggedIn && inLoginScreen) {
    //     return '/';
    //   }

    //   return null;
    // },
  );
}
