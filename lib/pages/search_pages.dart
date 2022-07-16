import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tres_astronautras/providers/theme_provider.dart';
import 'package:tres_astronautras/services/giph_service.dart';
import 'package:tres_astronautras/ui/colors.dart';
import 'package:tres_astronautras/widget/Card.dart';
import 'package:tres_astronautras/widget/header.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                HeaderNasa(),
                ChangeNotifierProvider(
                  create: (_) => GiphService(),
                  child: Search()
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Search extends StatelessWidget {

  final prueba = GiphService();
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final search = Provider.of<GiphService>(context);
    final theme = Provider.of<ThemeProvider>(context).isDark;

    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: theme ? Colors.grey[600] : Colors.grey[300],
            borderRadius: BorderRadius.circular(30)
          ),
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.77,
                child: TextField(
                  autofocus: false,
                  style: const TextStyle(fontSize: 12.0, fontFamily: 'gacor'),
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    hintText: 'Buscar',
                    contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                  controller: controller,
                ),
              ),
              IconButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  search.searchGiph(controller.text);
                  search.isOn = true;
                },
                icon: const Icon(Icons.search)
              )
            ],
          ),
        ),
        const SizedBox(height: 15),
        Container(
          height: MediaQuery.of(context).size.height * 0.725,
          child: FutureBuilder(
          future: prueba.syncronic(search.isOn? controller.text : 'home'),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: theme ? darkMode : Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                child:Column(
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
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: theme ? darkMode : Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: CardGiph(data: snapshot.data)
              );
            }
          },
          ),
        )
      ],
    );
  }

  searchB() {
    prueba.syncronic(controller.text.trim());
  }
}