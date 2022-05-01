import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'config/theme.dart';
import 'injection.dart' as di;
import 'package:flutter/material.dart';
import 'package:vacunation_test_kruger/routes/router.dart';

import 'presentation/bloc/user_bloc/user_bloc.dart';
import 'presentation/bloc/vaccination_bloc/vaccination_bloc.dart';

void main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  RoutersApp.configureRoutes();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<FormBloc>()),
        BlocProvider(create: (_) => di.locator<ChangeStateRadio>()),
        BlocProvider(
            create: (_) => di.locator<UsersBloc>()..add(UserInitialData())),
        BlocProvider(
            create: (_) =>
                di.locator<VaccinationBloc>()..add(VaccinationInitialEvent())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Vacunación',
        theme: lightTheme,
        initialRoute: RoutersApp.rootRoute,
        onGenerateRoute: RoutersApp.router.generator,
      ),
    );
  }
}
