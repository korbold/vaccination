import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:vacunation_test_kruger/data/models/vaccination.dart';
import 'package:vacunation_test_kruger/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:vacunation_test_kruger/presentation/bloc/vaccination_bloc/vaccination_bloc.dart';
import 'package:vacunation_test_kruger/presentation/pages/widgets/textInput.dart';

class VaccinationWidget extends StatefulWidget {
  final String role, userId;
  final bool admin;

  const VaccinationWidget(
      {Key? key, required this.role, required this.admin, required this.userId})
      : super(key: key);

  @override
  State<VaccinationWidget> createState() => _VaccinationWidgetState();
}

class _VaccinationWidgetState extends State<VaccinationWidget> {
  Object role = "", check="";
  late DateTime date;
  late TextEditingController _date;
  late TextEditingController _numberDoses;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    role = widget.role;
    _date = TextEditingController(text: '');
    _numberDoses = TextEditingController(text: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: <Widget>[
        TextButton(
          child: const Text('Guardar'),
          onPressed: () {
            if (!_formKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cumplir los campos solicitados')),
              );
            } else {
              context.read<VaccinationBloc>().add(CreateVaccinationEvent(
                  Vaccination(widget.userId, role.toString(), _date.text,
                      int.parse(_numberDoses.text))));
              Navigator.of(context).pop();
            }
          },
        ),
      ],
      content: SizedBox(
        height: 300,
        width: 450,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              role == 'Empleado' && !widget.admin
                  ? BlocConsumer<ChangeStateRadio, String>(
                      listener: (context, state) {
                        
                      },
                      builder: (context, stateRole) {
                        check = stateRole;
                        return Column(
                          children: [
                            Text('Tipo de Vacuna'),
                            Divider(),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text('Sputnik'),
                                  Radio(
                                      value: 'Sputnik',
                                      groupValue: check,
                                      onChanged: (_value) {
                                        check = _value!;
                                        context.read<ChangeStateRadio>().add(
                                            ChangeRoleEvent(check.toString()));
                                      }),
                                  const Text('AstraZeneca'),
                                  Radio(
                                      value: 'AstraZeneca',
                                      groupValue: check,
                                      onChanged: (_value) {
                                        check = _value!;
                                        context.read<ChangeStateRadio>().add(
                                            ChangeRoleEvent(check.toString()));
                                      }),
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text('Pfizer'),
                                  Radio(
                                      value: 'Pfizer',
                                      groupValue: check,
                                      onChanged: (_value) {
                                        check = _value!;
                                        context.read<ChangeStateRadio>().add(
                                            ChangeRoleEvent(check.toString()));
                                      }),
                                  const Text('Jhonson&Jhonson'),
                                  Radio(
                                      value: 'Jhonson&Jhonson',
                                      groupValue: check,
                                      onChanged: (_value) {
                                        check = _value!;
                                        context.read<ChangeStateRadio>().add(
                                            ChangeRoleEvent(role.toString()));
                                      }),
                                ]),
                          ],
                        );
                      },
                    )
                  : Container(),
              role == 'Empleado' && !widget.admin
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
                                      Navigator.of(context).pop(value);
                                    },
                                    onCancel: () {
                                      Navigator.of(context);
                                    },
                                  ),
                                ),
                              );
                            }))!;
        
                        _date.text = DateFormat.yMMMEd('es').format(date);
                      }),
                      child: Stack(
                        children: [
                          InputText(
                            validator: (input) =>
                                input!.isEmpty ? 'campo vacio' : null,
                            icon: const Icon(Icons.calendar_month),
                            textEditController: _date,
                            textInputType: TextInputType.text,
                            textInputFormatter:
                                FilteringTextInputFormatter.singleLineFormatter,
                            maxLines: 2,
                            enable: true,
                            onChange: (value) {
                              context
                                  .read<FormBloc>()
                                  .add(EmailChanged(email: value));
                            },
                            text: "Fecha de Vacunación ",
                          ),
                          Container(
                            height: 50,
                            color: Colors.red.withOpacity(0),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              role == 'Empleado' && !widget.admin
                  ? InputText(
                      validator: (input) =>
                          input!.isEmpty ? 'Ingrese el número de dosis' : null,
                      icon: const Icon(Icons.numbers),
                      textEditController: _numberDoses,
                      textInputType: TextInputType.number,
                      textInputFormatter:
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      maxLines: 2,
                      onChange: (value) {},
                      text: "Número de Dosis",
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
