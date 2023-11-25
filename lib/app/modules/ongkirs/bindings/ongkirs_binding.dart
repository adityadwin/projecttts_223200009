import 'package:get/get.dart';

import '../controllers/ongkirs_controller.dart';

class OngkirsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OngkirsController>(
      () => OngkirsController(),
    );
  }
}
