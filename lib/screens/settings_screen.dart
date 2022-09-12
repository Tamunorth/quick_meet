import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_meet/blocs/auth/auth_event.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_state.dart';
import '../utils/app_snackbar.dart';
import '../widgets/custom_button.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  final _loadingKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoadingState) {
          QuickMeet.showLoading(context, _loadingKey);
        } else if (state is SuccessState) {
          QuickMeet.hideLoading(_loadingKey);
        } else if (state is ErrorState) {
          QuickMeet.showSnackBar(context, state.message, type: SnackType.error);
        }
      },
      builder: (context, state) {
        return CustomButton(
            text: 'LogOut',
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
            });
      },
    );
  }
}
