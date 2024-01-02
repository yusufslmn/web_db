// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:web_db/UI/view/admin/admin_chat.dart';
import 'package:web_db/UI/view/admin/admin_products.dart';
import 'package:web_db/UI/view/login/login.dart';
import 'package:web_db/core/Utility/colors.dart';
import 'package:web_db/core/Utility/screen_size.dart';
import 'package:web_db/core/model/category/category_model.dart';
import 'package:web_db/core/service/category/get_category_names.dart';
import 'package:web_db/core/service/comment/add_commen_to_comment.dart';
import 'package:web_db/core/service/service.dart';
import 'package:web_db/core/settings/route_settings.dart';

class SellerPanel extends StatefulWidget {
  const SellerPanel({super.key});

  @override
  State<SellerPanel> createState() => _SellerPanelState();
}

class _SellerPanelState extends State<SellerPanel> {
  ScrollController controller = ScrollController();
  bool isLoading = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  double? rating;

  bool orderByDate = false;
  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<void> sendCommentRating(int commentId, double rating) async {
    changeLoading();
    await postCommentRating(commentId, rating);
    changeLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: SizedBox(
        width: context.width(0.3),
        child: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  "Kategoriler",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                color: PColors.categoryGrey,
                width: context.width(0.3),
                alignment: Alignment.center,
                child: FutureBuilder<List<CategoryModel>>(
                  future: getCategoryNames(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        physics: const PageScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => SizedBox(
                          width: context.width(0.08),
                          child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: PColors.categoryGrey,
                                shape: const RoundedRectangleBorder()),
                            onPressed: () {
                              pushToPage(
                                  context,
                                  AdminProducts(
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
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }

                    // By default, show a loading spinner.
                    return const CircularProgressIndicator.adaptive();
                  },
                ),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        leading: TextButton.icon(
            onPressed: () {
              scaffoldKey.currentState!.openDrawer();
            },
            label: const Text("Products"),
            icon: const Icon(Icons.menu)),
        leadingWidth: context.width(0.1),
        actions: [
          IconButton(
              onPressed: () {
                IService.basicAuth = "";
                IService.email = "";
                IService.password = "";
                IService.saveBasicAuth();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.loginRoute, (route) => false);
              },
              icon: const Icon(Icons.exit_to_app))
        ],
        title: const Text(
          "Satıcı Paneli",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: const SafeArea(child: AdminMessages()),
    );
  }
}
