import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vacunation_test_kruger/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:vacunation_test_kruger/routes/router.dart';

class ListUserScreen extends StatefulWidget {
  const ListUserScreen({Key? key}) : super(key: key);

  @override
  State<ListUserScreen> createState() => _ListUserScreenState();
}

class _ListUserScreenState extends State<ListUserScreen> {
  @override
  void initState() {
    context.read<UsersBloc>().add(ListUsersEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Usuarios'),
        actions: [
          InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(RoutersApp.dataRoute);
              },
              child: const Icon(Icons.table_view)),
          InkWell(
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(RoutersApp.rootRoute),
            child: Container(
                padding: const EdgeInsets.only(right: 10, left: 40),
                child: const Icon(Icons.exit_to_app)),
          )
        ],
      ),
      body: BlocConsumer<UsersBloc, UserState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ListUsersState) {
            return ListView(children: [
              ...state.users!.map((_user) => Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Dismissible(
                      confirmDismiss: (DismissDirection direction) async {
                        if (direction.index == 3) {
                          return await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: const ListTile(
                                title: Text("Atención"),
                                subtitle: Text(
                                    "Esta Seguro de eliminar el registro?"),
                              ),
                              actions: <Widget>[
                                TextButton(
                                    child: const Text('Ok'),
                                    onPressed: () {
                                      context
                                          .read<UsersBloc>()
                                          .add(DeleteUser(_user.ci));
                                      Navigator.of(context).pop();
                                    }),
                                TextButton(
                                    child: const Text('Cancelar'),
                                    onPressed: () {
                                      setState(() {});
                                      Navigator.of(context).pop();
                                    }),
                              ],
                            ),
                          );
                        } else {
                          Navigator.of(context).pushNamed(
                              RoutersApp.registerRoute +
                                  '?user_id=${_user.ci}');
                        }
                      },
                      onDismissed: (DismissDirection direction) {},
                      key: UniqueKey(),
                      secondaryBackground: Container(
                        child: const Center(
                          child: Text(
                            'Editar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        color: Colors.green,
                      ),
                      background: Container(
                        child: const Center(
                          child: Text(
                            'Eliminar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        color: Colors.red,
                      ),
                      child: InkWell(
                        onTap: () {
                          Clipboard.setData(ClipboardData(
                              text: "${_user.ci} \n ${_user.password}"));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Copiado')),
                          );
                        },
                        child: Card(
                          elevation: 5,
                          child: ListTile(
                            title: Text(_user.name + ' ' + _user.surname),
                            leading: Icon(Icons.account_circle_sharp),
                            trailing: Icon(Icons.copy),
                            subtitle: Text(_user.role),
                          ),
                        ),
                      ),
                    ),
                  ))
            ]);
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: (() {
            Navigator.of(context).pushNamed(RoutersApp.registerRoute);
          })),
    );
  }
}
