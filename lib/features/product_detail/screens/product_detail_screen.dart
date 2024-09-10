import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melebazaar_app/common/custom_button.dart';
import 'package:melebazaar_app/common/notification_service.dart';
import 'package:melebazaar_app/common/pt_colors.dart';
import 'package:melebazaar_app/features/product_detail/components/add_to_cart_button.dart';
import 'package:melebazaar_app/features/product_detail/components/product_description.dart';
import 'package:melebazaar_app/features/product_detail/components/product_image_carousel.dart';
import 'package:melebazaar_app/features/product_detail/components/product_info.dart.dart';
import 'package:melebazaar_app/features/product_detail/components/product_reviews.dart';
import 'package:melebazaar_app/features/product_detail/components/product_specifications.dart';
import 'package:melebazaar_app/features/product_detail/components/stock_info.dart';
import 'package:melebazaar_app/features/product_detail/components/variant_selection.dart';
import 'package:melebazaar_app/features/product_detail/provider/product_provider.dart';
import 'package:melebazaar_app/hive_provider/theme_hive_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController messageController = TextEditingController();
  final NotificationService notificationService = NotificationService();

  ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hiveProvider = context.watch<HiveProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Consumer<ProductProvider>(
          builder: (context, productProvider, child) {
            return Text(productProvider.product?.name ?? "Product Detail");
          },
        ),
        actions: [
          Consumer<ProductProvider>(
            builder: (context, productProvider, child) => Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {},
                ),
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Text(
                      '${productProvider.totalQuantity}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              hiveProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            ),
            onPressed: () {
              hiveProvider.toggleThemeMode();
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Consumer<ProductProvider>(
          builder: (context, productProvider, child) {
            final product = productProvider.product;

            if (productProvider.isLoading || product == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductImageCarousel(product: product),
                    const SizedBox(height: 15),
                    ProductInfo(product: product),
                    const SizedBox(height: 15),
                    VariantSelection(
                        productProvider: productProvider, product: product),
                    const SizedBox(height: 15),
                    StockInfo(stock: product.initialStock ?? 0),
                    const SizedBox(height: 15),
                    AddToCartButton(onClick: () {
                      productProvider.updateQuantity();
                    }),
                    const SizedBox(height: 15),
                    ProductDescription(description: product.description),
                    const SizedBox(height: 15),
                    ProductSpecifications(product: product),
                    const SizedBox(height: 15),
                    const ProductReviews(),
                    const SizedBox(height: 15),
                    CustomButton(
                      buttonColor: PTColor.secondary,
                      label: 'Message Seller',
                      onClick: () {
                        showModalBottomSheet(
                          isDismissible: true,
                          isScrollControlled: true,
                          backgroundColor: hiveProvider.isDarkMode
                              ? Colors.black.withOpacity(0.8)
                              : Colors.white,
                          context: context,
                          builder: (context) => Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.75,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Message Seller',
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 20),
                                    TextFormField(
                                      maxLines: 7,
                                      controller: messageController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a message';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.r),
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade200)),
                                        hintText: 'Enter your message',
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CustomButton(
                                            buttonColor: PTColor.red,
                                            onClick: () {
                                              Navigator.pop(context);
                                            },
                                            label: 'Cancel',
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Expanded(
                                          child: CustomButton(
                                            onClick: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                Navigator.pop(context);
                                                notificationService
                                                    .showNotification();
                                              }
                                            },
                                            buttonColor: PTColor.primary,
                                            label: 'Send',
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
