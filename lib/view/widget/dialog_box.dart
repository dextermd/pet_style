import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_style/blocs/network_bloc/network_bloc.dart';
import 'package:pet_style/core/helpers/log_helper.dart';

Future<void> showDialogBox(BuildContext context) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('No Connection'),
      content: const Text('Please check your internet connectivity'),
      actions: <Widget>[
        BlocListener<NetworkBloc, NetworkState>(
          listener: (context, state) {
            if (state is NetworkConnected) {
              Navigator.of(context).pop();
              GoRouter.of(context).refresh();
              //context.go('/home');
            }
          },
          child: TextButton(
            onPressed: () async {
              context.read<NetworkBloc>().add(CheckNetworkConnection());
            },
            child: const Text('OK'),
          ),
        ),
      ],
    ),
  );
}
