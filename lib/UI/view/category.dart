import 'package:flutter/material.dart';
import 'package:web_db/UI/compenent/common/top_app_bar.dart';
import 'package:web_db/UI/compenent/home/data_example.dart';
import 'package:web_db/UI/compenent/home/product_item.dart';
import 'package:web_db/core/Utility/screen_size.dart';
import 'package:web_db/core/model/product_model.dart';

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
          children: [
            TopAppBar(),
            Text(widget.title),
            Row(
              children: [
                Expanded(
                    flex: 3,
                    child: Container(
                      height: context.height(1),
                      margin: EdgeInsets.all(30),
                      color: Colors.pink,
                    )),
                Expanded(
                  flex: 7,
                  child: SizedBox(
                    width: context.width(1),
                    height: context.height(1),
                    child: GridView.builder(
                      padding: EdgeInsets.all(16),
                      itemCount: productList.length,
                      physics: PageScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
