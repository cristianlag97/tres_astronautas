import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tres_astronautras/pages/pages.dart';
import 'package:tres_astronautras/providers/form_matrix.dart';
import 'package:tres_astronautras/providers/theme_provider.dart';
import 'package:tres_astronautras/providers/ui_provider.dart';
import 'package:tres_astronautras/shared_preferences/preferences.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Preferences.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FormMatrix()),
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider(isDarkmode: Preferences.isDarkmode))
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'navigator',
      routes: {
        'navigator': (_) => const MenuPage(),
        'home': (_) => HomePage(),
        'settings': (_) => const SettingsPage(),
      },
      theme: Provider.of<ThemeProvider>(context).currentTheme,
    );
  }
}