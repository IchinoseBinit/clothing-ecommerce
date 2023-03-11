import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:provider/provider.dart';
import '/providers/auth_provider.dart';
import '/providers/conectivity_provider.dart';
import '/providers/database_provider.dart';
import '/providers/intro_notifier.dart';
import '/screens/auth_screen/splash_screen.dart';
import '/styles/themes.dart';
import 'utils/generate_navigation.dart';

main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  Stripe.publishableKey =
      "pk_test_51JT7jkCTAUDjRNFVfafy4Gskx1KzUNk8nPj8T51zzCPE18fA17DOFO6MqSZVTCxhVCSWGwouDSe0yjcObAznHLW600VBoGyDcg";
  await Stripe.instance.applySettings();
  runApp(const MyApp());
}

GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PaintingBinding.instance.imageCache.maximumSizeBytes = 1000 << 20;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<IntroProvider>(
            create: (_) => IntroProvider(),
          ),
          ChangeNotifierProvider<AuthProvider>(
            create: (_) => AuthProvider(),
          ),
          // ChangeNotifierProvider<ProfileProvider>(
          //   create: (_) => ProfileProvider(),
          // ),
          ChangeNotifierProvider<DatabaseHelperProvider>(
            create: (_) => DatabaseHelperProvider(),
          ),
          ChangeNotifierProvider<ConnectivityProvider>(
            create: (_) => ConnectivityProvider(),
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return KhaltiScope(
                publicKey: "",
                builder: (context, navigatorKey) {
                  navKey = navigatorKey;
                  return MaterialApp(
                    navigatorKey: navKey,
                    debugShowCheckedModeBanner: false,
                    title: 'E-Clothing',
                    theme: theme,
                    home: const SplashScreen(),
                    onGenerateRoute: GenerateNavigation.generateRoute,
                    supportedLocales: const [
                      Locale('en', 'US'),
                      Locale('ne', 'NP'),
                    ],
                    localizationsDelegates: const [
                      KhaltiLocalizations.delegate,
                    ],
                  );
                });
          },
        ));
  }
}
