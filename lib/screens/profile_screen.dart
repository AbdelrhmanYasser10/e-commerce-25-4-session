import 'package:e_commerce_app_session/cubits/app_cubit/app_cubit.dart';
import 'package:e_commerce_app_session/network/local/cache_helper.dart';
import 'package:e_commerce_app_session/screens/login_screen.dart';
import 'package:e_commerce_app_session/utils/colors/app_colors.dart';
import 'package:e_commerce_app_session/utils/text_styles/text_styles.dart';
import 'package:e_commerce_app_session/utils/widgets/app_button/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Account",
          style: AppTextStyle.font24BlackTextStyle(),
        ),
      ),
      body: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          if(state is GetUserDataLoading){
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              ),
            );
          }
          var user = AppCubit.get(context).user!;
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 65,
                        backgroundColor: AppColors.primaryColor,
                        child: CircleAvatar(
                          radius: 62,
                          backgroundImage: NetworkImage(
                            user.data!.image!,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    userDataFields(
                      title: "Email",
                      value: user.data!.email!,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    userDataFields(
                      title: "Username",
                      value: user.data!.name!,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    userDataFields(
                      title: "Phone",
                      value: user.data!.phone!,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: AppButton(
                              text: "Edit data",
                              fn: (){},
                            ),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                            child: AppButton(
                              text: "Logout",
                              fn: (){
                                CacheHelper.removeData(key: "token").then((value){
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) {
                                            return const LoginScreen();
                                          },
                                      )
                                    ,);
                                });
                              },
                            ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget userDataFields({
  required String title,
  required String value,
}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.font32BlackTextStyle(),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Text(
          value,
          style: AppTextStyle.font20BlueGreyTextStyle(),
        ),
      ],
    );
  }
}
