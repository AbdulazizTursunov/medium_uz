import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medium_uz/cubit/auth/auth_cubit.dart';
import 'package:medium_uz/cubit/tab_cubit/tab_box_cubit.dart';
import 'package:medium_uz/cubit/user_cubit/user_cubit.dart';
import 'package:medium_uz/cubit/user_data_cubit/user_data_cubit.dart';
import 'package:medium_uz/cubit/website_cubit/website_cubit.dart';
import 'package:medium_uz/data/network/user_api_service.dart';
import 'package:medium_uz/data/repositories/article_repository.dart';
import 'package:medium_uz/data/repositories/user_repository.dart';
import 'package:medium_uz/data/repositories/website_repositories.dart';
import 'package:medium_uz/ui/routes/app_routes.dart';
import 'package:medium_uz/utils/theme.dart';
import 'cubit/article_cubit/article_cubit.dart';
import 'cubit/profile_cubit/profile_cubit.dart';
import 'data/local/storage_repository.dart';
import 'data/network/api_service.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/profile_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await StorageRepository.getInstance();

  runApp(App(apiService: ApiService()));
}

class App extends StatelessWidget {
  const App({super.key, required this.apiService});

  final ApiService apiService;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepo(apiService: apiService),
        ),
        RepositoryProvider(
          create: (context) => ArticleRepositories(apiService: apiService),
        ),
        RepositoryProvider(
          create: (context) => USerRepositories(userApiService: UserApiService()),
        ),
        RepositoryProvider(
          create: (context) => ProfileRepository(apiService: apiService),
        ),
        RepositoryProvider(
          create: (context) => WebsiteRepository(apiService: apiService),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthenticationCubit(
              authRepository: context.read<AuthRepo>(),
            ),
          ),
          BlocProvider(
            create: (context) => UserCubitDio(
              userRepositories:  context.read<USerRepositories>(),
            ),
          ),
          BlocProvider(
            create: (context) => ArticleCubit(
                articleRepositories: context.read<ArticleRepositories>()),
          ),
          BlocProvider(
            create: (context) => ProfileCubit(
               profileRepository:  context.read<ProfileRepository>()),
          ),
          BlocProvider(
            create: (context) => WebsiteCubit(
                websiteRepository:  context.read<WebsiteRepository>()),
          ),
          BlocProvider(
            create: (context) => TabCubit(),
          ),
          BlocProvider(
            create: (context) => UserDataCubit(),
          )
        ],
        child: const MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.lightTheme,
          themeMode: ThemeMode.dark,
          onGenerateRoute: AppRoutes.generateRoute,
          initialRoute: RouteNames.splashScreen,
        );
      },
    );
  }
}
