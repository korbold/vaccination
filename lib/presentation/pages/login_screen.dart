import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:lottie/lottie.dart';
import 'package:vacunation_test_kruger/config/app_config.dart' as config;
import 'package:vacunation_test_kruger/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:vacunation_test_kruger/routes/router.dart';

import 'widgets/BlockButtonWidget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool viewEnablePassword = false;
  TextEditingController nameUser = TextEditingController(text: "");

  TextEditingController password = TextEditingController(text: "");

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        context.read<FormBloc>().add(EmailUnfocused());
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        context.read<FormBloc>().add(PasswordUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Positioned(
              top: 0,
              child: Container(
                width: config.App(context).appWidth(100),
                height: config.App(context).appHeight(37),
                decoration:
                    BoxDecoration(color: Theme.of(context).colorScheme.primary),
              ),
            ),
            Positioned(
                top: 0,
                child: Container(
                  width: config.App(context).appWidth(100),
                  height: config.App(context).appHeight(37),
                  child: Lottie.asset("assets/json/covid-vaccination.json"),
                )),
            Positioned(
              top: config.App(context).appHeight(37) - 280,
              child: Container(
                width: config.App(context).appWidth(84),
                height: config.App(context).appHeight(37),
                child: Text(
                  'Vacunación',
                  style: Theme.of(context).textTheme.headline4!.merge(TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 40)),
                ),
              ),
            ),
            Positioned(
              top: config.App(context).appHeight(37) - 50,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 50,
                        color: Theme.of(context).hintColor.withOpacity(0.2),
                      )
                    ]),
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 27),
                width: config.App(context).appWidth(88),
                height: config.App(context).appHeight(55),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      BlocBuilder<FormBloc, FormStateValid>(
                        builder: (context, state) {
                          return TextFormField(
                            focusNode: _emailFocusNode,
                            controller: nameUser,
                            onChanged: (value) {},
                            keyboardType: TextInputType.emailAddress,
                            // onSaved: (input) => _con.user.email = input,
                            validator: (input) =>
                                input!.isEmpty ? 'campo vacío' : null,

                            decoration: InputDecoration(
                              helperText: 'Digite su cédula ej: 1002321934',
                              labelText: 'Cédula',
                              labelStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                              contentPadding: const EdgeInsets.all(12),
                              hintText: '1009998800',
                              hintStyle: TextStyle(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.7)),
                              prefixIcon: Icon(Icons.account_box,
                                  color: Theme.of(context).colorScheme.primary),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.2))),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.5))),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.2))),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 30),
                      BlocBuilder<FormBloc, FormStateValid>(
                        builder: (context, state) {
                          return TextFormField(
                            focusNode: _passwordFocusNode,
                            controller: password,
                            keyboardType: TextInputType.text,
                            onChanged: (value) {
                              context
                                  .read<FormBloc>()
                                  .add(PasswordChanged(password: value));
                            },

                            // onSaved: (input) => _con.user.password = input,
                            validator: (input) => input!.length < 3
                                ? 'mas de tres caracteres'
                                : null,
                            obscureText: !viewEnablePassword,
                            decoration: InputDecoration(
                              errorText: state.password.invalid
                                  ? '''La contraseña debe mas de 6 caracteres'''
                                  : null,
                              labelText: 'Contraseña',
                              labelStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                              contentPadding: const EdgeInsets.all(12),
                              hintText: '••••••••••••',
                              hintStyle: TextStyle(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.7)),
                              prefixIcon: Icon(Icons.lock_outline,
                                  color: Theme.of(context).colorScheme.primary),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    viewEnablePassword = !viewEnablePassword;
                                  });
                                },
                                color: Theme.of(context).focusColor,
                                icon: Icon(viewEnablePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.2))),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.5))),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.2))),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 30),
                      BlocConsumer<UsersBloc, UserState>(
                        listener: (context, state) {
                          if (state is UserFound) {
                            Navigator.of(context).pushReplacementNamed(
                                RoutersApp.splashRoute +
                                    "?user_id=${nameUser.text}?admin=false");
                          } else if (state is UserNotFound) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('No Existe el Usuario')),
                            );
                          }
                        },
                        builder: (context, state) {
                          return BlockButtonWidget(
                            text: Text(
                              'Inicar Sesión',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                            color: OutlinedButton.styleFrom(
                              primary: Theme.of(context).colorScheme.primary,
                            ),
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Cumplir los campos solicitados')),
                                );
                              } else if (nameUser.text == 'admin' &&
                                  password.text == 'admin') {
                                Navigator.of(context)
                                    .pushReplacementNamed(RoutersApp.homeRoute);
                              } else {
                                context.read<UsersBloc>().add(
                                    LoginEvent(nameUser.text, password.text));
                              }
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 25),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
