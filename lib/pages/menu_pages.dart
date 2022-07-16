import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tres_astronautras/pages/pages.dart';
import 'package:tres_astronautras/providers/theme_provider.dart';
import 'package:tres_astronautras/providers/ui_provider.dart';
import 'package:tres_astronautras/ui/colors.dart';
import 'package:tres_astronautras/widget/custom_navigator.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final theme = Provider.of<ThemeProvider>(context).isDark;

    return Scaffold(
      body: NavigatorBar(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: theme ? darkMode : Colors.white,
          boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        spreadRadius: 1,
        blurRadius: 1,
      ),
    ],
        ),
        child: CustomNavigationBar()
      ),
    );
  }
}

class NavigatorBar extends StatelessWidget {
  const NavigatorBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // Obtener el selected menu opt
    final uiProvider = Provider.of<UiProvider>(context);

    // Cambiar para mostrar la pagina respectiva
    final currentIndex = uiProvider.selectedMenuOpt;

    switch( currentIndex ) {

      case 0:
        return HomePage();

      case 1:
        return const CalendarPage();

      case 2:
        return const SearchPage();

      case 3:
        return FavotiresPage();

      default:
        return HomePage();
    }

  }
}