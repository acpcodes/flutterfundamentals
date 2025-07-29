// ignore_for_file: avoid_print
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:igclone/data/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:igclone/providers/userprovider.dart';
import 'package:igclone/responsive/mobilescreenlayout.dart';
import 'package:igclone/responsive/responsivelayout.dart';
import 'package:igclone/responsive/webscreenlayout.dart';
import 'package:igclone/views/pages/loginpage.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const IgClone());
  // await FirebaseAuth.instance.signOut();
  // print('User logged out on app start for testing purposes.');
}

class IgClone extends StatelessWidget {
  const IgClone({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'IG Clone',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: mobileLightModeBGColor)),
        // home: MainTree(),
        // home: LoginPage(),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  webScreenLayout: WebScreenLayout(),
                  mobileScreenLayout: MobileScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('${snapshot.error}'));
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(color: mobileDarkModeBGColor));
            }
            return const LoginPage();
          },
        ),
        // home: RegisterPage(),
      ),
    );
  }
}
