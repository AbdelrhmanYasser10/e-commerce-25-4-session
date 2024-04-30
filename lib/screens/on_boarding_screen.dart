import 'package:e_commerce_app_session/screens/login_screen.dart';
import 'package:e_commerce_app_session/utils/text_styles/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../models/on_boarding_model.dart';
import '../utils/colors/app_colors.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController controller = PageController();
  List<OnBoardingModel> models = [
    OnBoardingModel(
        imgLink: "assets/images/on_boarding1.svg",
        title: "Setup Wizard",
        description: "Here is some description about this topic we can make a lot of difference using this app",
    ),
    OnBoardingModel(
        imgLink: "assets/images/on_boarding2.svg",
        title: "Unique Experience",
        description: "Here is some description about this topic we can make a lot of difference using this app",
    ),
    OnBoardingModel(
        imgLink: "assets/images/on_boarding3.svg",
        title: "Easy Payment",
        description: "Here is some description about this topic we can make a lot of difference using this app",
    ),
  ];
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: PageView.builder(
                      controller: controller,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(
                              models[index].imgLink,
                              height: MediaQuery.of(context).size.height / 4,
                            ),
                            Text(
                              models[index].title,
                              style: AppTextStyle.font32BlackTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              models[index].description,
                              style: AppTextStyle.font20BlueGreyTextStyle(),
                              textAlign: TextAlign.center,
                            ),

                          ],
                        );
                      },
                    itemCount: 3,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          if(controller.page!.round() < 2) {
                            controller.nextPage(
                              duration: const Duration(seconds: 1),
                              curve: Curves.linear,

                            );
                          }else{
                            // navigate to home
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_)=>const LoginScreen()),
                                    (route) => false,
                            );
                          }
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                AppColors.primaryColor,
                                AppColors.secondColor,
                              ],
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              "NEXT",
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                      SmoothPageIndicator(
                        controller: controller,
                        count:  3,
                        axisDirection: Axis.horizontal,
                        effect: const SwapEffect (
                          type: SwapType.yRotation,
                            paintStyle:  PaintingStyle.fill,
                            strokeWidth:  1.5,
                            dotColor:  Colors.grey,
                            activeDotColor:  AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
