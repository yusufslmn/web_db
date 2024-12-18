import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_db/u%C4%B1/compenent/home/button_image.dart';
import 'package:web_db/utility/colors.dart';
import 'package:web_db/utility/screen_size.dart';
import '../../../state/product_state.dart';

class ImageContainer extends ConsumerStatefulWidget {
  const ImageContainer({super.key, required this.pictures});
  final List<dynamic>? pictures;
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
                        itemCount: widget.pictures?.length,
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
                              widget.pictures?[index],
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
          Expanded(
              flex: 2,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
                child: SizedBox(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.pictures?.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () => ref
                          .read(productProvider)
                          .pageController
                          .jumpToPage(index),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        padding: index == ref.watch(productProvider).indexPage
                            ? const EdgeInsets.all(2)
                            : EdgeInsets.zero,
                        decoration: BoxDecoration(
                            color: index == ref.read(productProvider).indexPage
                                ? PColors.mainColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(4)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            widget.pictures?[index],
                            color: Colors.transparent,
                            fit: BoxFit.contain,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
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
              )),
        ],
      ),
    );
  }
}
