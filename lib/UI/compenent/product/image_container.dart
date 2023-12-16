import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_db/UI/compenent/home/button_image.dart';
import 'package:web_db/UI/compenent/home/data_example.dart';
import 'package:web_db/UI/compenent/product/row_indicator_image.dart';
import 'package:web_db/core/Utility/screen_size.dart';
import '../../../core/state/product_state.dart';

class ImageContainer extends ConsumerStatefulWidget {
  const ImageContainer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ImageContainerState();
}

class _ImageContainerState extends ConsumerState<ImageContainer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width(0.35),
      height: context.height(0.8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 8,
              child: Stack(
                children: [
                  SizedBox(
                    height: context.height(0.6),
                    width: context.width(0.35),
                    child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: productDetailImages.length,
                        controller: ref.watch(productProvider).pageController,
                        onPageChanged: (value) {
                          setState(() {
                            ref.watch(productProvider).indexPage = value;
                          });
                        },
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              productDetailImages[index],
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                  ),
                  Positioned(
                      left: 0,
                      top: context.height(0.3),
                      child: ButtonImage(
                          onPressed: ref.read(productProvider).preImage,
                          icon: Icons.arrow_left_rounded)),
                  Positioned(
                      right: 0,
                      top: context.height(0.3),
                      child: ButtonImage(
                          onPressed: ref.read(productProvider).nextImage,
                          icon: Icons.arrow_right_rounded)),
                ],
              )),
          const Expanded(flex: 2, child: RowIndicator()),
        ],
      ),
    );
  }
}
