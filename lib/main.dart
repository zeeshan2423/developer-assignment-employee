import 'package:developer_assignment_2/app/data/utils/import_manager.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    ScreenUtilInit(
      builder: (
        context,
        child,
      ) {
        return GetMaterialApp(
          title: StringManager.applicationTitle,
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          themeMode: ThemeMode.system,
          defaultTransition: Transition.cupertino,
        );
      },
    ),
  );
}
