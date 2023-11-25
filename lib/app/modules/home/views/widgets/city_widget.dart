// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import 'package:projecttts_223200009/app/modules/home/city_model.dart';
import 'package:projecttts_223200009/app/modules/home/controllers/home_controller.dart';
import 'package:projecttts_223200009/app/service/ongkir_service.dart';

class CityWidget extends GetView<HomeController> {
  const CityWidget({
    Key? key,
    required this.provId,
    required this.tipe,
  }) : super(key: key);
  final int provId;
  final String tipe;

  @override
  Widget build(BuildContext context) {
    String title =
        tipe == "asal" ? "Kota / Kabupaten Asal" : "Kota / Kabupaten Tujuan";
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.amber,
        ),
        borderRadius: BorderRadius.circular(
          8,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: DropdownSearch<City>(
          asyncItems: (String text) => OngkirService().getCity(provId),
          clearButtonProps: const ClearButtonProps(isVisible: true),
          onChanged: (value) {
            if (value != null) {
              if (tipe == "asal") {
                controller.kotaAsalId.value = int.parse(value.cityId!);
                controller.kotaAsalName.value = value.cityName!;
                print("value Name: ${value.cityName}");
              } else {
                controller.kotaTujuanId.value = int.parse(value.cityId!);
                controller.kotaTujuanName.value = value.cityName!;
              }
            } else {
              if (tipe == "asal") {
                print("Tidak memilih kota / kabupaten asal apapun");
                controller.kotaAsalId.value = 0;
              } else {
                print("Tidak memilih kota / kabupaten tujuan apapun");
                controller.kotaTujuanId.value = 0;
              }
            }
            controller.showButton();
          },
          itemAsString: (item) => "${item.type} ${item.cityName}",
          dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
            dropdownSearchDecoration: InputDecoration(
              suffixIconColor: Colors.amber,
              fillColor: Colors.white,
              border: InputBorder.none,
              labelText: title,
              labelStyle: const TextStyle(
                color: Colors.black,
              ),
              filled: true,
            ),
          ),
          popupProps: const PopupPropsMultiSelection.modalBottomSheet(
            showSearchBox: true,
          ),
        ),
      ),
    );
  }
}
