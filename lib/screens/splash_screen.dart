import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GoRouterSplashScreen extends StatefulWidget {
  const GoRouterSplashScreen({super.key});

  @override
  State<GoRouterSplashScreen> createState() => _GoRouterSplashScreenState();
}

class _GoRouterSplashScreenState extends State<GoRouterSplashScreen> {
  data(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
			useImmersiveMode: true,
			childWidget: Expanded(
				child: Image.asset('assets/img/launcher_icon.jpeg')
			),
			asyncNavigationCallback: () async {
        await Future.delayed(const Duration(seconds: 3));
        if (context.mounted) {
          context.replace('/home');
          // GoRouter.of(context).goNamed("home");
          // context.goNamed('home');
        }
      },
		);
  }
}
