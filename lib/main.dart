import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_meet/blocs/meeting/meeting_bloc.dart';
import 'package:quick_meet/screens/home_screen.dart';
import 'package:quick_meet/screens/login_screen.dart';
import 'package:quick_meet/screens/video_call_screen.dart';
import 'package:quick_meet/services/auth_service.dart';
import 'package:quick_meet/utils/colors.dart';

import 'blocs/auth/auth_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarIconBrightness: ThemeMode.system == ThemeMode.dark
          ? Brightness.light
          : Brightness.dark,
      statusBarBrightness: ThemeMode.system == ThemeMode.dark
          ? Brightness.light
          : Brightness.dark,
    ));
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<MeetingBloc>(
          create: (context) => MeetingBloc(),
        ),
      ],
      child: MaterialApp(
          title: 'Quick Meet',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: Pallets.backgroundColor,
          ),
          routes: {
            '/login': (context) => const LoginScreen(),
            '/home': (context) => const HomeScreen(),
            '/video-call': (context) => const VideoCallScreen(),
          },
          home: StreamBuilder(
            stream: AuthService().authChanges,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: const CircularProgressIndicator());
              }

              if (snapshot.hasData) {
                return const HomeScreen();
              }

              return const LoginScreen();
            },
          )),
    );
  }
}
