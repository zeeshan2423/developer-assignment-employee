import 'package:get/get.dart';

import '../controllers/edit_employee_details_controller.dart';

class EditEmployeeDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditEmployeeDetailsController>(
      () => EditEmployeeDetailsController(),
    );
  }
}
