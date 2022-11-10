import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/news_app/business_logic/cubit/app_cubit.dart';

import '../../components/article_item_builder.dart';
import '../../components/default_text_field.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var list = AppCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultTextField(
                  textInputType: TextInputType.text,
                  controller: searchController,
                  labeltext: 'Search',
                  onChange: (value) {
                    AppCubit.get(context).getSearch(value);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Search must not be empty';
                    }
                    return null;
                  },
                  prefixIcon: Icons.search,
                ),
              ),
              Expanded(child: articleItemBuilder(list, context,isSearch: true)),
            ],
          ),
        );
      },
    );
  }
}
