import 'package:get/get.dart';

import '../modules/add-employee-details/bindings/add_employee_details_binding.dart';
import '../modules/add-employee-details/views/add_employee_details_view.dart';
import '../modules/edit-employee-details/bindings/edit_employee_details_binding.dart';
import '../modules/edit-employee-details/views/edit_employee_details_view.dart';
import '../modules/employee-list/bindings/employee_list_binding.dart';
import '../modules/employee-list/views/employee_list_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.EMPLOYEE_LIST;

  static final routes = [
    GetPage(
      name: _Paths.EMPLOYEE_LIST,
      page: () => const EmployeeListView(),
      binding: EmployeeListBinding(),
    ),
    GetPage(
      name: _Paths.ADD_EMPLOYEE_DETAILS,
      page: () => const AddEmployeeDetailsView(),
      binding: AddEmployeeDetailsBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_EMPLOYEE_DETAILS,
      page: () => const EditEmployeeDetailsView(),
      binding: EditEmployeeDetailsBinding(),
    ),
  ];
}
