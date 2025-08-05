import 'package:floward_task/features/user_profile/presentation/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';
import '../features/layout/splash_screen.dart';
import 'routes_manager.dart';

class MyApp extends StatelessWidget {
  final double? designWidth;
  final double? designHeight;
  const MyApp({
    super.key,
    this.designWidth,
    this.designHeight,
  });

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserCubit()),
      ],
      child: ScreenUtilInit(
        designSize: Size(designWidth ?? 400, designHeight ?? 900),
        splitScreenMode: true,
        builder: (context, child) => child!,
        child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: ToastificationWrapper(
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: "Floward Task",
                navigatorKey: navigatorKey,
                initialRoute: SplashScreen.route,
                onGenerateRoute: RoutesManager.generateRoute,
              ),
            )),
      ),
    );
  }
}
