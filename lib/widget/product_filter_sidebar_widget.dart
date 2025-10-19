import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pre_interview_task/model/product.dart';
import 'package:pre_interview_task/provider/dio.dart';
import 'package:pre_interview_task/utils/dimensions.dart';

class ProductFilterSidebar extends ConsumerWidget {
  const ProductFilterSidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final notifier = ref.read(productNotifierProvider.notifier);
    final priceRange = ref.watch(productNotifierProvider).priceRange;
    const double sliderMin = 4;
    const double sliderMax = 2000;
    double minPrice = priceRange.min.clamp(sliderMin, sliderMax);
    double maxPrice = priceRange.max.clamp(sliderMin, sliderMax);
    if (minPrice > maxPrice) {
      minPrice = sliderMin;
      maxPrice = sliderMax;
    }

    return SingleChildScrollView(
      child: Container(
        width: Dimensions.widthElevated,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 2, 44, 128),
              Color.fromARGB(255, 41, 114, 173),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter By',
              style: TextStyle(
                color: Colors.white,
                fontSize: Dimensions.fontSizeLarge.toDouble(),
                fontWeight: FontWeight.normal,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: Dimensions.paddingSizeDefault),
            Text(
              'Category',
              style: TextStyle(
                color: Colors.white,
                fontSize: Dimensions.fontSizeLarge.toDouble(),
                fontWeight: FontWeight.normal,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: Dimensions.paddingSizeEight),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              hint: const Text(
                'Select Category',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins',
                ),
              ),
              isExpanded: true,
              decoration: const InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
              ),
              icon: const Icon(Icons.arrow_drop_down, color: Colors.white),

              items:
                  categories.map((category) {
                    return DropdownMenuItem(
                      value: category.slug,
                      child: Text(
                        category.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    );
                  }).toList(),

              onChanged: (value) => notifier.setCategory(value),

              dropdownColor: Colors.blueAccent,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
              ),
            ),

            const SizedBox(height: Dimensions.paddingSizeExtraLarge),

            Text(
              'Price Range',
              style: TextStyle(
                color: Colors.white,
                fontSize: Dimensions.fontSizeLarge.toDouble(),
                fontWeight: FontWeight.normal,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: Dimensions.paddingSizeEight),
            RangeSlider(
              values: RangeValues(minPrice, maxPrice),
              min: sliderMin,
              max: sliderMax,
              divisions: 40,
              activeColor: Colors.white,
              inactiveColor: Colors.grey,
              labels: RangeLabels(
                '\$${minPrice.toStringAsFixed(0)}',
                '\$${maxPrice.toStringAsFixed(0)}',
              ),
              onChanged: (RangeValues values) {
                notifier.state = notifier.state.copyWith(
                  priceRange: PriceRange(min: values.start, max: values.end),
                );
                notifier.applyFilters();
              },
            ),
            const SizedBox(height: Dimensions.paddingSizeExtraLarge),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.clear_all),
                label: const Text('Clear Filters'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black,
                ),
                onPressed: () => notifier.clearFilters(),
              ),
            ),
            const SizedBox(height: Dimensions.paddingSizeExtraLarge),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.rate_review),
                label: const Text('Filter Rate'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black,
                ),
                onPressed: () => notifier.applyFilerForRate(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
