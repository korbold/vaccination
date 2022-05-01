import 'package:fluro/fluro.dart';
import 'package:vacunation_test_kruger/presentation/pages/datagrid_screen.dart';

import 'package:vacunation_test_kruger/presentation/pages/list_users_screen.dart';
import 'package:vacunation_test_kruger/presentation/pages/login_screen.dart';
import 'package:vacunation_test_kruger/presentation/pages/register_screen.dart';
import 'package:vacunation_test_kruger/presentation/pages/splash_screen.dart';

class RoutersHandlers {
  static Handler login = Handler(handlerFunc: (context, params) {
    return const LoginPage();
  });

  static Handler home = Handler(handlerFunc: (context, params) {
    return const ListUserScreen();
  });
  static Handler data = Handler(handlerFunc: (context, params) {
    return  DataGridWidget();
  });

  static Handler register = Handler(handlerFunc: (context, params) {
    String id = params["user_id"]?.first ?? '';

    return RegisterScreen(ci: id);
  });
  static Handler splash = Handler(handlerFunc: (context, params) {
    String id = params["user_id"]?.first ?? '';

    return SplashScreen(
      ci: id,
    );
  });
}
