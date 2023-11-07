import 'package:developer_assignment_2/app/data/utils/import_manager.dart';
import 'package:developer_assignment_2/app/modules/employee-list/controllers/employee_list_controller.dart';
import 'package:get/get.dart';

class AddEmployeeDetailsController extends GetxController {
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
  var isEnable = List.generate(2, (index) => false.obs);


  @override
  void onReady() {
    super.onReady();
    isEnable[0].value = true;
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

  String generateRandomId({int length = 24}) {
    const chars = '0123456789abcdef';
    final random = Random();
    final id = StringBuffer();

    for (int i = 0; i < length; i++) {
      id.write(chars[random.nextInt(chars.length)]);
    }

    return id.toString();
  }

  Future<void> saveUser() async {
    await CrudManager.instance.addUserDetails(
      employeeId: generateRandomId(),
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
}
