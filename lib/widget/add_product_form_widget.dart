import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pre_interview_task/theme/texts_style.dart';
import 'package:pre_interview_task/utils/dimensions.dart';
import 'package:pre_interview_task/widget/custom_outline_button.dart';
import 'package:pre_interview_task/widget/elevated_button_widget.dart';
import 'package:pre_interview_task/model/product.dart';
import 'package:pre_interview_task/widget/product_profile_avatar.dart';
import 'package:pre_interview_task/provider/dio.dart';
import 'package:pre_interview_task/widget/text_field_widget.dart';

class AddProductFormWidget extends ConsumerStatefulWidget {
  final Product? product;

  const AddProductFormWidget({super.key, this.product});

  @override
  ConsumerState<AddProductFormWidget> createState() =>
      _AddProductFormWidgetState();
}

class _AddProductFormWidgetState extends ConsumerState<AddProductFormWidget> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final brandController = TextEditingController();
  final ratingController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String? selectedCategory;
  bool isActive = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      final product = widget.product!;
      titleController.text = product.title;
      descriptionController.text = product.description;
      priceController.text = product.price.toString();
      brandController.text = product.brand;
      ratingController.text = product.rating.toString();
      selectedCategory = product.category;
      isActive = product.stock > 0;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    brandController.dispose();
    ratingController.dispose();
    super.dispose();
  }

  Future<void> _saveProduct() async {
    if (!formKey.currentState!.validate()) return;

    if (selectedCategory == null || selectedCategory!.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a category')));
      return;
    }

    setState(() => _isLoading = true);

    try {
      if (widget.product == null) {
        final newProduct = Product(
          id: DateTime.now().millisecondsSinceEpoch,
          title: titleController.text.trim(),
          description: descriptionController.text.trim(),
          category: selectedCategory!,
          price: double.parse(priceController.text),
          discountPercentage: 0.0,
          rating: double.parse(ratingController.text),
          stock: isActive ? 100 : 0,
          tags: [],
          brand: brandController.text.trim(),
          sku: 'PROD-${DateTime.now().millisecondsSinceEpoch}',
          images: ['https://cdn.dummyjson.com/product-images/1/thumbnail.jpg'],
          thumbnail: 'https://cdn.dummyjson.com/product-images/1/thumbnail.jpg',
        );

        ref.read(productNotifierProvider.notifier).addLocalProduct(newProduct);

        if (context.mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('✅ Product added successfully!')),
          );
        }
      } else {
        final updatedProduct = widget.product!.copyWith(
          title: titleController.text.trim(),
          description: descriptionController.text.trim(),
          category: selectedCategory!,
          price: double.parse(priceController.text),
          rating: double.parse(ratingController.text),
          brand: brandController.text.trim(),
          stock: isActive ? 100 : 0,
        );
        ref
            .read(productNotifierProvider.notifier)
            .removeLocalProduct(widget.product!.id);
        ref
            .read(productNotifierProvider.notifier)
            .addLocalProduct(updatedProduct);

        if (context.mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Product updated successfully!')),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditMode = widget.product != null;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isEditMode ? "Update Product" : "Add Product",
                  style: TextsStyle.newProductStyle,
                ),
                const SizedBox(height: Dimensions.paddingSizeDefault),

                Center(
                  child: ProductProfileAvatar(
                    imageUrl:
                        'https://cdn.corporatefinanceinstitute.com/assets/product-mix3.jpeg',
                    size: 120,
                  ),
                ),

                const SizedBox(height: Dimensions.paddingSizeLarge),
                TextFieldWidget(
                  hintText: 'Product Title',
                  label: 'Product Title',
                  controller: titleController,
                  validator:
                      (value) =>
                          value == null || value.isEmpty ? 'Enter title' : null,
                ),
                const SizedBox(height: Dimensions.paddingSize),
                TextFieldWidget(
                  hintText: 'Product Description',
                  label: 'Description',
                  controller: descriptionController,
                  maxLines: 5,
                  minLines: 3,
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Enter description'
                              : null,
                ),
                const SizedBox(height: Dimensions.paddingSize),
                TextFieldWidget(
                  hintText: 'Brand Name',
                  label: 'Brand',
                  controller: brandController,
                  validator:
                      (value) =>
                          value == null || value.isEmpty ? 'Enter brand' : null,
                ),
                const SizedBox(height: Dimensions.paddingSize),
                TextFieldWidget(
                  hintText: '29.99',
                  label: 'Price',
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Enter price';
                    if (double.tryParse(value) == null) {
                      return 'Invalid price';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: Dimensions.paddingSize),
                TextFieldWidget(
                  hintText: '4.5',
                  label: 'Rating (0-5)',
                  controller: ratingController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Enter rating';
                    final rating = double.tryParse(value);
                    if (rating == null || rating < 0 || rating > 5) {
                      return 'Enter rating between 0 and 5';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: Dimensions.paddingSize),

                SwitchListTile(
                  title: const Text('In Stock'),
                  value: isActive,
                  activeColor: Colors.blue,
                  onChanged: (val) => setState(() => isActive = val),
                ),

                const SizedBox(height: Dimensions.paddingSizeLarge),
                Row(
                  children: [
                    Expanded(
                      child: CustomOutlineButton(
                        text: 'Back',
                        width: double.infinity,
                        isNeedImage: true,
                        iconImage: 'assets/images/back.png',
                        onPressed: () => Navigator.pop(context),
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeExtra,
                          vertical: Dimensions.paddingSizeLarge,
                        ),
                      ),
                    ),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    Expanded(
                      child: ElevatedButtonWidget(
                        text:
                            _isLoading
                                ? 'Saving...'
                                : isEditMode
                                ? 'Update'
                                : 'Save',
                        onPressed: _isLoading ? () {} : _saveProduct,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
