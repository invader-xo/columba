import 'dart:io';

import 'package:columba/locator.dart';
import 'package:columba/screens/navigation/nav_bar_and_rail.dart';
import 'package:columba/theme/app_theme.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydrated_riverpod/hydrated_riverpod.dart';
import 'package:path_provider/path_provider.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..userAgent = null;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  HttpOverrides.global = MyHttpOverrides();

  await dotenv.load(fileName: 'assets/.env');

  List<int> key = encrypt.Key.fromUtf8(dotenv.env['APP_SECRET']!).bytes;
  debugPrint('key: $key');

  final storageDirectory = kIsWeb
      ? HydratedStorage.webStorageDirectory
      : await getApplicationDocumentsDirectory();
  final storage = await HydratedStorage.build(
    storageDirectory: storageDirectory,
    encryptionCipher: HydratedAesCipher(
      key,
    ),
  );
  HydratedRiverpod.initialize(storage: storage);

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  ); // ProviderScope is a widget from Riverpod
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mana β',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      routes: {
        '/': (context) => const NavBarAndRail(),
      },
      // onGenerateRoute: (settings) {
      //   if (settings.name == '/info') {
      //     final baseItem = settings.arguments as BaseItemModel;
      //     return MaterialPageRoute(
      //       builder: (context) => InfoView(
      //         item: baseItem,
      //       ),
      //     );
      //   }
      //   return null;
      // },
    );
  }
}
