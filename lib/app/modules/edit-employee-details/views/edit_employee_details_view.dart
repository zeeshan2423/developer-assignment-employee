import 'package:get/get.dart';

import '../../../data/utils/import_manager.dart';
import '../controllers/edit_employee_details_controller.dart';

class EditEmployeeDetailsView extends GetView<EditEmployeeDetailsController> {
  const EditEmployeeDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: WidgetManager.customAppBar(
        title: StringManager.editEmployee,
        onTap: () async {
          await controller.deleteUser();
        },
      ),
      body: Center(
        child: Form(
          key: controller.addEmployeeDetailsKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                ),
                child: Column(
                  children: [
                    WidgetManager.customTextField(
                      type: TextFieldType.employee,
                      controller: controller.nameController,
                      focusNode: controller.nameNode,
                      onChanged: (value) async {
                        controller.updateButtonState();
                      },
                      updateButtonState: controller.updateButtonState,
                    ),
                    WidgetManager.customTextField(
                      type: TextFieldType.role,
                      controller: controller.roleController,
                      focusNode: controller.roleNode,
                      onChanged: (value) async {
                        controller.updateButtonState();
                      },
                      updateButtonState: controller.updateButtonState,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 4,
                          child: WidgetManager.customTextField(
                            type: TextFieldType.fromDate,
                            controller: controller.fromDateController,
                            focusNode: controller.fromDateNode,
                            onChanged: (value) async {
                              controller.updateButtonState();
                            },
                            updateButtonState: controller.updateButtonState,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 15.h,
                            ),
                            child: SvgPicture.asset(
                              AssetManager.arrow,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: WidgetManager.customTextField(
                            type: TextFieldType.toDate,
                            controller: controller.toDateController,
                            focusNode: controller.toDateNode,
                            onChanged: (value) async {},
                            updateButtonState: controller.updateButtonState,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Divider(
                    color: ColorManager.field,
                    thickness: 1.h,
                    height: 0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      WidgetManager.customButton(
                        buttonName: StringManager.cancel,
                        isEnable: controller.isEnable[0],
                        type: ButtonType.secondary,
                        onTap: () async {
                          Get.back();
                        },
                      ),
                      WidgetManager.customButton(
                        buttonName: StringManager.save,
                        isEnable: controller.isEnable[1],
                        type: ButtonType.primary,
                        onTap: () async {
                          await controller.saveUser();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
