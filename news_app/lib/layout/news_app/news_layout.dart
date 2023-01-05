import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/news_cubit/news_cubit.dart';
import 'package:news_app/layout/news_app/news_cubit/news_state.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/shared/components/components.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'News App',
              style: TextStyle(fontSize: 22),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: (() {
                  navigateTo(context, SearchScreen());
                }),
              ),
              IconButton(
                icon: const Icon(Icons.brightness_4_outlined),
                onPressed: (() {
                  NewsCubit.get(context).changeThemeMode();
                }),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: cubit.bottomNavItem,
            currentIndex: cubit.currentIndex,
          ),
          body: cubit.screen[cubit.currentIndex],
        );
      },
    );
  }
}
