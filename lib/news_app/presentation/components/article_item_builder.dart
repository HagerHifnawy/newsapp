
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import 'build_article_item.dart';
import 'my_divider.dart';

Widget articleItemBuilder(list, BuildContext context,{isSearch=false}) => ConditionalBuilder(
  condition: list.length > 0,
  builder: (context) => Scaffold(
    body: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) =>
            buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: list.length),
  ),
  fallback: (BuildContext context) =>isSearch? Container():
  Center(child: CircularProgressIndicator()),
);