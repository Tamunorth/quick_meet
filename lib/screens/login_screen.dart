import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_meet/blocs/auth/auth_bloc.dart';
import 'package:quick_meet/blocs/auth/auth_event.dart';
import 'package:quick_meet/blocs/auth/auth_state.dart';
import 'package:quick_meet/generated/assets.dart';
import 'package:quick_meet/utils/app_snackbar.dart';
import 'package:quick_meet/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoadingState) {
        } else if (state is SuccessState) {
          Navigator.pushNamed(context, '/home');
          Navigator.of(context).pop();
        } else if (state is ErrorState) {
          QuickMeet.showSnackBar(context, state.message, type: SnackType.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
            body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Start or Join Meeting',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Image.asset(Assets.assetsOnboarding),
            ),
            if (state is LoadingState)
              Center(child: CircularProgressIndicator())
            else
              CustomButton(
                text: "Google Sign-in",
                onPressed: () async {
                  BlocProvider.of<AuthBloc>(context).add(SignInEvent());
                },
              ),
          ],
        ));
      },
    );
  }
}
