import 'package:get/get.dart';

import '../controllers/add_employee_details_controller.dart';

class AddEmployeeDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddEmployeeDetailsController>(
      () => AddEmployeeDetailsController(),
    );
  }
}
