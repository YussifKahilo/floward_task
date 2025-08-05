import 'package:floward_task/features/user_profile/presentation/cubit/user_cubit.dart';
import 'package:floward_task/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:floward_task/src/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../user_profile/model/user.dart';
import '../widget/send_feedback_dialog.dart';

class CurrentWeatherConditionScreen extends StatefulWidget {
  const CurrentWeatherConditionScreen({super.key});

  @override
  State<CurrentWeatherConditionScreen> createState() =>
      _CurrentWeatherConditionScreenState();
}

class _CurrentWeatherConditionScreenState
    extends State<CurrentWeatherConditionScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    String city = 'Cairo';
    super.build(context);
    return BlocProvider(
      create: (context) =>
          WeatherBloc(sl())..add(CurrentWeatherRequestedEvent(city)),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              BlocBuilder<UserCubit, User>(builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      if (state.imagePath.isNotEmpty)
                        CircleAvatar(
                          backgroundImage: AssetImage(state.imagePath),
                        ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(state.name,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              )),
                          Text(
                            state.email,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
              Expanded(
                child: BlocBuilder<WeatherBloc, WeatherState>(
                    builder: (context, state) {
                  if (state is GetCurrentWeatherConditionSuccessState) {
                    return Center(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Weather now in ${state.weatherItem.city}',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    WeatherBloc.get(context).add(
                                        CurrentWeatherRequestedEvent(city));
                                  },
                                  icon: Icon(Icons.refresh))
                            ],
                          ),
                          SizedBox(height: 50.h),
                          Text(state.weatherItem.condition,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              )),
                          Text('${state.weatherItem.temperature}°C',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              )),
                          Image.network(state.weatherItem.iconUrl),
                          ElevatedButton(
                            onPressed: () => showFeedbackDialog(context),
                            child: const Text('Send Feedback'),
                          ),
                        ],
                      ),
                    );
                  } else if (state is GetCurrentWeatherConditionFailureState) {
                    return Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.message),
                        const SizedBox(height: 10),
                        ElevatedButton(
                            onPressed: () {
                              WeatherBloc.get(context)
                                  .add(CurrentWeatherRequestedEvent(city));
                            },
                            child: const Text('Try Again'))
                      ],
                    ));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
