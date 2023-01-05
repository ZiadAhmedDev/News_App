import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/news_cubit/news_cubit.dart';
import 'package:news_app/layout/news_app/news_cubit/news_state.dart';
import 'package:news_app/shared/components/components.dart';

class BusinessesScreen extends StatelessWidget {
  const BusinessesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).getBusiness;
        return articleBuilder(list: list);
      },
    );
  }
}
