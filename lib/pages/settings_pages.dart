import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tres_astronautras/providers/theme_provider.dart';
import 'package:tres_astronautras/shared_preferences/preferences.dart';
import 'package:tres_astronautras/widget/header.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final theme = Provider.of<ThemeProvider>(context);

    return  Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HeaderNasa(),
            const Text('Configuración', style: TextStyle(fontSize: 42, fontWeight: FontWeight.w300)),
            const Divider(),
            SwitchListTile.adaptive(
              title: const Text('Darkmode'),
              value: theme.isDark,
              onChanged: (value){
                Preferences.isDarkmode = value;
                value ? theme.setDarkmode() : theme.setLightmode();
              }
            )
          ]
        ),
      )
    );
  }
}