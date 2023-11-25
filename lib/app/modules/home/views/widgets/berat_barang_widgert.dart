import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:projecttts_223200009/app/modules/home/controllers/home_controller.dart';

class BeratBarangWidget extends GetView<HomeController> {
  const BeratBarangWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            autocorrect: false,
            controller: controller.beratC,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: "Berat Barang",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Colors.amber,
                ),
              ),
            ),
            onChanged: (value) => controller.ubahBerat(value),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.amber)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: DropdownSearch<String>(
              dropdownDecoratorProps: const DropDownDecoratorProps(
                baseStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                dropdownSearchDecoration: InputDecoration(
                  suffixIconColor: Colors.amber,
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  labelText: "Satuan",
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  filled: true,
                ),
              ),
              popupProps: const PopupPropsMultiSelection.modalBottomSheet(
                showSearchBox: true,
              ),
              items: const [
                "Ton",
                "Kwintal",
                "Ons",
                "Lbs",
                "Pound",
                "Kilogram",
                "Hektogram",
                "Dekagram",
                "Gram",
                "Desigram",
                "Sentigram",
                "Miligram",
              ],
              selectedItem: "Gram",
              onChanged: (value) => controller.ubahSatuan(value!),
            ),
          ),
        ),
      ],
    );
  }
}
