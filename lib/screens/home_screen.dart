import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app_session/cubits/app_cubit/app_cubit.dart';
import 'package:e_commerce_app_session/utils/colors/app_colors.dart';
import 'package:e_commerce_app_session/utils/functions/snack_bar/snack_bar.dart';
import 'package:e_commerce_app_session/utils/text_styles/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          if (state is GetHomeDataError) {
            showSnackBar(
              context: context,
              title: "Home Data error",
              message: state.message,
              contentType: ContentType.failure,
            );
          }
          if(state is ChangeProductFavouritesError){
            showSnackBar(
              context: context,
              title: "Favourites error",
              message: state.message,
              contentType: ContentType.failure,
            );
          }
        },
        builder: (context, state) {
          if (state is GetHomeDataLoading || AppCubit.get(context).homeModel == null) {
            return const Center(
              child: LinearProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          } else if (state is GetHomeDataError) {
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
                        AppCubit.get(context).getHomeData();
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
          return SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    // Ad
                    CachedNetworkImage(
                      imageUrl: cubit.homeModel!.data!.ad!,
                      width: double.infinity,
                      height: height * (1 / 5),
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
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                    // Banners
                    const SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0,
                      ),
                      child: Text(
                        "Check our offers",
                        style: AppTextStyle.font24BlackTextStyle(),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    CarouselSlider(
                        items: cubit.homeModel!.data!.banners!.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return CachedNetworkImage(
                                imageUrl: i.image!,
                                width: double.infinity,
                                height: height * (1 / 5),
                                imageBuilder: (context, imageProvider) => Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) =>
                                const CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                ),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              );
                            },
                          );
                        }).toList(),
                        options: CarouselOptions(
                          height: height * 0.2,
                          viewportFraction: 0.8,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval:const Duration(seconds: 3),
                          autoPlayAnimationDuration: const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.3,
                          scrollDirection: Axis.horizontal,
                        ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    // TOP PRODUCTS
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                      ),
                      child: Text(
                        "Top Products",
                        style: AppTextStyle.font24BlackTextStyle(),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      primary: false,
                      itemCount: cubit.homeModel!.data!.products!.length,
                      itemBuilder: (context, index) {
                        var products = cubit.homeModel!.data!.products!;
                        return Column(
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: products[index].images![0],
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
                                    const CircularProgressIndicator(
                                      color: AppColors.primaryColor,
                                    ),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                  ),
                                  products[index].discount != 0 ? Container(
                                    width: width * (1/2) * (1/4),
                                    height: height * 0.03,
                                    color: Colors.red,
                                    child: Center(
                                      child: Text(
                                        "${products[index].discount.toString()}%",
                                        style: AppTextStyle.font12WhiteTextStyle(),
                                      ),
                                    ),
                                  ):const SizedBox(),
                                  Positioned(
                                    top: 0,
                                    right: 5,
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: cubit.favouritesMap[products[index].id!]!? AppColors.primaryColor:Colors.grey.shade500,
                                      child: IconButton(
                                        onPressed: (){
                                          cubit.changeFavourite(productsId: products[index].id!);
                                        },
                                        icon: const Icon(
                                          Icons.favorite_outline,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              products[index].name!,
                              maxLines: 1,
                              style: AppTextStyle.font18BlackTextStyle(),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text.rich(
                              TextSpan(
                                text: "${products[index].price.toString()} EGP",
                                style: AppTextStyle.font12OrangeTextStyle(),
                                children: [
                                  TextSpan(
                                    text: products[index].discount != 0 ? " ${products[index].oldPrice.toString()} EGP" : "",
                                    style: AppTextStyle.font10BlackTextStyleDisabled(),
                                  )
                                ],
                            ),
                             maxLines: 1,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        );
                      },
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
}
