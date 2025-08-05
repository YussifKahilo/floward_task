import 'package:floward_task/features/weather/presentation/screens/current_weather_condition_screen.dart';
import 'package:floward_task/src/cubit/custom_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../user_profile/presentation/screens/user_profile_screen.dart';

class MainLayoutScreen extends StatelessWidget {
  const MainLayoutScreen({super.key});

  static const String routeName = '/main_layout_screen';

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(initialPage: 0);
    return BlocProvider(
      create: (context) => CustomCubit<PageIndex>(PageIndex(0)),
      child: Scaffold(
        body: BlocListener<CustomCubit<PageIndex>, PageIndex>(
          listener: (context, state) {
            pageController.jumpToPage(state.index);
          },
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              CurrentWeatherConditionScreen(),
              UserProfileScreen(),
            ],
          ),
        ),
        bottomNavigationBar: BlocBuilder<CustomCubit<PageIndex>, PageIndex>(
            builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state.index,
            onTap: (i) =>
                CustomCubit.get<PageIndex>(context).changeState(PageIndex(i)),
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard), label: 'Dashboard'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
            ],
          );
        }),
      ),
    );
  }
}

class PageIndex {
  final int index;

  PageIndex(this.index);
}
