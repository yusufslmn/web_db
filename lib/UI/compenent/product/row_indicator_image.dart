import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_db/UI/compenent/home/data_example.dart';
import 'package:web_db/core/Utility/colors.dart';
import 'package:web_db/core/state/product_state.dart';

class RowIndicator extends ConsumerStatefulWidget {
  const RowIndicator({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RowIndicatorState();
}

class _RowIndicatorState extends ConsumerState<RowIndicator> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
      child: SizedBox(
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: productDetailImages.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () =>
                ref.read(productProvider).pageController.jumpToPage(index),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              padding: productDetailImages[index] ==
                      productDetailImages[ref.watch(productProvider).indexPage]
                  ? const EdgeInsets.all(2)
                  : EdgeInsets.zero,
              decoration: BoxDecoration(
                  color: productDetailImages[index] ==
                          productDetailImages[
                              ref.read(productProvider).indexPage]
                      ? PColors.mainColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(4)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  productDetailImages[index],
                  color: Colors.transparent,
                  fit: BoxFit.contain,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
