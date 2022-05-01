import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:vacunation_test_kruger/data/models/vaccination.dart';

import '../bloc/vaccination_bloc/vaccination_bloc.dart';

class DataGridWidget extends StatefulWidget {
  
  DataGridWidget({Key? key}) : super(key: key);

  @override
  _DataGridWidgetState createState() => _DataGridWidgetState();
}

class _DataGridWidgetState extends State<DataGridWidget> {
  List<Vaccination> employees = [];
  late EmployeeDataSource employeeDataSource;

  @override
  void initState() {
    super.initState();

    employeeDataSource = EmployeeDataSource(employeeData: employees);
    context.read<VaccinationBloc>().add(GetListVaccionation());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultados'),
      ),
      body: BlocBuilder<VaccinationBloc, VaccinationState>(
        builder: (context, state) {
          if (state is GetListVaccionationState) {
            employees = state.vaccination;
            employeeDataSource = EmployeeDataSource(employeeData: employees);
          }
          return SfDataGrid(
            source: employeeDataSource,
            columnWidthMode: ColumnWidthMode.fill,
            columns: <GridColumn>[
              GridColumn(
                  columnName: 'ci',
                  label: Container(
                      padding: EdgeInsets.all(16.0),
                      alignment: Alignment.center,
                      child: Text(
                        'Cédula',
                      ))),
              GridColumn(
                  columnName: 'name',
                  label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: Text('Rol'))),
              GridColumn(
                  columnName: 'date',
                  label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: Text(
                        'Fecha',
                        overflow: TextOverflow.ellipsis,
                      ))),
              GridColumn(
                  columnName: 'dosis',
                  label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: Text('Dosis'))),
            ],
          );
        },
      ),
    );
  }
}

class EmployeeDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  EmployeeDataSource({required List<Vaccination> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'userid', value: e.userId),
              DataGridCell<String>(columnName: 'name', value: e.type),
              DataGridCell<String>(columnName: 'designation', value: e.date),
              DataGridCell<int>(columnName: 'doses', value: e.numberDoses),
            ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}
