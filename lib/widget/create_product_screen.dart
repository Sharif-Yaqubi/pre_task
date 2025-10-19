import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pre_interview_task/theme/texts_style.dart';
import 'package:pre_interview_task/utils/dimensions.dart';
import 'package:pre_interview_task/utils/util_dialog.dart';
import 'package:pre_interview_task/widget/add_product_form_widget.dart';
import 'package:pre_interview_task/widget/animated_search_bar.dart';

import 'package:pre_interview_task/widget/elevated_button_widget.dart';
import 'package:pre_interview_task/model/product.dart';

import 'package:pre_interview_task/provider/dio.dart';
import 'package:pre_interview_task/utils/show_right_side_sheet_widget.dart';
import 'package:pre_interview_task/theme/app_colors.dart';
import 'package:pre_interview_task/utils/responsive.dart';
import 'package:redacted/redacted.dart';

class CreateProductWidget extends ConsumerStatefulWidget {
  const CreateProductWidget({super.key});

  @override
  ConsumerState<CreateProductWidget> createState() =>
      _CreateProductScreenState();
}

class _CreateProductScreenState extends ConsumerState<CreateProductWidget> {
  late TextEditingController searchController;
  late FocusNode searchFocusNode;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchFocusNode = FocusNode();
    searchController.addListener(() {
      ref
          .read(productNotifierProvider.notifier)
          .setSearchQuery(searchController.text);
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productsProvider);
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isMobile(context);
    return Padding(
      padding: EdgeInsets.all(
        isMobile ? Dimensions.paddingSizeEight : Dimensions.paddingSizeDefault,
      ),
      child: Column(
        children: [
          if (isMobile)
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AnimatedSearchBar(
                  controller: searchController,
                  focusNode: searchFocusNode,
                ),
                const SizedBox(height: Dimensions.paddingSize),
                ElevatedButtonWidget(
                  text: 'Add new Product',
                  onPressed:
                      () => showRightSideSheet(
                        context: context,
                        child: const AddProductFormWidget(),
                      ),
                ),
              ],
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AnimatedSearchBar(
                    controller: searchController,
                    focusNode: searchFocusNode,
                  ),
                ),
                const SizedBox(width: Dimensions.paddingSizeDefault),
                ElevatedButtonWidget(
                  text: 'Add new Product',
                  onPressed: () {
                    showRightSideSheet(
                      context: context,
                      child: const AddProductFormWidget(),
                    );
                  },
                ),
              ],
            ),
          const SizedBox(height: Dimensions.paddingSizeExtraLarge),

          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final crossAxisCount = _getCrossAxisCount(context);
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio:
                              isMobile
                                  ? 0.8
                                  : isTablet
                                  ? 07
                                  : 0.9,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return ProductCard(product: product);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    if (Responsive.isMobile(context)) return 2;
    if (Responsive.isTablet(context)) return 3;
    return 4;
  }
}

class ProductCard extends ConsumerWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(isLoadingProvider);

    return Card(
      elevation: 5,
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.paddingSize),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeEight),
              child: Image.network(
                product.thumbnail,
                height: Dimensions.rewardImageSizeOfferPage,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder:
                    (_, __, ___) => Container(
                      height: Dimensions.rewardImageSizeOfferPage,
                      color: Colors.grey[200],
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.image_not_supported,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
              ),
            ),
            const SizedBox(height: Dimensions.paddingSizeEight),

            Text(
              product.title,
              style: TextsStyle.titleStyle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: Dimensions.paddingSizeFour),
            Text(product.brand, style: TextsStyle.brandStyle),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.price > 0
                      ? '\$${product.price.toStringAsFixed(2)}'
                      : '\$--',
                  style: TextsStyle.priceStyle,
                ),
                Row(
                  children: [
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                    Text(
                      product.rating > 0
                          ? product.rating.toStringAsFixed(1)
                          : '--',
                      style: TextsStyle.priceStyle,
                    ),
                    const SizedBox(width: Dimensions.paddingSizeFour),
                    ElevatedButtonWidget(
                      onPressed: () {
                        //  final succes =
                        debugPrint('This is the id ${product.id}');
                        ref
                            .read(productNotifierProvider.notifier)
                            .clearNewItem(id: product.id);
                        debugPrint('This is the id ${product.id}');
                        
                      },
                      text: 'Delete',
                      width: 100,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: Dimensions.paddingSizeEight),
          ],
        ),
      ),
    ).redacted(context: context, redact: isLoading);
  }
}
