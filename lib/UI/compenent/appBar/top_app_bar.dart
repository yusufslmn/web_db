import 'package:flutter/material.dart';
import 'package:web_db/UI/compenent/home/app_bar.dart';
import 'package:web_db/UI/compenent/home/list_category.dart';
import 'package:web_db/UI/compenent/home/row_colors_top.dart';
import 'package:web_db/UI/view/category/category.dart';
import 'package:web_db/core/Utility/colors.dart';
import 'package:web_db/core/Utility/screen_size.dart';
import 'package:web_db/core/model/category/category_model.dart';
import 'package:web_db/core/service/category/get_category_names.dart';
import 'package:web_db/core/settings/route_settings.dart';

class TopAppBar extends StatefulWidget {
  const TopAppBar({super.key});

  @override
  State<TopAppBar> createState() => _TopAppBarState();
}

class _TopAppBarState extends State<TopAppBar> {
  List<bool> enter = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  final String title = "Hepsionda";

  final String subtitle = "Hepsionda";

  final String subtitle2 = " keşfet";

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBarCustom(
            searchController: searchController,
            subtitle2: subtitle2,
            subtitle: subtitle,
            title: title),
        const TopRowsColors(),
        Container(
          color: PColors.categoryGrey,
          height: context.height(0.06),
          width: context.width(1),
          alignment: Alignment.center,
          child: FutureBuilder<List<CategoryModel>>(
            future: getCategoryNames(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  physics: const PageScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => MouseRegion(
                    cursor: MaterialStateMouseCursor.clickable,
                    onEnter: (event) {
                      setState(() {
                        enter[index] = true;
                      });
                    },
                    onExit: (event) {
                      setState(() {
                        enter[index] = false;
                      });
                    },
                    child: SizedBox(
                      width: context.width(0.08),
                      child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: enter[index]
                                ? PColors.categoryButton
                                : PColors.categoryGrey,
                            shape: const RoundedRectangleBorder()),
                        onPressed: () {
                          pushToPage(
                              context,
                              Category(
                                id: snapshot.data![index].id ?? 0,
                                name: snapshot.data![index].name ?? " ",
                              ));
                        },
                        child: Text(
                          snapshot.data![index].name ?? " ",
                          softWrap: true,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              wordSpacing: 0.45,
                              color: Colors.grey.shade800),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator.adaptive();
            },
          ),
        ),
      ],
    );
  }
}
