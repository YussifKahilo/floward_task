import 'package:floward_task/features/user_profile/model/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<User> {
  UserCubit() : super(User.empty());

  static UserCubit get(context) => BlocProvider.of<UserCubit>(context);

  void setUser(User user) => emit(state.copyWith(
        imagePath: user.imagePath,
        name: user.name,
        email: user.email,
      ));
}
