// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:igclone/approuter.dart';
import 'package:igclone/data/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:igclone/providers/userprovider.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:
        DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const IgClone());
}

class IgClone extends StatelessWidget {
  const IgClone({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        Provider<GoRouter>.value(
          value: appRouter,
        ),
      ],
      child: Builder(
        builder: (context) {
          final GoRouter router =
              Provider.of<GoRouter>(context);
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'IG Clone',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: mobileLightModeBGColor,
              ),
            ),
            routerConfig: router,
          );
        },
      ),
    );
  }
}
