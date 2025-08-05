import 'package:floward_task/features/user_profile/presentation/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../model/user.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen>
    with AutomaticKeepAliveClientMixin {
  static const platform = MethodChannel('com.example.profile/channel');

  @override
  void initState() {
    super.initState();

    platform.setMethodCallHandler((call) async {
      if (call.method == "userData") {
        final user = Map<String, dynamic>.from(call.arguments);
        UserCubit.get(context).setUser(User.fromJson(user));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('User data received and set successfully in dashboard'),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const Scaffold(
      body: UiKitView(
        viewType: 'profile-view',
        creationParams: {},
        creationParamsCodec: StandardMessageCodec(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
