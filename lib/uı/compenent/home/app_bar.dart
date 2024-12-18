import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_db/utility/colors.dart';
import 'package:web_db/utility/screen_size.dart';
import 'package:web_db/settings/route_settings.dart';

class AppBarCustom extends StatelessWidget {
  final String title;

  final String subtitle;

  final String subtitle2;

  final TextEditingController searchController;

  const AppBarCustom({
    super.key,
    required this.title,
    required this.subtitle,
    required this.subtitle2,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: context.width(0.25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => pushNamed(context, Routes.homeRoute),
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: PColors.mainColor,
                    fontSize: context.height(0.035),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      color: PColors.mainColor,
                      fontSize: context.height(0.015),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle2,
                    style: GoogleFonts.poppins(
                      color: PColors.titleGrey,
                      fontSize: context.height(0.015),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: context.width(0.40),
          margin: EdgeInsets.symmetric(
              vertical: 8.0, horizontal: context.width(0.05)),
          child: TextFormField(
            maxLines: 1,
            controller: searchController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                )),
          ),
        ),
        Container(
          width: context.width(0.1),
          margin: EdgeInsets.all(context.height(0.01)),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  alignment: Alignment.center,
                  backgroundColor: Colors.orange.shade100,
                  fixedSize: Size(context.width(0.05), context.height(0.06)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.basketRoute);
              },
              child: const Icon(
                Icons.shopping_cart,
                color: PColors.mainColor,
              )),
        ),
        Container(
          width: context.width(0.1),
          margin: EdgeInsets.all(context.height(0.01)),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  alignment: Alignment.center,
                  backgroundColor: Colors.orange.shade100,
                  fixedSize: Size(context.width(0.05), context.height(0.06)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.profileRoute);
              },
              child: const Icon(
                Icons.account_circle_rounded,
                color: PColors.mainColor,
              )),
        ),
      ],
    );
  }
}
