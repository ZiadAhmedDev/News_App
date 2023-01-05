import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app/layout/news_app/news_cubit/news_cubit.dart';
import 'package:news_app/modules/webview/webview_screen.dart';

Widget buildArticleItems(article, context) => InkWell(
      onTap: () {
        navigateTo(context, WebViewScreen(article['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(
                    article['urlToImage'] ??
                        "https://ichef.bbci.co.uk/news/1024/branded_arabic/9F2B/production/_125674704_285f1150-b927-4cf3-8411-12d4bf11e147.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: SizedBox(
                height: 100,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: NewsCubit.get(context).isDark
                            ? const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              )
                            : const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: const TextStyle(fontSize: 18, color: Colors.grey),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

Widget listDivider() => const Padding(
      padding: EdgeInsets.only(left: 10),
      child: Divider(
        thickness: 1,
      ),
    );

Widget articleBuilder({required list, context, isSearch = false}) =>
    ConditionalBuilder(
      condition: list.isNotEmpty,
      builder: (context) {
        return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: ((context, index) => buildArticleItems(
                  list[index],
                  context,
                )),
            separatorBuilder: ((context, index) => listDivider()),
            itemCount: 10);
      },
      fallback: (context) => isSearch
          ? Container()
          : SizedBox(
              height: MediaQuery.of(context).size.height * .7,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );

Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  Text? label,
  Icon? prefix,
  TextStyle? textStyle,
  void Function(String)? onChange,
  required String? Function(String?) validatorFunction,
  required BuildContext context,
}) {
  return TextFormField(
    keyboardType: type,
    controller: controller,
    validator: validatorFunction,
    onChanged: onChange,
    style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
    decoration: InputDecoration(
      label: label,
      prefix: prefix,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
    ),
  );
}

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
