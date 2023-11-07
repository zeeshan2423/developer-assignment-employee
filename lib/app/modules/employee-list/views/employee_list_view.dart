import 'package:developer_assignment_2/app/data/utils/import_manager.dart';
import 'package:get/get.dart';

import '../controllers/employee_list_controller.dart';

class EmployeeListView extends GetView<EmployeeListController> {
  const EmployeeListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.offWhite,
      appBar: WidgetManager.customAppBar(
        title: StringManager.employeeList,
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          top: 50.h,
          right: 10.w,
        ),
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              10.w,
            ),
          ),
          backgroundColor: ColorManager.primary,
          elevation: 0,
          child: SvgPicture.asset(
            AssetManager.addWhite,
            width: 16.w,
          ),
          onPressed: () async {
            await Get.toNamed(
              '/add-employee-details',
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          top: 12.5.h,
          left: 12.5.w,
          bottom: 35.h,
        ),
        child: Text(
          StringManager.swipe,
          style: GoogleFonts.roboto(
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
            color: controller.userDetailsList.isNotEmpty
                ? ColorManager.greyText
                : ColorManager.field,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: controller.userDetailsStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AssetManager.noEmployee,
                  ),
                  Text(
                    StringManager.noEmployee,
                    style: GoogleFonts.roboto(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorManager.darkText,
                    ),
                  ),
                ],
              ),
            );
          } else {
            final currentEmployeeList = snapshot.data!
                .where((userDetails) =>
                    userDetails['toDate'] == null ||
                    userDetails['toDate'].isEmpty)
                .toList();

            final previousEmployeeList = snapshot.data!
                .where((userDetails) =>
                    userDetails['toDate'] != null &&
                    userDetails['toDate'].isNotEmpty)
                .toList();
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: currentEmployeeList.isNotEmpty ? true : false,
                    child: Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.5.w,
                          vertical: 15.w,
                        ),
                        child: Text(
                          StringManager.current,
                          style: GoogleFonts.roboto(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: ColorManager.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: currentEmployeeList.isNotEmpty ? true : false,
                    child: Expanded(
                      flex: previousEmployeeList.isEmpty ? 13 : 6,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: currentEmployeeList.length,
                        separatorBuilder: (context, index) => Divider(
                          color: ColorManager.field,
                          height: 0.5.h,
                        ),
                        itemBuilder: (context, index) {
                          final userDetails = currentEmployeeList[index];
                          return Dismissible(
                            key: Key(userDetails['employeeId']),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              color: ColorManager.errorText,
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.w,
                              ),
                              alignment: Alignment.centerRight,
                              child: SvgPicture.asset(
                                AssetManager.deleteWhite,
                              ),
                            ),
                            onDismissed: (direction) {
                              controller.removeUserDetails(index);
                            },
                            child: GestureDetector(
                              onTap: () async {
                                await Get.toNamed(
                                  '/edit-employee-details',
                                  arguments: userDetails,
                                );
                              },
                              child: Container(
                                width: ScreenUtil().screenWidth,
                                decoration: const BoxDecoration(
                                  color: ColorManager.white,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.5.w,
                                  vertical: 12.5.h,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userDetails['employeeName'],
                                      style: GoogleFonts.roboto(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                        color: ColorManager.darkText,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 5.h,
                                      ),
                                      child: Text(
                                        userDetails['role'],
                                        style: GoogleFonts.roboto(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w400,
                                          color: ColorManager.greyText,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 5.h,
                                      ),
                                      child: Text(
                                        '${StringManager.from} ${'${userDetails['fromDate']}'.replaceRange('${userDetails['fromDate']}'.lastIndexOf(' '), '${userDetails['fromDate']}'.lastIndexOf(' ') + 1, ', ')}',
                                        style: GoogleFonts.roboto(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                          color: ColorManager.greyText,
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
                    ),
                  ),
                  Visibility(
                    visible: previousEmployeeList.isNotEmpty ? true : false,
                    child: Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.5.w,
                          vertical: 15.w,
                        ),
                        child: Text(
                          StringManager.previous,
                          style: GoogleFonts.roboto(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: ColorManager.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: previousEmployeeList.isNotEmpty ? true : false,
                    child: Expanded(
                      flex: currentEmployeeList.isEmpty ? 13 : 6,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: previousEmployeeList.length,
                        separatorBuilder: (context, index) => Divider(
                          color: ColorManager.field,
                          height: 0.5.h,
                        ),
                        itemBuilder: (context, index) {
                          final userDetails = previousEmployeeList[index];
                          return Dismissible(
                            key: Key(userDetails['employeeId']),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              color: ColorManager.errorText,
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.w,
                              ),
                              alignment: Alignment.centerRight,
                              child: SvgPicture.asset(
                                AssetManager.deleteWhite,
                              ),
                            ),
                            onDismissed: (direction) {
                              controller.removeUserDetails(index);
                            },
                            child: GestureDetector(
                              onTap: () async {
                                await Get.toNamed(
                                  '/edit-employee-details',
                                  arguments: userDetails,
                                );
                              },
                              child: Container(
                                width: ScreenUtil().screenWidth,
                                decoration: const BoxDecoration(
                                  color: ColorManager.white,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.5.w,
                                  vertical: 12.5.h,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userDetails['employeeName'],
                                      style: GoogleFonts.roboto(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                        color: ColorManager.darkText,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 5.h,
                                      ),
                                      child: Text(
                                        userDetails['role'],
                                        style: GoogleFonts.roboto(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w400,
                                          color: ColorManager.greyText,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 5.h,
                                      ),
                                      child: Text(
                                        '${'${userDetails['fromDate']}'.replaceRange('${userDetails['fromDate']}'.lastIndexOf(' '), '${userDetails['fromDate']}'.lastIndexOf(' ') + 1, ', ')} - ${'${userDetails['toDate']}'.replaceRange('${userDetails['toDate']}'.lastIndexOf(' '), '${userDetails['toDate']}'.lastIndexOf(' ') + 1, ', ')}',
                                        style: GoogleFonts.roboto(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                          color: ColorManager.greyText,
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
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
