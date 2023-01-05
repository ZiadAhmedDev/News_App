import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/news_app/news_cubit/news_cubit.dart';
import '../../layout/news_app/news_cubit/news_state.dart';
import '../../shared/components/components.dart';

class SportScreen extends StatelessWidget {
  const SportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).getSports;
        return articleBuilder(list: list);
      },
    );
  }
}
