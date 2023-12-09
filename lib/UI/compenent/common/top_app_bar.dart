import 'package:flutter/material.dart';
import 'package:web_db/UI/compenent/home/app_bar.dart';
import 'package:web_db/UI/compenent/home/list_category.dart';
import 'package:web_db/UI/compenent/home/row_colors_top.dart';
import 'package:web_db/core/Utility/colors.dart';
import 'package:web_db/core/Utility/screen_size.dart';

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

  final String title = "Hepsibunda";

  final String subtitle = "Hepsibundayı";

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
            child: ListView.builder(
              itemCount: categoryNames.length,
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
                    onPressed: () {},
                    child: Text(
                      categoryNames[index],
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
            )),
      ],
    );
  }
}
