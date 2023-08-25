import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medium_uz/utils/ui_utils/custom_circular.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../cubit/article_cubit/article_cubit.dart';
import '../../../cubit/article_cubit/article_model.dart';
import '../../../cubit/article_cubit/article_state.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/ui_utils/error_message_dialog.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({super.key});

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Articles screen"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: BlocConsumer<ArticleCubit, ArticleState>(
        listener: (context, state) {
          if (state is ArticleLoadingState) {
            const Center(
              child: CustomCircularProgressIndicator(),
            );
          }
          if (state is ArticleErrorState) {
            showErrorMessage(message: state.errorText, context: context);
          }
        },
        builder: (context, state) {
          if (state is ArticleGetState) {
            return ListView(
              children: [...List.generate(state.articleModel.length, (index) {
                ArticleModel articleModel = state.articleModel[index];
                return ListTile(
                  leading:  ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: Hero(
        tag: 'tag$index',
        child: CachedNetworkImage(
          imageUrl:
              '$baseUrlImage${articleModel.avatar}',
          height: 100,
          width: 80,
          fit: BoxFit.cover,
          placeholder: (context, url) => const Center(
              child: CupertinoActivityIndicator(
            color: AppColors.passiveTextColor,
          )),
          errorWidget: (context, url, error) =>
              Icon(
            Icons.error,
            color: AppColors.c_C93545,
          ),
        ),
      ),
    ),
                  title:  Text(
                    articleModel.title,
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: AppColors.passiveTextColor),
                  ),

                  subtitle:
                      Text(
                        articleModel.description,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.passiveTextColor),
                      ),

                  trailing:
                  Text(
                  articleModel.views,
                    style:const TextStyle(
                        color:
                        AppColors.passiveTextColor),
                  ),
                );


              },)
              ],
            );
          }
          return const Center(
            child: Center(child: Text(
              "articles not found", style: TextStyle(color: Colors.black),),),
          );
        },
      ),
    );
  }
}

// Navigator.pushNamed(context, RouteNames.articleDetail, arguments: {
// 'article': articleModel,
// 'index':index
