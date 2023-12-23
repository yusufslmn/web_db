import 'package:flutter/material.dart';
import 'package:web_db/UI/compenent/common/top_app_bar.dart';
import 'package:web_db/UI/compenent/home/data_example.dart';
import 'package:web_db/UI/compenent/home/product_item.dart';
import 'package:web_db/core/Utility/colors.dart';
import 'package:web_db/core/Utility/screen_size.dart';

class Category extends StatefulWidget {
  const Category({super.key, required this.title});
  final String title;
  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopAppBar(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              child: Text(
                widget.title,
                style: const TextStyle(
                    color: PColors.mainColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                Expanded(
                    flex: 3,
                    child: Container(
                      height: context.height(1),
                      margin: const EdgeInsets.all(30),
                      color: Colors.pink,
                      child: Column(
                        children: [
                          DropdownButton(
                            items: const [
                              DropdownMenuItem(child: Text("Deneme"))
                            ],
                            onChanged: (value) {},
                          )
                        ],
                      ),
                    )),
                Expanded(
                  flex: 7,
                  child: SizedBox(
                    width: context.width(1),
                    height: context.height(1),
                    child: GridView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: productList.length,
                      physics: const PageScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4),
                      itemBuilder: (context, index) => ProductItem(
                        index: index,
                        product: productList[index],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
