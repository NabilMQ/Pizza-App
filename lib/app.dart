import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/app_view.dart';
import 'package:user_repository/user_repository.dart';

import 'blocs/authenticationBloc/authentication_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp(this.userRepository, {super.key});

  final UserRepository userRepository;


  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(
        userRepository: userRepository,
      ),
      child: MyAppView(),
    );
  }
}