import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app_session/cubits/app_cubit/app_cubit.dart';
import 'package:e_commerce_app_session/utils/colors/app_colors.dart';
import 'package:e_commerce_app_session/utils/text_styles/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Favourites",
          style: AppTextStyle.font24BlackTextStyle(),
        ),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);

          if (state is GetFavouritesLoading || cubit.favModel == null) {
            return const Center(
              child: LinearProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          }
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  var product = cubit.favModel!.data!.data![index].product!;
                  return SizedBox(
                    height: height * 0.15,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Stack(
                            children: [
                              CachedNetworkImage(
                                imageUrl: product.image!,
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
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                              product.discount != 0
                                  ? Container(
                                      width: width * (1 / 2) * (1 / 4),
                                      height: height * 0.03,
                                      color: Colors.red,
                                      child: Center(
                                        child: Text(
                                          "${product.discount.toString()}%",
                                          style:
                                              AppTextStyle.font12WhiteTextStyle(),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                product.name!,
                                maxLines: 1,
                                style: AppTextStyle.font18BlackTextStyle(),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text.rich(
                                        TextSpan(
                                          text: "${product.price.toString()} EGP",
                                          style: AppTextStyle.font12OrangeTextStyle(),
                                          children: [
                                            TextSpan(
                                              text: product.discount != 0
                                                  ? " ${product.oldPrice.toString()} EGP"
                                                  : "",
                                              style: AppTextStyle
                                                  .font10BlackTextStyleDisabled(),
                                            ),
                                          ],
                                        ),
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: cubit.favouritesMap[product.id!]!? AppColors.primaryColor:Colors.grey.shade500,
                                    child: IconButton(
                                      onPressed: (){
                                        cubit.changeFavourite(productsId: product.id!);
                                      },
                                      icon: const Icon(
                                        Icons.favorite_outline,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: cubit.favModel!.data!.data!.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 20.0,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
