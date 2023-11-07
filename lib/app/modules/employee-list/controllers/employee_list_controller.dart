import 'dart:async';

import 'package:developer_assignment_2/app/data/utils/import_manager.dart';
import 'package:get/get.dart';

class EmployeeListController extends GetxController {
  var userDetailsList = [].obs;
  var undoDelete = false.obs;
  final StreamController _userDetailsStreamController =
      StreamController.broadcast();

  Stream get userDetailsStream => _userDetailsStreamController.stream;

  @override
  void onReady() async {
    super.onReady();
    addUserDetails(await CrudManager.instance.getUserDetailsList());
  }

  @override
  void onClose() {
    _userDetailsStreamController.close();
    super.onClose();
  }

  void addUserDetails(var userDetails) {
    userDetailsList.addAll(userDetails);
    _userDetailsStreamController.sink.add(userDetailsList);
  }

  void editUserDetails(int index, Map<String, String> userDetails) {
    if (index >= 0 && index < userDetailsList.length) {
      userDetailsList[index] = userDetails;
      _userDetailsStreamController.sink.add(userDetailsList);
    }
  }

  void undoRemoveUser(var userDetails, int index) async {
    if (index >= 0 && index <= userDetailsList.length) {
      userDetailsList.insert(index, userDetails);
      _userDetailsStreamController.sink.add(userDetailsList);
    }
  }

  void removeUserDetails(int index) async {
    if (index >= 0 && index < userDetailsList.length) {
      userDetailsList.removeAt(index);
      await CrudManager.instance.removeUserDetails(index);
      _userDetailsStreamController.sink.add(userDetailsList);
    }
  }
}
