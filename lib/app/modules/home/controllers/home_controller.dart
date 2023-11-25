// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projecttts_223200009/app/modules/home/courier_model.dart';
import 'package:projecttts_223200009/app/service/ongkir_service.dart';

class HomeController extends GetxController {
  var hiddenKotaAsal = true.obs;
  var provAsalId = 0.obs;
  var kotaAsalId = 0.obs;
  var hiddenKotaTujuan = true.obs;
  var provTujuanId = 0.obs;
  var kotaTujuanId = 0.obs;
  var hiddenButton = true.obs;
  var kurir = "".obs;
  var kotaAsalName = "".obs;
  var kotaTujuanName = "".obs;
  var isLoading = false.obs;

  List<Map> pilihKurir = [];
  double berat = 0.0;
  String satuan = "gram";

  late TextEditingController beratC;
  void ongkosKirim() async {
    isLoading.value = true;
    final data = await OngkirService()
        .ongkirCost("$kotaAsalId", "$kotaTujuanId", "$berat", "$kurir");
    if (data.containsKey('errorCatch')) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: data['errorCatch'],
      );
    } else {
      final result = data["rajaongkir"]["results"] as List<dynamic>;
      var listAllCourier = Courier.fromJsonList(result);
      var courier = listAllCourier[0];
      Get.defaultDialog(
        title: courier.name!,
        content: Column(
          children: courier.costs!
              .map(
                (e) => GestureDetector(
                  onTap: () {
                    final data = {
                      "kotaAsal": kotaAsalName,
                      "kotaTujuan": kotaTujuanName,
                      "berat": "$berat",
                      "satuan": satuan,
                      "courier": courier.name,
                      "layanan": e.description,
                      "harga": "Rp ${e.cost![0].value}",
                      "estimasi": courier.code == "pos"
                          ? "${e.cost![0].etd}"
                          : "${e.cost![0].etd} HARI",
                    };
                    pilihKurir.add(data);
                    Get.back();
                    Get.snackbar(
                      "Layanan Kurir Berhasil di Pilih",
                      "${courier.name} | ${e.description}",
                      backgroundColor: Colors.amber.withOpacity(0.3),
                    );
                  },
                  child: ListTile(
                    title: Text("${e.service}"),
                    subtitle: Text("Rp ${e.cost![0].value}"),
                    trailing: Text(
                      courier.code == "pos"
                          ? "${e.cost![0].etd}"
                          : "${e.cost![0].etd} HARI",
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      );
    }
    isLoading.value = false;
  }

  void showButton() {
    if (kotaAsalId != 0 && kotaTujuanId != 0 && berat > 0 && kurir != "") {
      hiddenButton.value = false;
    } else {
      hiddenButton.value = true;
    }
  }

  void ubahBerat(String value) {
    berat = double.tryParse(value) ?? 0.0;
    String cekSatuan = satuan;
    switch (cekSatuan) {
      case "Ton":
        berat = berat * 1000000;
        break;
      case "Kwintal":
        berat = berat * 100000;
        break;
      case "Ons":
        berat = berat * 100;
        break;
      case "Lbs":
        berat = berat * 2204.62;
        break;
      case "Pound":
        berat = berat * 2204.62;
        break;
      case "Kilogram":
        berat = berat * 1000;
        break;
      case "Hektogram":
        berat = berat * 100;
        break;
      case "Dekagram":
        berat = berat * 10;
        break;
      case "Gram":
        berat = berat;
        break;
      case "Desigram":
        berat = berat / 10;
        break;
      case "Sentigram":
        berat = berat / 100;
        break;
      case "Miligram":
        berat = berat / 1000;
        break;
      default:
        berat = berat;
    }

    print("Total gram: $berat ");
    showButton();
  }

  void ubahSatuan(String value) {
    berat = double.tryParse(beratC.text) ?? 0.0;
    switch (value) {
      case "Ton":
        berat = berat * 1000000;
        break;
      case "Kwintal":
        berat = berat * 100000;
        break;
      case "Ons":
        berat = berat * 100;
        break;
      case "Lbs":
        berat = berat * 2204.62;
        break;
      case "Pound":
        berat = berat * 2204.62;
        break;
      case "Kilogram":
        berat = berat * 1000;
        break;
      case "Hektogram":
        berat = berat * 100;
        break;
      case "Dekagram":
        berat = berat * 10;
        break;
      case "Gram":
        berat = berat;
        break;
      case "Desigram":
        berat = berat / 10;
        break;
      case "Sentigram":
        berat = berat / 100;
        break;
      case "Miligram":
        berat = berat / 1000;
        break;
      default:
        berat = berat;
    }

    satuan = value;

    print("Total gram: $berat ");
    showButton();
  }

  @override
  void onInit() {
    beratC = TextEditingController(text: "$berat");
    super.onInit();
  }

  @override
  void onClose() {
    beratC.dispose();
    super.onClose();
  }
}
