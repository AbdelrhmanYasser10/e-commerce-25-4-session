import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app_session/cubits/app_cubit/app_cubit.dart';
import 'package:e_commerce_app_session/screens/products_screen.dart';
import 'package:e_commerce_app_session/utils/colors/app_colors.dart';
import 'package:e_commerce_app_session/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Our Categories",
          style: AppTextStyle.font24BlackTextStyle(),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          if(state is GetCategoriesLoading){
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          }
          else if(state is GetCategoriesError){
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "There's an error while loading, try again later",
                      style: AppTextStyle.font24BlackTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                      onPressed: () {
                        AppCubit.get(context).getCategoryData();
                      },
                      child: const Text(
                        "Reload",
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          var cubit = AppCubit.get(context);
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),

            itemCount: cubit.categories!.data!.data!.length,
            itemBuilder: (context, index) {
              var cateogry = cubit.categories!.data!.data!;
              return GestureDetector(
                onTap: (){
                  AppCubit.get(context).getAllProductsFromCategory(categoryId: cateogry[index].id!);
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>ProductsScreen(title: cateogry[index].name!)));
                },
                child: Column(
                  children: [
                    Expanded(
                      child: CachedNetworkImage(
                        imageUrl: cateogry[index].image!,
                        width: double.infinity,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) =>
                            const LinearProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    Text(
                      cateogry[index].name!,
                      maxLines: 1,
                      style: AppTextStyle.font18BlackTextStyle(),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
