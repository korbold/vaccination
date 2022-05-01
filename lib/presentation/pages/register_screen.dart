import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'package:vacunation_test_kruger/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:vacunation_test_kruger/presentation/pages/widgets/BlockButtonWidget.dart';
import 'package:vacunation_test_kruger/presentation/pages/widgets/textInput.dart';
import 'package:vacunation_test_kruger/presentation/pages/widgets/vaccination_widget.dart';
import 'package:vacunation_test_kruger/routes/router.dart';

import '../../data/models/users.dart';

class RegisterScreen extends StatefulWidget {
  final String? ci;
  final bool? admin;
  const RegisterScreen({Key? key, this.ci, this.admin = true})
      : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _ci;

  late TextEditingController _names;

  late TextEditingController _surnames;

  late TextEditingController _email;
  late TextEditingController _date;
  late TextEditingController _address;
  late TextEditingController _phoneNumber;

  final _emailFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  Object role = '', check='';
  String password = "";
  late DateTime date;

  @override
  void initState() {
    initializeDateFormatting();
    super.initState();
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        context.read<FormBloc>().add(EmailUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.ci != '') {
      context.read<UsersBloc>().add(GetListUserEvent(widget.ci!));
    }
    return WillPopScope(
      onWillPop: () async {
        context.read<UsersBloc>().add(ListUsersEvent());
        return true;
      },
      child: Scaffold(
          appBar: AppBar(title: const Text('Registro'),actions: [
             InkWell(
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(RoutersApp.rootRoute),
            child: Container(
                padding: const EdgeInsets.only(right: 10, left: 40),
                child: const Icon(Icons.exit_to_app)),
          )
          ],),
          body: Form(
            key: _formKey,
            child: BlocBuilder<UsersBloc, UserState>(
              builder: (context, userData) {
                if (userData is GetUserById) {
                  _ci = TextEditingController(text: userData.user!.ci);
                  _names = TextEditingController(text: userData.user!.name);
                  _surnames =
                      TextEditingController(text: userData.user!.surname);
                  _email = TextEditingController(text: userData.user!.email);

                  _date = TextEditingController(
                      text: userData.user!.dateBirthdays.toString());
                  role = userData.user!.role;

                  password = userData.user!.password;
                  _address =
                      TextEditingController(text: userData.user!.addressHome);
                  _phoneNumber =
                      TextEditingController(text: userData.user!.phoneNumber);
                  if (userData.user!.role == 'Empleado') {
                    widget.admin != false;
                  }
                } else {
                  _ci = TextEditingController(text: '');
                  _names = TextEditingController(text: '');
                  _surnames = TextEditingController(text: '');
                  _email = TextEditingController(text: '');
                  _address = TextEditingController(text: '');
                  _phoneNumber = TextEditingController(text: '');
                  _date = TextEditingController(text: '');
                  widget.admin != false;
                  role = 'Empleado';
                  check='NoVacunado';
                }
                return Container(
                  alignment: Alignment.topCenter,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: BlocBuilder<FormBloc, FormStateValid>(
                    builder: (context, state) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InputText(
                            enable: widget.ci != '' ? true : false,
                            maxLenght: 10,
                            validator: (input) {
                              if (input!.length < 10) {
                                return "Tiene ${input.length} de 10";
                              } else {
                                int suma = 0, number = 0, result = 0;
                                for (var i = 0; i < input.length - 1; i++) {
                                  if (i % 2 == 0) {
                                    number = int.parse(input[i]) * 2;
                                    if (number > 9) {
                                      suma = suma + number - 9;
                                    } else {
                                      suma = suma + number;
                                    }
                                  } else {
                                    number = int.parse(input[i]) * 1;
                                    if (number > 9) {
                                      suma = suma + number - 9;
                                    } else {
                                      suma = suma + number;
                                    }
                                  }
                                }
                                result = ((int.parse(
                                            suma.toString().substring(0, 1)) +
                                        1) *
                                    10);

                                if (result - suma == num.parse(input[9])) {
                                  return null;
                                } else {
                                  return 'cedula invalida';
                                }
                              }
                            },
                            icon: const Icon(Icons.credit_card),
                            textEditController: _ci,
                            textInputType: TextInputType.number,
                            textInputFormatter:
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9]')),
                            maxLines: 2,
                            onChange: (value) {},
                            text: "Cédula",
                          ),
                          InputText(
                            validator: (input) =>
                                input!.isEmpty ? 'Ingrese Los Nombres' : null,
                            icon: const Icon(Icons.account_box_rounded),
                            textEditController: _names,
                            textInputType: TextInputType.text,
                            textInputFormatter:
                                FilteringTextInputFormatter.allow(
                                    RegExp('[a-z A-Z À-ÿ]')),
                            maxLines: 2,
                            onChange: (value) {},
                            text: "Nombres ",
                          ),
                          InputText(
                            validator: (input) =>
                                input!.isEmpty ? 'Ingrese el Apellido' : null,
                            emailFocusNode: _emailFocusNode,
                            icon: const Icon(Icons.account_box_rounded),
                            textEditController: _surnames,
                            textInputType: TextInputType.text,
                            textInputFormatter:
                                FilteringTextInputFormatter.allow(
                                    RegExp('[a-z A-Z À-ÿ]')),
                            maxLines: 2,
                            onChange: (value) {},
                            text: "Apellidos ",
                          ),
                          InputText(
                            errortext: state.email.invalid
                                ? 'Por favor ingrese un correo valido'
                                : null,
                            validator: (input) => !input!.contains('@')
                                ? 'correo invalido'
                                : null,
                            icon: const Icon(Icons.email_outlined),
                            textEditController: _email,
                            textInputType: TextInputType.emailAddress,
                            textInputFormatter:
                                FilteringTextInputFormatter.singleLineFormatter,
                            maxLines: 2,
                            onChange: (value) {
                              context
                                  .read<FormBloc>()
                                  .add(EmailChanged(email: value));
                            },
                            text: "Correo Electrónico ",
                          ),
                          role == 'Empleado' && !widget.admin!
                              ? InkWell(
                                  onTap: (() async {
                                    date = (await showDialog<DateTime>(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Container(
                                              height: 300,
                                              width: 300,
                                              child: SfDateRangePicker(
                                                showActionButtons: true,
                                                cancelText: 'Cancelar',
                                                confirmText: 'OK',
                                                onSubmit: (value) {
                                                  Navigator.of(context)
                                                      .pop(value);
                                                },
                                                onCancel: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ),
                                          );
                                        }))!;

                                    _date.text =
                                        DateFormat.yMMMEd('es').format(date);
                                  }),
                                  child: Stack(
                                    children: [
                                      InputText(
                                        validator: (input) => input!.isEmpty
                                            ? 'campo vacio'
                                            : null,
                                        icon: const Icon(Icons.calendar_month),
                                        textEditController: _date,
                                        textInputType: TextInputType.text,
                                        textInputFormatter:
                                            FilteringTextInputFormatter
                                                .singleLineFormatter,
                                        maxLines: 2,
                                        enable: true,
                                        onChange: (value) {
                                          context
                                              .read<FormBloc>()
                                              .add(EmailChanged(email: value));
                                        },
                                        text: "Fecha de Nacimiento ",
                                      ),
                                      Container(
                                        height: 50,
                                        color: Colors.red.withOpacity(0),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                          widget.admin!
                              ? BlocConsumer<ChangeStateRadio, String>(
                                  listener: (context, state) {},
                                  builder: (context, stateRole) {
                                    role = stateRole;
                                    return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text('Admin'),
                                          Radio(
                                              value: 'Admin',
                                              groupValue: role,
                                              onChanged: (_value) {
                                                role = _value!;
                                                context
                                                    .read<ChangeStateRadio>()
                                                    .add(ChangeRoleEvent(
                                                        role.toString()));
                                              }),
                                          const Text('Empleado'),
                                          Radio(
                                              value: 'Empleado',
                                              groupValue: role,
                                              onChanged: (_value) {
                                                role = _value!;
                                                context
                                                    .read<ChangeStateRadio>()
                                                    .add(ChangeRoleEvent(
                                                        role.toString()));
                                              }),
                                        ]);
                                  },
                                )
                              : Container(),
                          role == 'Empleado' && !widget.admin!
                              ? InputText(
                                  validator: (input) => input!.isEmpty
                                      ? 'Ingrese la Direción'
                                      : null,
                                  icon: const Icon(Icons.home),
                                  textEditController: _address,
                                  textInputType: TextInputType.text,
                                  textInputFormatter:
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[a-z A-Z À-ÿ]')),
                                  maxLines: 2,
                                  onChange: (value) {},
                                  text: "Dirección de Domicilio ",
                                )
                              : Container(),
                          role == 'Empleado' && !widget.admin!
                              ? InputText(
                                  validator: (input) => input!.isEmpty
                                      ? 'Ingrese el número de celular'
                                      : null,
                                  icon: const Icon(Icons.phone_android),
                                  textEditController: _phoneNumber,
                                  textInputType: TextInputType.number,
                                  textInputFormatter:
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[0-9]')),
                                  maxLines: 2,
                                  onChange: (value) {},
                                  text: "Celular",
                                )
                              : Container(),
                          role == 'Empleado' && !widget.admin!
                              ? BlocConsumer<ChangeStateRadio, String>(
                                  listener: (context, state) {},
                                  builder: (context, stateRole) {
                                    check = stateRole;
                                    return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text('Vacunado'),
                                          Radio(
                                              value: 'Vacunado',
                                              groupValue: check,
                                              onChanged: (_value) {
                                                check = _value!;
                                                showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        VaccinationWidget(
                                                            role: 'Empleado',
                                                            admin: false,
                                                            userId: _ci.text));
                                                             context
                                                    .read<ChangeStateRadio>()
                                                    .add(ChangeRoleEvent(
                                                        check.toString()));
                                              }),
                                          const Text('No Vacunado'),
                                          Radio(
                                              value: 'NoVacunado',
                                              groupValue: role,
                                              onChanged: (_value) {
                                                check = _value!;
                                                 context
                                                    .read<ChangeStateRadio>()
                                                    .add(ChangeRoleEvent(
                                                        check.toString()));
                                              }),
                                        ]);
                                  },
                                )
                              : Container(),
                          BlocConsumer<UsersBloc, UserState>(
                            listener: (context, state) {
                              if (state is UserHasData) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Guardado')),
                                );
                                context
                                    .read<UsersBloc>()
                                    .add(GetListUserEvent(widget.ci!));
                              } else if (state is UserExistState) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Usuario ya existe')),
                                );
                              } else if (state is UserUpdate) {
                                if (widget.ci != '') {
                                  context
                                      .read<UsersBloc>()
                                      .add(GetListUserEvent(_ci.text));
                                }

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Datos Actualizados')),
                                );
                              }
                            },
                            builder: (context, stateUser) {
                              return Column(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 45,
                                    child: BlockButtonWidget(
                                      text: const Text("Guardar"),
                                      color: OutlinedButton.styleFrom(
                                        primary: Colors.teal,
                                      ),
                                      onPressed: () {
                                        if (!_formKey.currentState!
                                            .validate()) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    'Cumplir los campos solicitados')),
                                          );
                                        } else if (widget.ci == "") {
                                          context.read<UsersBloc>().add(
                                              UserCreate(Users(
                                                  _names.text,
                                                  _ci.text,
                                                  _surnames.text,
                                                  _email.text,
                                                  role.toString(),
                                                  _date.text,
                                                  _address.text,
                                                  _phoneNumber.text,
                                                  password)));
                                          context
                                              .read<UsersBloc>()
                                              .add(ListUsersEvent());
                                        } else {
                                          context.read<UsersBloc>().add(
                                              PutUserEvent(Users(
                                                  _names.text,
                                                  _ci.text,
                                                  _surnames.text,
                                                  _email.text,
                                                  role.toString(),
                                                  _date.text,
                                                  _address.text,
                                                  _phoneNumber.text,
                                                  password)));
                                          context
                                              .read<UsersBloc>()
                                              .add(ListUsersEvent());
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          )),
    );
  }
}
