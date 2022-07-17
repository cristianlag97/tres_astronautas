import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tres_astronautras/models/restaurant_model.dart';
import 'package:tres_astronautras/providers/theme_provider.dart';
import 'package:tres_astronautras/services/giph_service.dart';
import 'package:tres_astronautras/ui/colors.dart';
import 'package:tres_astronautras/widget/Card.dart';
import 'package:tres_astronautras/widget/header.dart';

class FavotiresPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const HeaderNasa(isSettings: true),
              _Title(),
              const SizedBox(height: 10),
              const _Body()
            ],
          ),
        ),
      )
    );
  }
}

class _Title extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final theme = Provider.of<ThemeProvider>(context).isDark;

    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Favorites', style: TextStyle(fontSize: 35, fontFamily: "provicali")),
                Container(
                  width: 40,
                  child: MaterialButton(
                    elevation: 1,
                    onPressed:() => Navigator.pushNamed(context, 'settings'),
                    color: theme ? darkMode : Colors.white,
                    textColor: theme ? Colors.white : Colors.black,
                    child: const Icon(Icons.add, size: 20,),
                    padding: const EdgeInsets.all(8),
                    shape: const CircleBorder(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: 20),
                ButtonNav(context, 'All', false),
                const SizedBox(width: 8),
                ButtonNav(context, 'Happy Hours', true),
                const SizedBox(width: 8),
                ButtonNav(context, 'Drinks', false),
                const SizedBox(width: 8),
                ButtonNav(context, 'Beer', false),
                const SizedBox(width: 8),
                ButtonNav(context, 'Other', false),
                const SizedBox(width: 20),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget ButtonNav(BuildContext context, String title, bool isColor) {
    final theme = Provider.of<ThemeProvider>(context).isDark;
    return Container(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: isColor ? orange : theme ? darkMode : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),)
        ),
        onPressed:() {
          print(title);
        },
        child: Text(title, style: TextStyle(color:isColor? Colors.white : theme ? Colors.white : Colors.black, fontSize: 15))
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final theme = Provider.of<ThemeProvider>(context).isDark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: theme ? darkMode : Colors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Happy Hours', style: TextStyle(fontFamily: 'gacor', fontSize: 13)),
              Container(
                width: 40,
                child: MaterialButton(
                  elevation: theme ? 5 : 1,
                  onPressed:() => Navigator.pushNamed(context, 'settings'),
                  color: theme ? darkMode : Colors.white,
                  child: theme ? const Image(image: AssetImage('assets/trash-white.png')) : const Image(image: AssetImage('assets/trash.png')),
                  padding: const EdgeInsets.all(8),
                  shape: const CircleBorder(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const ContainerRestaurant(),
        ],
      )
    );
  }
}

class ContainerRestaurant extends StatelessWidget {
  const ContainerRestaurant({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final service = GiphService();

    return Container(
      height: MediaQuery.of(context).size.height * 0.559,
      child: FutureBuilder(
        future: service.getRestaurats(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/OwfB.gif', height: 200),
                  const Text('Espere...'),
                ],
              ),
            );
          } else if(snapshot.hasError) {
            return Container(
              child: const Text(
                'Hubo un error en obtener tus movimientos, inténtalo de nuevo.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20
                ),
              )
            );
          } else {
            return CardGiph(data: snapshot.data, isFavorite: true);
          }
        },

      )
    );
  }
}

