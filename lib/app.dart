import 'package:beta/constants/fonts.gen.dart';
import 'package:beta/feature/blo/view/test.dart';
import 'package:beta/theme/app_color.dart';
import 'package:beta/theme/strings.dart';
import 'package:beta/utils/common_functions.dart';
import 'package:beta/utils/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.whiteColor,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
    CommonFunctions.closeKeyboard(context);
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      enableScaleText: () => false,
      builder: (ctx, child) {
        ScreenUtil.init(ctx);
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: MaterialApp(
            title: Strings.appName,
            navigatorKey: NavigationService.navigatorKey,
            theme: ThemeData(useMaterial3: false, fontFamily: FontFamily.fonts, bottomSheetTheme: const BottomSheetThemeData(dragHandleColor: AppColors.editTextBorderColor)),
            home: const Testing(),
            debugShowCheckedModeBanner: false,
            navigatorObservers: [routeObserver],
          ),
        );
      },
    );
  }
}
