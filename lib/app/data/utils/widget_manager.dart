import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'import_manager.dart';

class WidgetManager {
  WidgetManager._();

  static PreferredSizeWidget customAppBar({
    required String title,
    void Function()? onTap,
  }) {
    return AppBar(
      backgroundColor: ColorManager.primary,
      elevation: 0,
      leading: const SizedBox(),
      leadingWidth: 0,
      title: Text(
        title,
        style: GoogleFonts.roboto(
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
          color: ColorManager.white,
        ),
      ),
      actions: [
        Visibility(
          visible: title == StringManager.editEmployee ? true : false,
          child: GestureDetector(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.only(
                right: 10.w,
              ),
              child: SvgPicture.asset(
                AssetManager.deleteWhite,
              ),
            ),
          ),
        ),
      ],
      toolbarHeight: ScreenUtil().screenHeight / 13,
    );
  }

  static Widget customTextField({
    required TextFieldType type,
    required TextEditingController controller,
    required FocusNode focusNode,
    required void Function(String)? onChanged,
    required void Function() updateButtonState,
  }) {
    String hintText;
    String assetPath;
    TextInputType inputType;
    List<TextInputFormatter>? inputFormatter;
    String? Function(String?)? validator;
    void Function()? onTap;
    var list = [
      StringManager.designer,
      StringManager.developer,
      StringManager.tester,
      StringManager.owner,
    ];

    switch (type) {
      case TextFieldType.employee:
        hintText = StringManager.name;
        assetPath = AssetManager.user;
        inputType = TextInputType.name;
        inputFormatter = [
          FilteringTextInputFormatter.allow(
            RegExp(
              "[a-zA-Z ]",
            ),
          ),
          TextInputFormatter.withFunction(
            (oldValue, newValue) {
              if (newValue.text.isNotEmpty) {
                String inputText = newValue.text;
                StringBuffer formattedText = StringBuffer();

                bool capitalizeNext = true;

                for (int i = 0; i < inputText.length; i++) {
                  String currentChar = inputText[i];

                  if (currentChar == ' ') {
                    formattedText.write(currentChar);
                    capitalizeNext = true;
                  } else {
                    if (capitalizeNext) {
                      formattedText.write(currentChar.toUpperCase());
                      capitalizeNext = false;
                    } else {
                      formattedText.write(currentChar);
                    }
                  }
                }

                return TextEditingValue(
                  text: formattedText.toString(),
                  selection: newValue.selection,
                );
              }
              return newValue;
            },
          ),
        ];
        validator = (value) {
          if (value!.isEmpty) {
            return null;
          }
          if (!ValidationManager.validateName(value)) {
            return StringManager.enterValidName;
          }
          return null;
        };
        onTap = () async {};
        break;
      case TextFieldType.role:
        hintText = StringManager.role;
        assetPath = AssetManager.briefcase;
        inputType = TextInputType.name;
        inputFormatter = [];
        validator = (value) {
          return null;
        };
        onTap = () async {
          await customCategoryPicker(
            controller: controller,
            list: list,
            updateButton: updateButtonState,
          );
        };
        break;
      case TextFieldType.fromDate:
        hintText = StringManager.today;
        assetPath = AssetManager.calendar;
        inputType = TextInputType.name;
        inputFormatter = [];
        validator = (value) {
          return null;
        };
        onTap = () async {
          Get.dialog(
            barrierDismissible: false,
            barrierColor: ColorManager.black.withOpacity(
              0.4,
            ),
            customDatePicker(
              type: 1,
              controller: controller,
              updateButton: updateButtonState,
            ),
          );
        };
        break;
      case TextFieldType.toDate:
        hintText = StringManager.noDate;
        assetPath = AssetManager.calendar;
        inputType = TextInputType.name;
        inputFormatter = [];
        validator = (value) {
          return null;
        };
        onTap = () async {
          Get.dialog(
            barrierDismissible: false,
            barrierColor: ColorManager.black.withOpacity(
              0.4,
            ),
            customDatePicker(
              type: 2,
              controller: controller,
              updateButton: updateButtonState,
            ),
          );
        };
        break;
    }

    return Padding(
      padding: EdgeInsets.only(
        top: 15.h,
      ),
      child: TextFormField(
        readOnly: type == TextFieldType.employee ? false : true,
        controller: controller,
        focusNode: focusNode,
        onChanged: (value) {
          onChanged?.call(value);
          updateButtonState();
        },
        onTap: onTap,
        onTapOutside: (value) {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        onEditingComplete: () async {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: inputType,
        inputFormatters: inputFormatter,
        validator: validator,
        style: GoogleFonts.roboto(
          fontSize: 13.sp,
          fontWeight: FontWeight.w400,
          color: ColorManager.darkText,
        ),
        cursorColor: ColorManager.darkText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            left: 20.w,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorManager.field,
            ),
            borderRadius: BorderRadius.circular(
              8.w,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorManager.darkText,
            ),
            borderRadius: BorderRadius.circular(
              8.w,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorManager.errorText,
            ),
            borderRadius: BorderRadius.circular(
              8.w,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorManager.errorText,
            ),
            borderRadius: BorderRadius.circular(
              8.w,
            ),
          ),
          errorStyle: GoogleFonts.ibmPlexSans(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: ColorManager.errorText,
          ),
          hintText: hintText,
          hintStyle: GoogleFonts.roboto(
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
            color: ColorManager.greyText,
          ),
          prefixIconConstraints: BoxConstraints(
            minWidth: 40.w,
          ),
          prefixIcon: SvgPicture.asset(
            assetPath,
            height: 14.h,
          ),
          suffixIconConstraints: BoxConstraints(
            minWidth: type == TextFieldType.role ? 40.w : 0,
          ),
          suffixIcon: Visibility(
            visible: type == TextFieldType.role ? true : false,
            child: SvgPicture.asset(
              AssetManager.dropdown,
              width: 10.w,
            ),
          ),
        ),
      ),
    );
  }

  static Widget customButton({
    required String buttonName,
    required var isEnable,
    required ButtonType type,
    required void Function()? onTap,
  }) {
    Color buttonColor;
    Color pressedColor;
    Color textColor;
    double textSize;
    FontWeight textWeight;

    switch (type) {
      case ButtonType.primary:
        buttonColor = ColorManager.primary;
        pressedColor = ColorManager.primaryButtonPressed;
        textColor = ColorManager.white;
        textSize = 11.sp;
        textWeight = FontWeight.w500;
        break;
      case ButtonType.secondary:
        buttonColor = ColorManager.secondary;
        pressedColor = ColorManager.secondaryButtonPressed;
        textColor = ColorManager.primary;
        textSize = 11.sp;
        textWeight = FontWeight.w500;
        break;
    }
    var isPressed = false.obs;
    return Obx(
      () => GestureDetector(
        onTapDown: (value) {
          if (isEnable.value == true) {
            isPressed.value = true;
          }
        },
        onTapUp: (value) {
          if (isEnable.value == true) {
            isPressed.value = false;
          }
        },
        onTap: isEnable.value ? onTap : null,
        child: Container(
          alignment: Alignment.center,
          width: 60.w,
          padding: EdgeInsets.symmetric(
            vertical: 10.h,
          ),
          margin: EdgeInsets.only(
            top: 10.h,
            bottom: 10.h,
            right: 10.w,
          ),
          decoration: BoxDecoration(
            color: isPressed.value
                ? pressedColor
                : isEnable.value
                    ? buttonColor
                    : buttonColor.withOpacity(
                        0.4,
                      ),
            borderRadius: BorderRadius.circular(
              6.w,
            ),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.center,
            child: Text(
              buttonName,
              style: GoogleFonts.roboto(
                fontSize: textSize,
                fontWeight: textWeight,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Future<dynamic> customCategoryPicker({
    required TextEditingController controller,
    required List<String> list,
    required void Function() updateButton,
  }) {
    return showModalBottomSheet(
      barrierColor: ColorManager.black.withOpacity(
        0.4,
      ),
      elevation: 0,
      context: Get.context!,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(
            15.w,
          ),
          topLeft: Radius.circular(
            15.w,
          ),
        ),
      ),
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaY: 3,
            sigmaX: 3,
          ),
          child: Container(
            height: ScreenUtil().screenHeight / 3.85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(
                  15.w,
                ),
                topLeft: Radius.circular(
                  15.w,
                ),
              ),
              color: CupertinoColors.systemBackground.resolveFrom(context),
            ),
            child: ListView.separated(
              itemCount: list.length,
              separatorBuilder: (context, index) => Divider(
                color: ColorManager.field,
                height: 2.h,
                thickness: 1.w,
              ),
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () async {
                    controller.text = list[index];
                    updateButton();
                    Get.back();
                  },
                  title: Text(
                    list[index],
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,
                      fontSize: 13.sp,
                      color: ColorManager.darkText,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  static Widget customDatePicker({
    required int type,
    required TextEditingController controller,
    required void Function() updateButton,
  }) {
    var today = DateTime.now().obs;
    var focusedDay = DateTime.now().obs;
    final firstDay = DateTime(focusedDay.value.year);
    final lastDay = DateTime(focusedDay.value.year + 10);
    const calendarFormat = CalendarFormat.month;
    final selectedDecoration = BoxDecoration(
      color: Colors.transparent,
      border: Border.all(
        color: ColorManager.primary,
      ),
      shape: BoxShape.circle,
    );
    const selectedMarker = BoxDecoration(
      color: ColorManager.primary,
      shape: BoxShape.circle,
    );
    final selectedStyle = GoogleFonts.roboto(
      fontSize: 13.sp,
      fontWeight: FontWeight.w400,
      color: ColorManager.primary,
    );
    final selectedMarkerStyle = GoogleFonts.roboto(
      fontSize: 13.sp,
      fontWeight: FontWeight.w400,
      color: ColorManager.white,
    );
    final isEnable = List.generate(
      4,
      (index) => type == 1 && index == 0
          ? true.obs
          : type == 2 && index == 1
              ? true.obs
              : false.obs,
    );
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 3,
        sigmaY: 3,
      ),
      child: Dialog(
        elevation: 0,
        alignment: Alignment.center,
        insetPadding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: ScreenUtil().screenHeight / 5.25,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            14.w,
          ),
        ),
        child: Obx(() {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 7.5.w,
                  vertical: 10.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: type == 1 ? true : false,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: dialogCategoryButton(
                              type: CategoryButtonType.today,
                              isEnable: isEnable[0],
                              onTap: () async {
                                focusedDay.value = today.value;
                                for (var disable in isEnable) {
                                  disable.value = false;
                                }
                                isEnable[0].value = true;
                              },
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: dialogCategoryButton(
                              type: CategoryButtonType.nextMonday,
                              isEnable: isEnable[1],
                              onTap: () async {
                                final nextMonday = today.value.add(
                                  Duration(
                                      days: (7 - today.value.weekday) % 7 + 1),
                                );
                                focusedDay.value = nextMonday;
                                for (var disable in isEnable) {
                                  disable.value = false;
                                }
                                isEnable[1].value = true;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: type == 1 ? true : false,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: dialogCategoryButton(
                              type: CategoryButtonType.nextTuesday,
                              isEnable: isEnable[2],
                              onTap: () async {
                                final nextTuesday = today.value.add(
                                  Duration(
                                      days: (7 - today.value.weekday) % 7 + 2),
                                );
                                focusedDay.value = nextTuesday;
                                for (var disable in isEnable) {
                                  disable.value = false;
                                }
                                isEnable[2].value = true;
                              },
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: dialogCategoryButton(
                              type: CategoryButtonType.afterWeek,
                              isEnable: isEnable[3],
                              onTap: () async {
                                final nextWeek = today.value.add(
                                  const Duration(days: 7),
                                );
                                focusedDay.value = nextWeek;
                                for (var disable in isEnable) {
                                  disable.value = false;
                                }
                                isEnable[3].value = true;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: type == 2 ? true : false,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: dialogCategoryButton(
                              type: CategoryButtonType.noDate,
                              isEnable: isEnable[0],
                              onTap: () async {
                                controller.clear();
                                for (var disable in isEnable) {
                                  disable.value = false;
                                }
                                isEnable[0].value = true;
                              },
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: dialogCategoryButton(
                              type: CategoryButtonType.today,
                              isEnable: isEnable[1],
                              onTap: () async {
                                focusedDay.value = today.value;
                                for (var disable in isEnable) {
                                  disable.value = false;
                                }
                                isEnable[1].value = true;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    TableCalendar(
                      focusedDay: focusedDay.value,
                      firstDay: firstDay,
                      lastDay: lastDay,
                      calendarFormat: calendarFormat,
                      formatAnimationCurve: Curves.easeIn,
                      currentDay: today.value,
                      rowHeight: 30.h,
                      daysOfWeekHeight: 20.h,
                      selectedDayPredicate: (DateTime date) {
                        return isSameDay(focusedDay.value, date);
                      },
                      onDaySelected: (focusDay, selectedDay) {
                        focusedDay.value = selectedDay;
                      },
                      headerStyle: HeaderStyle(
                        titleCentered: true,
                        formatButtonVisible: false,
                        leftChevronMargin: EdgeInsets.only(
                          left: 80.w,
                        ),
                        leftChevronIcon: RotatedBox(
                          quarterTurns: 1,
                          child: SvgPicture.asset(
                            AssetManager.dropdown,
                            colorFilter: const ColorFilter.mode(
                              ColorManager.greyText,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        rightChevronMargin: EdgeInsets.only(
                          right: 80.w,
                        ),
                        rightChevronIcon: RotatedBox(
                          quarterTurns: 3,
                          child: SvgPicture.asset(
                            AssetManager.dropdown,
                            colorFilter: const ColorFilter.mode(
                              ColorManager.greyText,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                      calendarStyle: CalendarStyle(
                        outsideDaysVisible: false,
                        isTodayHighlighted: true,
                        cellMargin: EdgeInsets.all(
                          3.w,
                        ),
                      ),
                      calendarBuilders: CalendarBuilders(
                        todayBuilder: (context, date, events) {
                          return Container(
                            alignment: Alignment.center,
                            height: 90.h,
                            width: 90.w,
                            margin: EdgeInsets.symmetric(
                              horizontal: 2.5.w,
                              vertical: 2.5.h,
                            ),
                            decoration: selectedDecoration,
                            child: Text(
                              DateFormat('d').format(date),
                              style: selectedStyle,
                            ),
                          );
                        },
                        selectedBuilder: (context, date, events) {
                          return Container(
                            alignment: Alignment.center,
                            height: 90.h,
                            width: 90.w,
                            margin: EdgeInsets.symmetric(
                              horizontal: 2.5.w,
                              vertical: 2.5.h,
                            ),
                            decoration: selectedMarker,
                            child: Text(
                              DateFormat('d').format(date),
                              style: selectedMarkerStyle,
                            ),
                          );
                        },
                      ),
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
                  Padding(
                    padding: EdgeInsets.only(
                      left: 10.w,
                      right: 2.5.w,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              AssetManager.calendar,
                              width: 20.w,
                            ),
                            Obx(() {
                              return Text(
                                type == 2 && isEnable[0].value == true
                                    ? '   ${StringManager.noDate}'
                                    : '   ${DateFormat('d MMM yyyy').format(focusedDay.value)}',
                                style: GoogleFonts.roboto(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: ColorManager.darkText,
                                ),
                              );
                            }),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            WidgetManager.customButton(
                              buttonName: StringManager.cancel,
                              isEnable: true.obs,
                              type: ButtonType.secondary,
                              onTap: () async {
                                Get.back();
                              },
                            ),
                            WidgetManager.customButton(
                              buttonName: StringManager.save,
                              isEnable: true.obs,
                              type: ButtonType.primary,
                              onTap: () async {
                                if (type == 2 && isEnable[0].value == true) {
                                  null;
                                } else {
                                  controller.text = DateFormat('d MMM yyyy')
                                      .format(focusedDay.value);
                                }
                                updateButton();
                                Get.back();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          );
        }),
      ),
    );
  }

  static Widget dialogCategoryButton({
    required CategoryButtonType type,
    required var isEnable,
    required void Function()? onTap,
  }) {
    Color selectedButtonColor = ColorManager.primary;
    Color buttonColor = ColorManager.secondary;
    Color selectedTextColor = ColorManager.white;
    Color textColor = ColorManager.primary;
    double textSize = 12.sp;
    FontWeight textWeight = FontWeight.w400;
    String buttonName;

    switch (type) {
      case CategoryButtonType.today:
        buttonName = StringManager.today;
        break;
      case CategoryButtonType.nextMonday:
        buttonName = StringManager.monday;
        break;
      case CategoryButtonType.nextTuesday:
        buttonName = StringManager.tuesday;
        break;
      case CategoryButtonType.afterWeek:
        buttonName = StringManager.week;
        break;
      case CategoryButtonType.noDate:
        buttonName = StringManager.noDate;
        break;
    }

    return Obx(
      () => GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          width: 60.w,
          padding: EdgeInsets.symmetric(
            vertical: 10.h,
          ),
          margin: EdgeInsets.symmetric(
            vertical: 5.h,
            horizontal: 5.h,
          ),
          decoration: BoxDecoration(
            color: isEnable.value == true ? selectedButtonColor : buttonColor,
            borderRadius: BorderRadius.circular(
              6.w,
            ),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.center,
            child: Text(
              buttonName,
              style: GoogleFonts.roboto(
                fontSize: textSize,
                fontWeight: textWeight,
                color: isEnable.value == true ? selectedTextColor : textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum TextFieldType {
  employee,
  role,
  fromDate,
  toDate,
}

enum ButtonType {
  primary,
  secondary,
}

enum CategoryButtonType {
  today,
  nextMonday,
  nextTuesday,
  afterWeek,
  noDate,
}
