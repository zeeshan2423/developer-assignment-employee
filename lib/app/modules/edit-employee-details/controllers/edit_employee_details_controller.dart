import 'package:get/get.dart';

import '../../../data/utils/import_manager.dart';
import '../../employee-list/controllers/employee_list_controller.dart';

class EditEmployeeDetailsController extends GetxController {
  final employeeListController = Get.put(EmployeeListController());
  final addEmployeeDetailsKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final roleController = TextEditingController();
  final fromDateController = TextEditingController();
  final toDateController = TextEditingController();
  final nameNode = FocusNode();
  final roleNode = FocusNode();
  final fromDateNode = FocusNode();
  final toDateNode = FocusNode();
  var isEnable = List.generate(2, (index) => true.obs);
  var arguments = Get.arguments;


  @override
  void onReady() {
    super.onReady();
    nameController.text = arguments['employeeName'];
    roleController.text = arguments['role'];
    fromDateController.text = arguments['fromDate'];
    toDateController.text = arguments['toDate'];
  }


  void updateButtonState() {
    if (!addEmployeeDetailsKey.currentState!.validate() ||
        nameController.text.isEmpty ||
        roleController.text.isEmpty ||
        fromDateController.text.isEmpty) {
      isEnable[1].value = false;
    } else {
      isEnable[1].value = true;
    }
  }

  Future<void> saveUser() async {
    await CrudManager.instance.editUserDetails(
      employeeId: arguments['employeeId'],
      employeeName: nameController.text.trimRight(),
      role: roleController.text,
      fromDate: fromDateController.text,
      toDate: toDateController.text,
    );
    employeeListController.userDetailsList.clear();
    employeeListController
        .addUserDetails(await CrudManager.instance.getUserDetailsList());
    Get.back();
  }

  Future<void> deleteUser() async {
    await CrudManager.instance.removeUserById(
      employeeId: arguments['employeeId'],
    );
    employeeListController.userDetailsList.clear();
    employeeListController
        .addUserDetails(await CrudManager.instance.getUserDetailsList());
    Get.back();
  }
}
