import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:igclone/responsive/mobilescreenlayout.dart';
import 'package:igclone/responsive/webscreenlayout.dart';
import 'package:igclone/views/pages/commentspage.dart';
import 'package:igclone/views/pages/loginpage.dart';
import 'package:igclone/responsive/responsivelayout.dart';

// Define your GoRouter instance
final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'login',
      builder: (context, state) =>
          const LoginPage(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) =>
          const ResponsiveLayout(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout:
                MobileScreenLayout(),
          ),
    ),
    GoRoute(
      path: '/home/commentspage',
      name: 'comments',
      builder: (context, state) {
        final extraFn =
            state.extra
                as Map<String, dynamic>
                Function();
        final snap = extraFn();
        return CommentsPage(snap: snap);
      },
    ),
  ],
  // },
  redirect: (context, state) {
    final user =
        FirebaseAuth.instance.currentUser;

    if (user == null &&
        state.matchedLocation != '/') {
      return '/';
    }
    if (user != null &&
        state.matchedLocation == '/') {
      return '/home';
    }
    return null;
  },
  refreshListenable: GoRouterRefreshStream(
    FirebaseAuth.instance.authStateChanges(),
  ),
);

class GoRouterRefreshStream
    extends ChangeNotifier {
  late final StreamSubscription<dynamic>
  _subscription;
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream
        .asBroadcastStream()
        .listen((dynamic _) => notifyListeners());
  }
  late final Stream<dynamic> _stream;

  @override
  void dispose() {
    if (_stream is StreamSubscription) {
      (_stream as StreamSubscription).cancel();
    }
    super.dispose();
  }
}
