import 'package:fluro/fluro.dart';
import 'package:vacunation_test_kruger/routes/routers_handlers.dart';

class RoutersApp {
  static final FluroRouter router = FluroRouter();

  //  nameRoutes

  static String rootRoute = "/";
  static String loginRoute = "/Login";
  static String homeRoute = "/Home";
  static String registerRoute = "/Register";
  static String splashRoute = "/Splash";
  static String dataRoute = "/Data";

  static void configureRoutes() {
    router.define(rootRoute,
        handler: RoutersHandlers.login, transitionType: TransitionType.fadeIn);
    router.define(homeRoute,
        handler: RoutersHandlers.home, transitionType: TransitionType.fadeIn);
    router.define(registerRoute,
        handler: RoutersHandlers.register,
        transitionType: TransitionType.fadeIn);
    router.define(splashRoute,
        handler: RoutersHandlers.splash, transitionType: TransitionType.fadeIn);
    router.define(dataRoute,
        handler: RoutersHandlers.data, transitionType: TransitionType.fadeIn);
  }
}
