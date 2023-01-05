import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/components.dart';

import '../../layout/news_app/news_cubit/news_cubit.dart';
import '../../layout/news_app/news_cubit/news_state.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                defaultTextFormField(
                  context: context,
                  controller: searchController,
                  textStyle: const TextStyle(color: Colors.white),
                  onChange: (value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                  type: TextInputType.text,
                  validatorFunction: (String? value) {
                    value!.isEmpty ? 'Search must not be empty' : null;
                    return null;
                  },
                  label: const Text('Search'),
                  prefix: const Icon(Icons.search),
                ),
                Expanded(
                  child: articleBuilder(
                      list: list, context: context, isSearch: true),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
