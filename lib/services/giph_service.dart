import 'package:flutter/cupertino.dart';
import 'package:tres_astronautras/global/enviroment.dart';
import 'package:http/http.dart' as http;
import 'package:tres_astronautras/models/restaurant_model.dart';

class GiphService extends ChangeNotifier {

  late List<Datum> data;
  bool _isOn = false;

  bool get isOn => _isOn;

  set isOn(bool value) {
    _isOn = value;
    notifyListeners();
  }

  Future<List<Datum>> getRestaurats() async {
    try {

      final url = Uri.parse('${Enviroment.restaurantUlr}restaurant&limit=15');
      final resp = await http.get(url).timeout(const Duration(seconds: 15),
        onTimeout: () {
          return http.Response('Error', 408);
        },
      );

    if(resp.statusCode == 200){

      final response = RestaurantData.fromJson(resp.body);

      return response.data;
    } else if ( resp.statusCode == 408) {
      return [];
    } else {
      return [];
    }

    } catch (e) {

      return [];

    }
  }

  Future<List<Datum>>syncronic(String value) async {

    data = await searchGiph(value);
    notifyListeners();
    return data;
  }

  Future<List<Datum>> searchGiph(String search) async {
    try {

      final url = Uri.parse('${Enviroment.restaurantUlr}$search&limit=15');
      final resp = await http.get(url).timeout(const Duration(seconds: 15),
        onTimeout: () {
          return http.Response('Error', 408);
        },
      );

    if(resp.statusCode == 200){

      final response = RestaurantData.fromJson(resp.body);

      data = response.data;
      notifyListeners();

      return response.data;
    } else if ( resp.statusCode == 408) {
      return [];
    } else {
      return [];
    }

    } catch (e) {

      return [];

    }
  }

}