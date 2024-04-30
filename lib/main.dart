import 'package:e_commerce_app_session/cubits/auth_cubit/auth_cubit.dart';
import 'package:e_commerce_app_session/network/remote/dio_helper.dart';
import 'package:e_commerce_app_session/screens/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.initializeDio();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>AuthCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Amazon Clone',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffF13C02)),
          useMaterial3: false,
        ),
        home: const OnBoardingScreen(),
      ),
    );
  }
}

