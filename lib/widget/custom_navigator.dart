import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tres_astronautras/providers/theme_provider.dart';
import 'package:tres_astronautras/providers/ui_provider.dart';
import 'package:tres_astronautras/ui/colors.dart';

class CustomNavigationBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final uiProvider = Provider.of<UiProvider>(context);
    final theme = Provider.of<ThemeProvider>(context).isDark;

    final currentIndex = uiProvider.selectedMenuOpt;

    return GNav(
      onTabChange: ( int i ) => uiProvider.selectedMenuOpt = i,
      haptic: true,
      tabBorderRadius: 15,
      gap: 8,
      iconSize: 24,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      tabs: const [
        GButton(
          icon: Icons.home_outlined,
          text: 'Inicio',
        ),
        GButton(
          icon: Icons.calendar_month_outlined,
          text: 'Calendario',
        ),
        GButton(
          icon:Icons.search,
          text: 'Buscar',
        ),
        GButton(
          icon: Icons.favorite_border,
          text: 'Favoritos',
        )
  ]
);


  }
}

