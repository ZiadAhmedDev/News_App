import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/news_cubit/news_cubit.dart';
import 'package:news_app/layout/news_app/news_layout.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'layout/news_app/news_cubit/news_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBol(key: 'isDark');
  runApp(NewsApp(isDark!));
}

class NewsApp extends StatelessWidget {
  final bool isDark;
  const NewsApp(this.isDark, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewsCubit>(
      create: ((context) => NewsCubit()
        ..getHttpBusiness()
        ..getHttpSport()
        ..getHttpScience()
        ..changeThemeMode(fromShared: isDark)),
      child: BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: const NewsLayout(),
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                iconTheme: IconThemeData(color: Colors.black, size: 25),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                color: Colors.white,
                elevation: 0,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Colors.white,
                unselectedItemColor: Colors.grey,
                selectedItemColor: Colors.deepOrange,
                selectedIconTheme: IconThemeData(
                  size: 25,
                ),
                selectedLabelStyle:
                    TextStyle(fontSize: 18, color: Colors.deepOrange),
                unselectedIconTheme: IconThemeData(color: Colors.grey),
                elevation: 20.0,
              ),
              primaryTextTheme: const TextTheme(
                bodyText2: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              colorScheme: const ColorScheme.light(
                  onBackground: Colors.black, background: Colors.white),
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: const Color(0xff333739),
              primarySwatch: Colors.deepOrange,
              appBarTheme: const AppBarTheme(
                iconTheme: IconThemeData(color: Colors.white, size: 30),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Color(0xff333739),
                  statusBarIconBrightness: Brightness.light,
                ),
                color: Color(0xff333739),
                elevation: 0,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Color(0xff333739),
                unselectedItemColor: Colors.grey,
                selectedItemColor: Colors.deepOrange,
                selectedIconTheme: IconThemeData(
                  size: 25,
                ),
                selectedLabelStyle:
                    TextStyle(fontSize: 18, color: Colors.deepOrange),
                unselectedIconTheme: IconThemeData(color: Colors.grey),
                elevation: 20.0,
              ),
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              colorScheme: const ColorScheme.dark(
                  onBackground: Colors.white, background: Colors.black),
            ),
            themeMode: NewsCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
          );
        },
      ),
    );
  }
}
