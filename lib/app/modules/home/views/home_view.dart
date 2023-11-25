// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:projecttts_223200009/app/modules/home/views/widgets/berat_barang_widgert.dart';
import 'package:projecttts_223200009/app/modules/home/views/widgets/city_widget.dart';
import 'package:projecttts_223200009/app/modules/home/views/widgets/province_widget.dart';
import 'package:projecttts_223200009/app/modules/ongkirs/views/ongkirs_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cek Ongkir Indonesia'),
          centerTitle: true,
          backgroundColor: Colors.amber[800],
          actions: [
            IconButton(
              onPressed: () {
                Get.to(OngkirsView(data: controller.pilihKurir));
              },
              icon: const Icon(
                Icons.checklist_rtl_rounded,
                color: Colors.white,
              ),
            )
          ],
        ),
        bottomNavigationBar: Obx(
          () => controller.hiddenButton.isTrue
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.all(24),
                  child: controller.isLoading.value == true
                      ? const SizedBox(
                          height: 50,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.amber,
                            ),
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () => controller.ongkosKirim(),
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              backgroundColor: Colors.amber[800]),
                          child: const Text("CEK ONGKOS KIRIM"),
                        ),
                ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: ListView(
              children: [
                const ProvinceWidget(
                  tipe: "asal",
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Obx(
                  () => controller.hiddenKotaAsal.isTrue
                      ? const SizedBox()
                      : CityWidget(
                          provId: controller.provAsalId.value,
                          tipe: "asal",
                        ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                const ProvinceWidget(tipe: "tujuan"),
                const SizedBox(
                  height: 12.0,
                ),
                Obx(
                  () => controller.hiddenKotaTujuan.isTrue
                      ? const SizedBox()
                      : CityWidget(
                          provId: controller.provTujuanId.value,
                          tipe: "tujuan",
                        ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                const BeratBarangWidget(),
                const SizedBox(
                  height: 12.0,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.amber),
                      borderRadius: BorderRadius.circular(8)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: DropdownSearch<Map<String, dynamic>>(
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        baseStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        dropdownSearchDecoration: InputDecoration(
                          suffixIconColor: Colors.amber,
                          fillColor: Colors.white,
                          border: InputBorder.none,
                          labelText: "Pilih Kurir",
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          filled: true,
                        ),
                      ),
                      popupProps:
                          const PopupPropsMultiSelection.modalBottomSheet(
                        showSearchBox: true,
                      ),
                      items: const [
                        {
                          "code": "jne",
                          "name": "Jalur Nugraha Ekakurir (JNE)",
                        },
                        {
                          "code": "tiki",
                          "name": "Titipan Kilat (TIKI)",
                        },
                        {
                          "code": "pos",
                          "name": "Perusahaan Opsional Surat (POS)",
                        },
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          controller.kurir.value = value["code"];
                          controller.showButton();
                        } else {
                          controller.hiddenButton.value = true;
                          controller.kurir.value = "";
                        }
                      },
                      itemAsString: (item) => "${item['name']}",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
