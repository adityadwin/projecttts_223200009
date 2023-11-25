import 'dart:convert';

import 'package:projecttts_223200009/app/common/config.dart';
import 'package:projecttts_223200009/app/modules/home/city_model.dart';
import 'package:projecttts_223200009/app/modules/home/province_model.dart';
import 'package:http/http.dart' as http;

class OngkirService {
  Future<List<Province>> getProvinces() async {
    final response = await http.get(
      Uri.parse("${Config.baseUrl}/province"),
      headers: {
        "key": Config.apiKey,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['rajaongkir']['results'];

      var models = Province.fromJsonList(data);
      return models;
    } else {
      return List<Province>.empty();
    }
  }

  Future<List<City>> getCity(int provId) async {
    final response = await http.get(
      Uri.parse("${Config.baseUrl}/city?province=$provId"),
      headers: {
        "key": Config.apiKey,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['rajaongkir']['results'];

      var models = City.fromJsonList(data);
      return models;
    } else {
      return List<City>.empty();
    }
  }

  Future<Map<String, dynamic>> ongkirCost(String kotaAsalId,
      String kotaTujuanId, String berat, String kurir) async {
    try {
      final response = await http.post(
        Uri.parse("${Config.baseUrl}/cost"),
        headers: {
          "key": Config.apiKey,
          "content-type": "application/x-www-form-urlencoded",
        },
        body: {
          "origin": kotaAsalId,
          "destination": kotaTujuanId,
          "weight": berat,
          "courier": kurir,
        },
      );
      final data = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        return data;
      } else {
        return {"errorCatch": data['rajaongkir']['status']['description']};
      }
    } catch (e) {
      return {"errorCatch": e.toString()};
    }
  }
}
