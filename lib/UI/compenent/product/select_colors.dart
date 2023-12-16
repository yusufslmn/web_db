import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_db/UI/compenent/home/data_example.dart';
import 'package:web_db/UI/compenent/product/custom_text_style.dart';
import 'package:web_db/core/Utility/colors.dart';
import 'package:web_db/core/Utility/screen_size.dart';
import 'package:web_db/core/state/product_state.dart';

class SelectColor extends ConsumerStatefulWidget {
  const SelectColor({super.key});

  @override
  ConsumerState<SelectColor> createState() => _SelectColorState();
}

class _SelectColorState extends ConsumerState<SelectColor> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16),
      decoration:
          BoxDecoration(border: Border.all(color: Colors.grey.shade400)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ref.read(productProvider).color,
            style: CustomTextStyle.sellerStyle,
          ),
          SizedBox(
            width: context.width(0.3),
            height: context.height(0.1),
            child: ListView.builder(
              itemCount: ref.read(productProvider).colors.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  setState(() {
                    ref.read(productProvider).color =
                        ColorsName.values[index].name;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.all(16.0),
                  width: context.width(0.08),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2,
                          color: ColorsName.values[index].name !=
                                  ref.read(productProvider).color
                              ? Colors.grey.shade400
                              : PColors.mainColor)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Image.network(productImages[0]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          ColorsName.values[index].name,
                          style: TextStyle(fontSize: context.width(0.009)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
