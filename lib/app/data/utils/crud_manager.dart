import 'package:developer_assignment_2/app/data/utils/import_manager.dart';

class CrudManager {
  CrudManager._();
  static final CrudManager instance = CrudManager._();

  final String _userListKey = 'userList';

  Future<void> addUserDetails({
    required String employeeId,
    required String employeeName,
    required String role,
    required String fromDate,
    required String toDate,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final user = {
      'employeeId': employeeId,
      'employeeName': employeeName,
      'role': role,
      'fromDate': fromDate,
      'toDate': toDate,
    };

    List<Map<String, String>> userList = await getUserDetailsList();
    userList.add(user);

    prefs.setStringList(
        _userListKey, userList.map((user) => json.encode(user)).toList());
  }

  Future<dynamic> getUserDetailsList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userListString = prefs.getStringList(_userListKey) ?? [];
    final userList = userListString.map((userString) {
      return Map<String, String>.from(json.decode(userString));
    }).toList();

    return userList;
  }

  Future<void> editUserDetails({
    required String employeeId,
    required String employeeName,
    required String role,
    required String fromDate,
    required String toDate,
  }) async {
    List<Map<String, String>> userList = await getUserDetailsList();
    int indexToEdit = -1;

    for (int i = 0; i < userList.length; i++) {
      if (userList[i]['employeeId'] == employeeId) {
        indexToEdit = i;
        break;
      }
    }

    if (indexToEdit >= 0) {
      final updatedUser = {
        'employeeId': employeeId,
        'employeeName': employeeName,
        'role': role,
        'fromDate': fromDate,
        'toDate': toDate,
      };
      userList[indexToEdit] = updatedUser;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList(
          _userListKey, userList.map((user) => json.encode(user)).toList());
    }
  }

  Future<void> removeUserDetails(int index) async {
    List<Map<String, String>> userList = await getUserDetailsList();

    if (index >= 0 && index < userList.length) {
      userList.removeAt(index);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList(
          _userListKey, userList.map((user) => json.encode(user)).toList());
    }
  }

  Future<void> removeUserById({
    required String employeeId,
  }) async {
    List<Map<String, String>> userList = await getUserDetailsList();
    int indexToRemove = -1;

    for (int i = 0; i < userList.length; i++) {
      if (userList[i]['employeeId'] == employeeId) {
        indexToRemove = i;
        break;
      }
    }

    if (indexToRemove >= 0) {
      userList.removeAt(indexToRemove);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList(
          _userListKey, userList.map((user) => json.encode(user)).toList());
    }
  }

  Future<void> undoRemoveUserById(
      {required String employeeId, required var userDetails}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, String>> userList = await getUserDetailsList();
    userList.add(userDetails.toMap());
    prefs.setStringList(
        _userListKey, userList.map((user) => json.encode(user)).toList());
  }

  Future<void> clearUserDetailsList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userListKey);
  }
}
