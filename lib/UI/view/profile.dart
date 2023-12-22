import 'package:awesome_card/credit_card.dart';
import 'package:awesome_card/extra/card_type.dart';
import 'package:awesome_card/extra/helper.dart';
import 'package:awesome_card/style/card_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_db/UI/compenent/common/top_app_bar.dart';
import 'package:web_db/core/Utility/colors.dart';
import 'package:web_db/core/Utility/screen_size.dart';
import 'package:web_db/core/state/profile_state.dart';
import 'dart:math' as math;

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends ProfileState with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const TopAppBar(),
              Container(
                alignment: Alignment.centerLeft,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15),
                child: const Text(
                  "Kullanıcı Bilgilerim",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                width: context.width(0.5),
                child: TabBar(
                    onTap: (value) {
                      pageController.animateToPage(value,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.linear);
                    },
                    dividerColor: PColors.mainColor,
                    labelColor: PColors.mainColor,
                    indicatorColor: PColors.mainColor,
                    controller: TabController(length: 4, vsync: this),
                    tabs: const [
                      Text("Üyelik Bilgilerim"),
                      Text("Şifre Değişikliği"),
                      Text("Kayıtlı Kartlarım"),
                      Text("Adreslerim"),
                    ]),
              ),
              SizedBox(
                width: context.width(0.5),
                height: context.height(1),
                child: PageView(
                  controller: pageController,
                  children: pageList,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

List<Widget> pageList = [
  const UyelikBilgilerim(),
  const PasswordChange(),
  const MyCreditCards(),
  const Adreslerim()
];

class UyelikBilgilerim extends StatelessWidget {
  const UyelikBilgilerim({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CustomListTile(
          leading: "Ad:",
          title: "Yusuf",
        ),
        CustomListTile(
          leading: "Soyad:",
          title: "Salman",
        ),
        CustomListTile(
          leading: "Email:",
          title: "yusufslmn@outlook.com.tr",
        ),
        CustomListTile(
          leading: "Cinsiyet:",
          title: "Erkek",
        ),
      ],
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.leading,
    required this.title,
  });
  final String leading;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        shape: OutlineInputBorder(
            borderSide: const BorderSide(color: PColors.mainColor),
            borderRadius: BorderRadius.circular(16)),
        leading: Text(
          leading,
          style: const TextStyle(fontSize: 20),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class PasswordChange extends StatefulWidget {
  const PasswordChange({super.key});

  @override
  State<PasswordChange> createState() => _PasswordChangeState();
}

class _PasswordChangeState extends State<PasswordChange> {
  bool private = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "Şifreniz en az bir harf, rakam veya özel karakter içermeli. Ayrıca şifreniz en az 8 karakterden oluşmalı.",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Text("Mevcut Şifre"),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 24),
              child: TextFormField(
                obscureText: private,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.remove_red_eye_sharp),
                      onPressed: () {
                        setState(() {
                          private = !private;
                        });
                      },
                    ),
                    hintText: "Mevcut Şifre",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            const BorderSide(color: PColors.mainColor))),
              ),
            ),
            const Text("Yeni Şifre"),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 12),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Yeni Şifre",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            const BorderSide(color: PColors.mainColor))),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "!! Güvenliğiniz için adınız, soyadınız ve doğum tarihinizi içermeyen bir şifre belirleyin.",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: context.width(0.43),
                height: context.height(0.05),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: PColors.mainColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {},
                    child: const Text(
                      "Güncelle",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AddToCard extends StatefulWidget {
  const AddToCard({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final PageController controller;
  @override
  // ignore: library_private_types_in_public_api
  _AddToCardState createState() => _AddToCardState();
}

class _AddToCardState extends State<AddToCard> {
  String cardNumber = '';
  String cardHolderName = '';
  String expiryDate = '';
  String cvv = '';
  bool showBack = false;

  late FocusNode _focusNode;
  TextEditingController cardNumberCtrl = TextEditingController();
  TextEditingController expiryFieldCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _focusNode.hasFocus ? showBack = true : showBack = false;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            height: context.height(0.4),
            child: CreditCard(
              cardNumber: cardNumber,
              cardExpiry: expiryDate,
              cardHolderName: cardHolderName,
              cvv: cvv,
              bankName: 'Axis Bank',
              showBackSide: showBack,
              frontBackground: CardBackgrounds.black,
              backBackground: CardBackgrounds.white,
              showShadow: true,
              // mask: getCardTypeMask(cardType: CardType.americanExpress),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: TextFormField(
                  controller: cardNumberCtrl,
                  decoration: const InputDecoration(hintText: 'Card Number'),
                  maxLength: 16,
                  onChanged: (value) {
                    final newCardNumber = value.trim();
                    var newStr = '';
                    const step = 4;

                    for (var i = 0; i < newCardNumber.length; i += step) {
                      newStr += newCardNumber.substring(
                          i, math.min(i + step, newCardNumber.length));
                      if (i + step < newCardNumber.length) newStr += ' ';
                    }

                    setState(() {
                      cardNumber = newStr;
                    });
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: TextFormField(
                  controller: expiryFieldCtrl,
                  decoration:
                      const InputDecoration(hintText: 'Son Kullanma Tarihi'),
                  maxLength: 5,
                  onChanged: (value) {
                    var newDateValue = value.trim();
                    final isPressingBackspace =
                        expiryDate.length > newDateValue.length;
                    final containsSlash = newDateValue.contains('/');

                    if (newDateValue.length >= 2 &&
                        !containsSlash &&
                        !isPressingBackspace) {
                      newDateValue =
                          '${newDateValue.substring(0, 2)}/${newDateValue.substring(2)}';
                    }
                    setState(() {
                      expiryFieldCtrl.text = newDateValue;
                      expiryFieldCtrl.selection = TextSelection.fromPosition(
                          TextPosition(offset: newDateValue.length));
                      expiryDate = newDateValue;
                    });
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: TextFormField(
                  decoration: const InputDecoration(hintText: 'Kart Sahibi'),
                  onChanged: (value) {
                    setState(() {
                      cardHolderName = value;
                    });
                  },
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: TextFormField(
                  decoration: const InputDecoration(hintText: 'CVV'),
                  maxLength: 3,
                  onChanged: (value) {
                    setState(() {
                      cvv = value;
                    });
                  },
                  focusNode: _focusNode,
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                      onPressed: () {
                        widget.controller.animateToPage(0,
                            duration: const Duration(microseconds: 500),
                            curve: Curves.bounceIn);
                      },
                      icon: const Icon(Icons.add),
                      label: const Text("Kartı Ekle")),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class MyCreditCards extends StatefulWidget {
  const MyCreditCards({super.key});

  @override
  State<MyCreditCards> createState() => _MyCreditCardsState();
}

class _MyCreditCardsState extends State<MyCreditCards> {
  String cardNumber = "";

  String expiryDate = "03/24";

  var cardHolderName = "Yusuf Salman";

  var cvv = "111";
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width(0.5),
      height: context.height(1),
      child: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                    onPressed: () {
                      controller.animateToPage(1,
                          duration: const Duration(microseconds: 500),
                          curve: Curves.bounceIn);
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Kart Ekle")),
              ),
              SizedBox(
                width: context.width(0.4),
                height: context.height(0.9),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 2,
                  itemBuilder: (context, index) => Container(
                    padding: const EdgeInsets.all(20),
                    height: context.height(0.35),
                    child: CreditCard(
                      cardNumber: cardNumber,
                      cardExpiry: expiryDate,
                      cardHolderName: cardHolderName,
                      cvv: cvv,
                      bankName: 'Axis Bank',
                      showBackSide: false,
                      frontBackground: CardBackgrounds.black,
                      backBackground: CardBackgrounds.white,
                      showShadow: true,
                      mask: getCardTypeMask(cardType: CardType.americanExpress),
                    ),
                  ),
                ),
              )
            ],
          ),
          AddToCard(controller: controller),
        ],
      ),
    );
  }
}

class Adreslerim extends StatefulWidget {
  const Adreslerim({super.key});

  @override
  State<Adreslerim> createState() => _AdreslerimState();
}

class _AdreslerimState extends State<Adreslerim> {
  final TextEditingController controllerAdress = TextEditingController();
  final String adress =
      "Karadeniz Teknik Üniversitesi, 61080, Trabzon, Türkiye";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
          child: Column(
        children: [
          TextFormField(
              maxLines: 7,
              initialValue: adress,
              decoration: InputDecoration(
                  label: const Text("Adresim"),
                  isDense: true,
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: PColors.mainColor),
                      borderRadius: BorderRadius.circular(16)))),
          Center(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: PColors.mainColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                onPressed: () {},
                child: const Text(
                  "Güncelle",
                  style: TextStyle(color: Colors.white),
                )),
          ))
        ],
      )),
    );
  }
}
