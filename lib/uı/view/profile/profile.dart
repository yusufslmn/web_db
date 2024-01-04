import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_db/u%C4%B1/compenent/basket/basket_custom_listtile.dart';
import 'package:web_db/u%C4%B1/compenent/appBar/top_app_bar.dart';
import 'package:web_db/u%C4%B1/view/profile/adress.dart';
import 'package:web_db/u%C4%B1/view/profile/chat.dart';
import 'package:web_db/u%C4%B1/view/product/compare.dart';
import 'package:web_db/u%C4%B1/view/profile/uptade_password.dart';
import 'package:web_db/u%C4%B1/view/profile/user_info.dart';
import 'package:web_db/utility/colors.dart';
import 'package:web_db/utility/screen_size.dart';
import 'package:web_db/model/comment/post_comment_model.dart';
import 'package:web_db/model/coupon/coupon_model.dart';
import 'package:web_db/model/order/order_model.dart';
import 'package:web_db/service/comment/add_comment.dart';
import 'package:web_db/service/coupon/get_all_coupon.dart';
import 'package:web_db/service/coupon/get_coupon.dart';
import 'package:web_db/service/coupon/get_user_coupon.dart';
import 'package:web_db/service/orders/get_order.dart';
import 'package:web_db/service/service.dart';
import 'package:web_db/settings/route_settings.dart';
import 'package:web_db/state/profile_state.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends ProfileState with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      endDrawer: Container(
        color: Colors.grey.shade300,
        width: context.width(0.4),
        height: context.height(1),
        child: Column(
          children: [
            ListTile(
              leading: IconButton(
                  onPressed: () => scaffoldKey.currentState!.closeEndDrawer(),
                  icon: const Icon(Icons.chevron_left)),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
              child: Text(
                "Yoruma yıldız ver",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
              child: RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 15,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating1) {
                  setState(() {
                    rating = rating1;
                  });
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
              child: Text(
                "Yorum",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
              child: TextField(
                controller: textEditingController,
                maxLines: 5,
                decoration: InputDecoration(
                    labelText: "Bir yorum bırak...",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            const BorderSide(color: PColors.mainColor))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: PColors.mainColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  onPressed: () async {
                    changeLoading();
                    PostCommentModel comment = PostCommentModel(
                        comment: textEditingController.text,
                        productId: id,
                        rating: rating);
                    await postComment(comment).then((value) {
                      if (value) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                              title: const Text("Yorum Gönderildi"),
                              actions: [
                                Center(
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        scaffoldKey.currentState!
                                            .closeEndDrawer();
                                      },
                                      child: const Text("Devam ediniz")),
                                )
                              ]),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                              title: const Text("Yorum gönderilemedi"),
                              actions: [
                                Center(
                                  child: ElevatedButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("Devam ediniz")),
                                )
                              ]),
                        );
                      }
                    });
                    changeLoading();
                  },
                  child: const Text(
                    "Yorumu gönder",
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const TopAppBar(),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 15),
                    child: const Text(
                      "Kullanıcı Bilgilerim",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                              actions: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Sayfada Kal"),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          IService.basicAuth = "";
                                          IService.email = "";
                                          IService.password = "";
                                          IService.saveBasicAuth();
                                          IService.loadBasicAuth();
                                          IService.validationUser = false;
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                            Routes.loginRoute,
                                            (route) => false,
                                          );
                                        },
                                        child: const Text("Çıkış Yap"),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                              title: const Text(
                                  "Çıkmak istediğinize eminmisiniz?")),
                        );
                      },
                      icon: const Icon(Icons.exit_to_app))
                ],
              ),
              SizedBox(
                width: context.width(0.7),
                child: TabBar(
                    onTap: (value) {
                      pageController.animateToPage(value,
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.linear);
                    },
                    dividerColor: PColors.mainColor,
                    labelColor: PColors.mainColor,
                    indicatorColor: PColors.mainColor,
                    controller: TabController(length: 7, vsync: this),
                    tabs: const [
                      Text("Üyelik Bilgilerim"),
                      Text("Şifre Değişikliği"),
                      Text("Kuponlar"),
                      Text("Siparişlerim"),
                      Text("Karşılaştırmalarım"),
                      Text("Adreslerim"),
                      Text("Müşteri Destek"),
                    ]),
              ),
              SizedBox(
                width: context.width(0.5),
                height: context.height(1),
                child: PageView(
                  controller: pageController,
                  children: [
                    const UyelikBilgilerim(),
                    const PasswordChange(),
                    //kuponlarımmmm
                    Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Tüm Kuponlar",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: FutureBuilder<List<CouponModel>>(
                            future: getAllCoupons(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Container(
                                    height: context.height(0.28),
                                    padding: const EdgeInsets.all(8.0),
                                    child: Scrollbar(
                                      thickness: 4,
                                      trackVisibility: true,
                                      thumbVisibility: true,
                                      controller: scrollController,
                                      child: ListView.builder(
                                        itemCount: snapshot.data?.length ?? 0,
                                        controller: scrollController,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) =>
                                            Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 8),
                                          width: context.width(0.1),
                                          child: Card(
                                            color: Colors.grey.shade100,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  color: PColors.mainColor,
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  margin:
                                                      const EdgeInsets.all(4.0),
                                                  child: Text(
                                                    "${snapshot.data![index].code}",
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        backgroundColor:
                                                            PColors.mainColor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Her üründe geçerli ${snapshot.data![index].discount} TL",
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Son ${snapshot.data![index].remainedQuantity} adet",
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: snapshot.data?[index]
                                                              .isAvailable ==
                                                          true
                                                      ? ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                              backgroundColor:
                                                                  PColors
                                                                      .mainColor,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          16))),
                                                          onPressed: () async {
                                                            await getCoupon(
                                                                    snapshot
                                                                        .data?[
                                                                            index]
                                                                        .code)
                                                                .then((value) {
                                                              if (value) {
                                                                showDialog(
                                                                  context:
                                                                      context,
                                                                  builder: (context) =>
                                                                      AlertDialog(
                                                                          title:
                                                                              const Text("Kupon Hesaba Eklendi"),
                                                                          actions: [
                                                                        Center(
                                                                          child: TextButton(
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: const Text("Devam et")),
                                                                        )
                                                                      ]),
                                                                );
                                                              } else {
                                                                showDialog(
                                                                  context:
                                                                      context,
                                                                  builder: (context) =>
                                                                      AlertDialog(
                                                                          title:
                                                                              const Text("Kupon Hesaba eklenemedi"),
                                                                          actions: [
                                                                        Center(
                                                                          child: TextButton(
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: const Text("Tekrar Deneyiniz")),
                                                                        )
                                                                      ]),
                                                                );
                                                              }
                                                            });
                                                            setState(() {});
                                                          },
                                                          child: const Text(
                                                            "Kuponu Hesaba Ekle",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ))
                                                      : ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                              backgroundColor:
                                                                  const Color.fromARGB(
                                                                      255,
                                                                      209,
                                                                      150,
                                                                      114),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(16))),
                                                          onPressed: () {},
                                                          child: const Text(
                                                            "Kupon Eklenemez",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          )),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ));
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }

                              // By default, show a loading spinner.
                              return const Center(
                                  child: CircularProgressIndicator.adaptive());
                            },
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Hesabıma Tanımladıklarım",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: FutureBuilder<List<CouponModel>>(
                            future: getUserCoupons(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Container(
                                    height: context.height(0.25),
                                    padding: const EdgeInsets.all(8.0),
                                    child: Scrollbar(
                                      controller: scrollController1,
                                      thickness: 4,
                                      trackVisibility: true,
                                      thumbVisibility: true,
                                      child: ListView.builder(
                                        itemCount: snapshot.data?.length ?? 0,
                                        controller: scrollController1,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) =>
                                            Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 8),
                                          width: context.width(0.1),
                                          height: context.height(0.2),
                                          child: Card(
                                            color: Colors.grey.shade100,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  color: PColors.mainColor,
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  margin:
                                                      const EdgeInsets.all(4.0),
                                                  child: Text(
                                                    "${snapshot.data![index].code}",
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        backgroundColor:
                                                            PColors.mainColor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Her üründe geçerli ${snapshot.data![index].discount} TL",
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "1 Adet Geçerli",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ));
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }

                              // By default, show a loading spinner.
                              return const Center(
                                  child: CircularProgressIndicator.adaptive());
                            },
                          ),
                        ),
                      ],
                    ),
                    //siparişlerim
                    FutureBuilder<List<OrderModel>>(
                      future: fetchOrder(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SizedBox(
                            width: context.width(0.5),
                            height: context.height(1),
                            child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ExpansionTile(
                                    backgroundColor:
                                        PColors.productBackContainer,
                                    collapsedShape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    subtitle:
                                        Text("${snapshot.data![index].date}"),
                                    title: Row(
                                      children: [
                                        Text(
                                          "Sipariş no: ",
                                          style: TextStyle(
                                              color: Colors.grey.shade500,
                                              fontWeight: FontWeight.w100),
                                        ),
                                        Text(
                                          snapshot.data![index].orderId ?? " ",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Spacer(),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${(((snapshot.data![index].campaignPrice ?? (snapshot.data![index].totalPrice ?? 0 + 29.99)) + 29.99) - (snapshot.data![index].discountPrice ?? 0))} TL",
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.green),
                                                ),
                                                Text(
                                                  snapshot.data![index]
                                                          .paymentMethod ??
                                                      " ",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color:
                                                          Colors.grey.shade500,
                                                      fontWeight:
                                                          FontWeight.w100),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    children: [
                                      Container(
                                        width: context.width(0.5),
                                        margin:
                                            const EdgeInsets.only(bottom: 4),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                flex: 7,
                                                child: SizedBox(
                                                  height: context.height(0.8),
                                                  child: ListView.builder(
                                                    itemCount: snapshot
                                                        .data![index]
                                                        .items!
                                                        .length,
                                                    itemBuilder:
                                                        (context, index1) {
                                                      return Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 8),
                                                          color: Colors.white,
                                                          height: context
                                                              .height(0.35),
                                                          child: Column(
                                                            children: [
                                                              Expanded(
                                                                flex: 2,
                                                                child: ListTile(
                                                                  leading:
                                                                      const Text(
                                                                          "Satıcı:"),
                                                                  title: Text(snapshot
                                                                          .data![
                                                                              index]
                                                                          .items![
                                                                              index1]
                                                                          .brandName ??
                                                                      ""),
                                                                ),
                                                              ),
                                                              Divider(
                                                                color: PColors
                                                                    .productBackContainer,
                                                              ),
                                                              const Expanded(
                                                                flex: 2,
                                                                child: ListTile(
                                                                  leading: Icon(
                                                                      Icons
                                                                          .directions_bus_outlined,
                                                                      size: 20),
                                                                  title: Text(
                                                                      "Tahmini 20 Aralık Çarşamba kapında"),
                                                                  titleTextStyle:
                                                                      TextStyle(
                                                                          fontSize:
                                                                              15),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                  flex: 6,
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        flex: 2,
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              16.0),
                                                                          child:
                                                                              Image.network(snapshot.data?[index].items![index1].pictures?.first ?? " "),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                          flex:
                                                                              8,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              ListTile(
                                                                                subtitle: Text(snapshot.data![index].items![index1].attributes!.isEmpty ? " " : snapshot.data![index].items![index1].attributes.toString()),
                                                                                title: Text(snapshot.data![index].items![index1].productName ?? ""),
                                                                              ),
                                                                              ListTile(
                                                                                leading: Padding(
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                                                  child: Text(
                                                                                    "Ürün Adedi:${snapshot.data?[index].items?[index1].quantity ?? 0}",
                                                                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ),
                                                                                trailing: Row(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: [
                                                                                    Text(
                                                                                      "${snapshot.data?[index].items?[index1].price ?? 0} TL",
                                                                                      style: TextStyle(
                                                                                        decoration: snapshot.data![index].items?[index1].campaignPrice != null ? TextDecoration.lineThrough : null,
                                                                                        decorationThickness: 2,
                                                                                        fontSize: 15,
                                                                                        fontWeight: FontWeight.bold,
                                                                                      ),
                                                                                    ),
                                                                                    snapshot.data![index].items![index1].campaignPrice != null
                                                                                        ? Padding(
                                                                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                                                            child: Text(
                                                                                              "${snapshot.data?[index].items?[index1].campaignPrice ?? 0} TL",
                                                                                              style: const TextStyle(fontSize: 15, color: Colors.red, fontWeight: FontWeight.bold),
                                                                                            ),
                                                                                          )
                                                                                        : const SizedBox.shrink(),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              ElevatedButton(
                                                                                  style: ElevatedButton.styleFrom(
                                                                                    backgroundColor: PColors.mainColor,
                                                                                    shape: RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.circular(8),
                                                                                    ),
                                                                                  ),
                                                                                  onPressed: () {
                                                                                    setState(() {
                                                                                      id = snapshot.data![index].items![index1].productId ?? 0;
                                                                                    });
                                                                                    scaffoldKey.currentState!.openEndDrawer();
                                                                                  },
                                                                                  child: const Text(
                                                                                    "Ürünü Değerlendir",
                                                                                    style: TextStyle(color: Colors.white),
                                                                                  ))
                                                                            ],
                                                                          ))
                                                                    ],
                                                                  ))
                                                            ],
                                                          ));
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: OrderTotalContainer(
                                                    discountPrice: snapshot
                                                        .data![index]
                                                        .discountPrice,
                                                    status: snapshot
                                                        .data![index].status,
                                                    totalCampaignPrice: snapshot
                                                            .data![index]
                                                            .campaignPrice ??
                                                        0,
                                                    totalItemCount: snapshot
                                                            .data![index]
                                                            .items
                                                            ?.length ??
                                                        0,
                                                    totalPrice: snapshot
                                                            .data![index]
                                                            .totalPrice ??
                                                        0),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }

                        // By default, show a loading spinner.
                        return const Center(
                            child: CircularProgressIndicator.adaptive());
                      },
                    ),
                    StreamBuilder(
                      stream: getCompare(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SizedBox(
                            height: context.height(0.6),
                            child: ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ListTile(
                                  onTap: () => pushToPage(
                                      context,
                                      Compare(
                                          isShow: false,
                                          id1: snapshot.data!.docs[index]
                                              ["id1"],
                                          id2: snapshot.data!.docs[index]
                                              ["id2"])),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: const BorderSide(
                                        color: PColors.mainColor),
                                  ),
                                  leading: Text("${index + 1}. Karşılaştırma"),
                                  title: Text(
                                      "1.Ürün :${snapshot.data!.docs[index]["name1"]}   ,2.Ürün: ${snapshot.data!.docs[index]["name2"]}"),
                                ),
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }

                        // By default, show a loading spinner.
                        return const Center(
                            child: CircularProgressIndicator.adaptive());
                      },
                    ),
                    const Adreslerim(),
                    ChatPage(
                      chatId: IService.basicAuth,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OrderTotalContainer extends ConsumerWidget {
  const OrderTotalContainer(
      {super.key,
      required this.totalCampaignPrice,
      required this.totalItemCount,
      required this.totalPrice,
      required this.discountPrice,
      required this.status});
  final double? totalCampaignPrice;
  final int? totalItemCount;
  final double? totalPrice;
  final double? discountPrice;
  final String? status;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: context.height(0.5),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Siparişteki ürünler ($totalItemCount)",
            style: const TextStyle(
                color: PColors.mainColor,
                fontSize: 12,
                fontWeight: FontWeight.bold),
          ),
          const Spacer(
            flex: 1,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${totalPrice ?? 0 + 29.99} TL",
                  style: TextStyle(
                      decorationThickness: 2,
                      decoration: totalCampaignPrice == null
                          ? null
                          : TextDecoration.lineThrough,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              totalCampaignPrice == null
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "${totalCampaignPrice ?? 0 + 29.99} TL",
                        style: const TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
              discountPrice == null
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "- ${(discountPrice ?? 0).toStringAsFixed(2)} TL",
                        style: const TextStyle(
                            color: Color.fromARGB(255, 53, 154, 205),
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
            ],
          ),
          const Spacer(
            flex: 8,
          ),
          SizedBox(
            height: context.height(0.06),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: PColors.mainColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Row(
                      children: [
                        const Icon(
                          Icons.local_shipping_outlined,
                          color: PColors.mainColor,
                        ),
                        Text(status ?? " ")
                      ],
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Kapat"))
                    ],
                  ),
                );
              },
              child: Text(
                "Siparişi Takip Et",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: context.height(0.0150),
                    fontWeight: FontWeight.w800),
              ),
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          CustomListTileText(
            price: totalCampaignPrice ?? (totalPrice ?? 0),
            title: "Ürünler:",
          ),
          const CustomListTileText(
            price: 29.99,
            title: "Kargo:",
          ),
          const Divider(),
          CustomListTileText(
            title: 'Toplam',
            price: ((((totalCampaignPrice ?? ((totalPrice ?? 0) + 29.99))) +
                    29.99) -
                (discountPrice ?? 0)),
          )
        ],
      ),
    );
  }
}

Stream<QuerySnapshot<Map<String, dynamic>>> getCompare() {
  return FirebaseFirestore.instance
      .collection("compare")
      .where("auth", isEqualTo: IService.basicAuth)
      .snapshots();
}
