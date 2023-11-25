// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import 'package:projecttts_223200009/app/modules/home/controllers/home_controller.dart';
import 'package:projecttts_223200009/app/modules/home/province_model.dart';
import 'package:projecttts_223200009/app/service/ongkir_service.dart';

class ProvinceWidget extends GetView<HomeController> {
  final String tipe;

  const ProvinceWidget({
    super.key,
    required this.tipe,
  });

  @override
  Widget build(BuildContext context) {
    String title = tipe == "asal" ? "Provinsi Asal" : "Provinsi Tujuan";
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
        child: DropdownSearch<Province>(
          asyncItems: (String text) => OngkirService().getProvinces(),
          clearButtonProps: const ClearButtonProps(isVisible: true),
          onChanged: (prov) {
            if (prov != null) {
              if (tipe == "asal") {
                controller.hiddenKotaAsal.value = false;
                controller.provAsalId.value = int.parse(prov.provinceId!);
              } else {
                controller.hiddenKotaTujuan.value = false;
                controller.provTujuanId.value = int.parse(prov.provinceId!);
              }
            } else {
              if (tipe == "asal") {
                controller.hiddenKotaAsal.value = true;
                controller.provAsalId.value = 0;
              } else {
                controller.hiddenKotaTujuan.value = true;
                controller.provTujuanId.value = 0;
              }
            }
            controller.showButton();
          },
          itemAsString: (item) => item.province!,
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
