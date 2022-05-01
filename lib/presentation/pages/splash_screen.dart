import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:vacunation_test_kruger/presentation/pages/list_users_screen.dart';
import 'package:vacunation_test_kruger/presentation/pages/register_screen.dart';

import '../bloc/user_bloc/user_bloc.dart';

class SplashScreen extends StatelessWidget {
  final String? ci;
  const SplashScreen({Key? key, this.ci}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (ci != null) {
      context.read<UsersBloc>().add(GetListUserEvent(ci!));
    }
    return BlocConsumer<UsersBloc, UserState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetUserById) {
          return Scaffold(
            body: SplashScreenView(
              navigateRoute: state.user!.role == 'admin'
                  ? const ListUserScreen()
                  : RegisterScreen(ci: ci,admin: false),
              duration: 3000,
              imageSize: 500,
              imageSrc: "assets/img/va.png",
              backgroundColor: Colors.white,
              text: 'Bienvenido/a',
            ),
          );
        } else {
          return Container(
            color: Colors.grey,
          );
        }
      },
    );
  }
}
