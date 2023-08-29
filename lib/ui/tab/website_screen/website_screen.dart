import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medium_uz/cubit/website_cubit/website_cubit.dart';
import 'package:medium_uz/utils/ui_utils/custom_circular.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/models/website_model/website_model.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/ui_utils/error_message_dialog.dart';
import '../../routes/app_routes.dart';

class WebsiteScreen extends StatefulWidget {
  const WebsiteScreen({super.key});

  @override
  State<WebsiteScreen> createState() => _WebsiteScreenState();
}

class _WebsiteScreenState extends State<WebsiteScreen> {
  _init(){
    Future.microtask(() => BlocProvider.of<WebsiteCubit>(context).getInfoWebsite());
  }
  @override
  void initState() {
    _init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("website screen"),

      ),
      body: BlocConsumer<WebsiteCubit, WebsiteState>(
        listener: (context, state) {
          if (state is WebsiteLoadingState) {
            const Center(
              child: CustomCircularProgressIndicator(),
            );
          }
          if (state is WebsiteErrorState) {
            showErrorMessage(message: state.errorText, context: context);
          }
        },
        builder: (context, state) {
          if (state is WebsiteGetState) {
            return ListView(
              children: [
                ...List.generate(
                  state.websiteModel.length,
                      (index) {
                    WebsiteModel websiteModel = state.websiteModel[index];
                    return ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, RouteNames.websiteDetail,
                            arguments: websiteModel.id);
                        },
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(26),
                        child: Hero(
                          tag: 'tag$index',
                          child: CachedNetworkImage(
                            imageUrl: '$baseUrlImage${websiteModel.image}',
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
                      ),
                      title: Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: (){
                            launchInBrowser(
                              Uri.parse(websiteModel.link ?? "")
                            );
                          },
                          child: Text(
                            websiteModel.link,
                            style: TextStyle(
                                fontSize: 18.sp, color: Colors.blue),
                          ),
                        ),
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            websiteModel.contact,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16.sp, color: AppColors.black),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            websiteModel.hashtag,
                            style:
                            const TextStyle(color: AppColors.black),
                          ),
                        ],
                      ),

                    );
                  },
                )
              ],
            );
          }
          return const Center(
            child: Center(
              child: Text(
                "websites not found",
                style: TextStyle(color: Colors.black),
              ),
            ),
          );
        },
      ),
    );
  }
}
