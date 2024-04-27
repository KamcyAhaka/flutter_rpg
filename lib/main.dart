import 'package:flutter/material.dart';
import 'package:flutter_rpg/router/router.dart';
import 'package:flutter_rpg/services/character_store.dart';
import 'package:flutter_rpg/services/user_store.dart';
import 'package:flutter_rpg/theme.dart';
import 'package:provider/provider.dart';

// Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';



void main() async {
	WidgetsFlutterBinding.ensureInitialized();

	await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
	);

  runApp(MultiProvider(
		providers: [
			ChangeNotifierProvider(create: (context) => CharacterStore()),
			ChangeNotifierProvider(create: (context) => UserStore())
		],
		child: MaterialApp.router(
			theme: primaryTheme,
			routerConfig: router,
		),
	)
	);
}

class Sandbox extends StatelessWidget {
  const Sandbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sandbox'),
        backgroundColor: Colors.grey,
      ),
      body: const Text('Sandbox'),
    );
  }
}
