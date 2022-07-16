import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tres_astronautras/providers/theme_provider.dart';
import 'package:tres_astronautras/ui/colors.dart';

class HeaderNasa extends StatelessWidget {
  const HeaderNasa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final theme = Provider.of<ThemeProvider>(context);

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Image(image: AssetImage('assets/nasa.png'), height: 100),
          Row(
            children: [
              Container(
                width: 40,
                child: MaterialButton(
                  elevation: 1,
                  onPressed:() => Navigator.pushNamed(context, 'settings'),
                  color: theme.isDark ? darkMode: Colors.white,
                  child: theme.isDark ? const Image(image: AssetImage('assets/bell-white.png'),height: 21) : const Image(image: AssetImage('assets/bell.png'), height: 21),
                  padding: const EdgeInsets.all(8),
                  shape: const CircleBorder(),
                ),
              ),
              const SizedBox(width: 5),
              Container(
                width: 40,
                child: MaterialButton(
                  elevation: 1,
                  onPressed:() => Navigator.pushNamed(context, 'settings'),
                  color: theme.isDark ? darkMode : Colors.white,
                  child: theme.isDark ?  const Image(image: AssetImage('assets/settings-white.png')) : const Image(image: AssetImage('assets/settings.png')),
                  padding: const EdgeInsets.all(8),
                  shape: const CircleBorder(),
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
        ],
      ),
    );
  }
}