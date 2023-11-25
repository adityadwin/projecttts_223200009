// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/ongkirs_controller.dart';

class OngkirsView extends GetView<OngkirsController> {
  final List<Map> data;
  const OngkirsView({
    super.key,
    required this.data,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[800],
        title: const Text('List Ongkir'),
        centerTitle: true,
      ),
      body: data.isEmpty
          ? const Center(
              child: Text("List Ongkir Kosong silahkan buat terlebih dahulu"),
            )
          : ListView.builder(
              itemCount: data.length,
              physics: const ScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                final ongkir = data[index];
                print("ongkir: ${data[0]}");
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromARGB(250, 246, 177, 3),
                          Color.fromARGB(250, 246, 177, 3)
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              ongkir['courier'],
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 24.0,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Kota Asal',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Text('Kota Tujuan',
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 4.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ongkir['kotaAsal'].value.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_right_alt,
                                color: Colors.white,
                                size: 40,
                              ),
                              Text(
                                ongkir['kotaTujuan'].value.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          Center(
                            child: Text(
                              ongkir['layanan'],
                              style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Berat: ${ongkir['berat']} gram".toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Estimasi: ${ongkir['estimasi']}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "${ongkir['harga']}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
