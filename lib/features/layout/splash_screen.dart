import 'dart:async';

import 'package:floward_task/features/layout/main_layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String route = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      final BuildContext currentContext = context;
      if (currentContext.mounted) {
        _navigateToNextScreen(currentContext);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimationLimiter(
          child: TweenAnimationBuilder<double>(
            duration: const Duration(seconds: 3),
            tween: Tween<double>(begin: 1, end: 1.1),
            builder: (context, scale, child) {
              return Transform.scale(
                scale: scale,
                child: Icon(Icons.sunny_snowing, size: 100.sp),
              );
            },
          ),
        ),
      ),
    );
  }

  void _navigateToNextScreen(context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );

    Navigator.pushReplacementNamed(
      context,
      MainLayoutScreen.routeName,
    );
  }
}
