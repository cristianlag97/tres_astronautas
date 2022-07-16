import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tres_astronautras/models/restaurant_model.dart';
import 'package:tres_astronautras/providers/theme_provider.dart';
import 'package:tres_astronautras/ui/colors.dart';

class CardGiph extends StatelessWidget {

  bool? isFavorite;

  List<Datum> data;

  CardGiph({Key? key, required this.data, this.isFavorite = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final theme = Provider.of<ThemeProvider>(context).isDark;

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.only(bottom: 10),
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: theme ? lightDark : lightgrey,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: theme ? Colors.black : Colors.grey[200]!,
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 48,
                height: 20,
                child: Row(
                  children: [
                    IconButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: (){},
                      icon: const Icon(Icons.more_horiz, color: greyOption,)
                    )
                  ],
                ),
              ),
              Stack(
                children: [
                  Container(
                    height: 112,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/OwfB.gif',
                              image: data[index].images.original.url,
                              height: 90,
                              width: 140,
                              fit: BoxFit.cover,
                            )
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth:MediaQuery.of(context).size.width - 220),
                            child: Text(data[index].title,
                              style: const TextStyle(fontFamily: 'gacor', fontSize: 10),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          ),
                        )
                      ],
                    ),
                  ),
                  isFavorite! ? Positioned(
                    bottom: 6,
                    left: 70,
                    child: Container(
                      width: 40,
                      child: MaterialButton(
                        elevation: 3,
                        onPressed:() => Navigator.pushNamed(context, 'settings'),
                        color: Colors.white,
                        textColor: Colors.black,
                        child: const Icon(Icons.favorite, color: orange),
                        padding: const EdgeInsets.all(8),
                        shape: const CircleBorder(),
                      ),
                    ),
                  ) : SizedBox(),
                ],
              )
            ],
          )
        );
      },
    );
  }
}