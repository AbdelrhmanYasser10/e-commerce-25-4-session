import 'package:e_commerce_app_session/cubits/app_cubit/app_cubit.dart';
import 'package:e_commerce_app_session/layout/main_layout.dart';
import 'package:e_commerce_app_session/network/local/cache_helper.dart';
import 'package:e_commerce_app_session/screens/login_screen.dart';
import 'package:e_commerce_app_session/screens/on_boarding_screen.dart';
import 'package:e_commerce_app_session/utils/colors/app_colors.dart';
import 'package:e_commerce_app_session/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  void navigateToDecide({required AppState appState}) {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        bool? passOnBoarding = CacheHelper.getData(key: "onBoardingPass");
        if(passOnBoarding != null) {
          if (appState is GetUserDataSuccessfully) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const MainLayout(),
              ),
            );
          }
          else if (appState is GetUserDataError) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const LoginScreen(),
              ),
            );
          }
        }
        else{
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const OnBoardingScreen(),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        navigateToDecide(appState: state);
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryColor,
                  AppColors.secondColor,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Salla",
                    style: AppTextStyle.font25WhiteTextStyle(),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const LinearProgressIndicator(
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
