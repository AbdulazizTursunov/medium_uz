import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medium_uz/utils/ui_utils/custom_circular.dart';
import '../../../../cubit/article_cubit/article_cubit.dart';
import '../../../../data/models/article_model/article_model.dart';
import '../../../../cubit/article_cubit/article_state.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/ui_utils/error_message_dialog.dart';

class ArticleDetailScreen extends StatefulWidget {
  const ArticleDetailScreen({super.key, required this.id});

  final int id;

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  @override
  void initState() {
    context.read<ArticleCubit>().getInfoArticleById(idArticle: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Articles detail screen")),
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
          if (state is ArticleGetStateById) {
            return ListView(
              children: [
                Container(
                  height: 250,
               width: 250,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(26),
                    child: Hero(
                      tag: 'tag${widget.id}',
                      child: CachedNetworkImage(
                        imageUrl: '$baseUrlImage${state.artModel.avatar}',
                        height: 100,
                        width: 80,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                            child: CupertinoActivityIndicator(
                              color: AppColors.passiveTextColor,
                            )),
                        errorWidget: (context, url, error) => Icon(
                          Icons.error,
                          color: AppColors.c_C93545,
                        ),
                      ),
                    ),
                  ), ),
          Text(
          state.artModel.title,
          style: TextStyle(
          fontSize: 18.sp, color: AppColors.black),
          ),
                SizedBox(height: 20.h),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
            state.artModel.description,
            // maxLines: 4,
            style: TextStyle(
            fontSize: 16.sp, color: AppColors.black),
            ),
          ),
              ],
            );
          }
          return const Center(
            child: Center(
              child: Text(
                "articles not found",
                style: TextStyle(color: Colors.black),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Navigator.pushNamed(context, RouteNames.articleDetail, arguments: {
// 'article': articleModel,
// 'index':index
