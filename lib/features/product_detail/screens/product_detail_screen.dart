import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:melebazaar_app/common/custom_button.dart';
import 'package:melebazaar_app/common/notification_service.dart';
import 'package:melebazaar_app/common/pt_colors.dart';
import 'package:melebazaar_app/extension.dart';
import 'package:melebazaar_app/features/product_detail/provider/product_provider.dart';
import 'package:melebazaar_app/hive_provider/theme_hive_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProductDetailPage extends StatelessWidget {
  Map<String, String> selectedVariants = {};

  TextEditingController messageController = TextEditingController();

  NotificationService notificationService = NotificationService();

  final _formKey = GlobalKey<FormState>();

  ProductDetailPage({super.key});

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
            builder: (context, counter, child) => Stack(
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
                      '${counter.totalQuantity}',
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

            return product.image.isEmpty
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.all(15),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (product.image.isNotEmpty)
                            CarouselSlider.builder(
                              itemCount: product.image.length,
                              itemBuilder: (context, index, realIndex) {
                                final imageUrl = product.image[index];
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5.r),
                                    child: CachedNetworkImage(
                                      imageUrl: imageUrl.path,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const SizedBox(
                                        child: Center(
                                            child: CircularProgressIndicator()),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              options: CarouselOptions(
                                height: 300.0,
                                enlargeCenterPage: true,
                                autoPlay: true,
                                aspectRatio: 16 / 9,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enableInfiniteScroll: true,
                                autoPlayAnimationDuration:
                                    const Duration(milliseconds: 800),
                                viewportFraction: 0.8,
                              ),
                            ),
                          const SizedBox(height: 15),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                      'NPR.${product.price.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(width: 8),
                                  Text(
                                      'NPR.${product.strikePrice.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          decoration:
                                              TextDecoration.lineThrough)),
                                  const SizedBox(width: 8),
                                  Text(
                                      '${((product.strikePrice - product.price) / product.strikePrice * 100).toStringAsFixed(0)}% off',
                                      style:
                                          const TextStyle(color: Colors.green)),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),

                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: product.variants.length,
                            itemBuilder: (context, innerIndex) {
                              final variants = product.variants[innerIndex];
                              final variantType = variants.type.name;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    variantType,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: List.generate(
                                      variants.values.length,
                                      (index) {
                                        final isSelected =
                                            productProvider.getSelectedIndex(
                                                    variantType) ==
                                                index;
                                        final variantValues =
                                            variants.values[index];
                                        return GestureDetector(
                                          onTap: () {
                                            productProvider.setSelectedIndex(
                                                variantType, index);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 5),
                                              decoration: BoxDecoration(
                                                color: isSelected
                                                    ? PTColor.primary
                                                    : null,
                                                borderRadius:
                                                    BorderRadius.circular(5.r),
                                                border: Border.all(
                                                    color: PTColor.primary),
                                              ),
                                              child: Text(
                                                variantValues.value
                                                    .toString()
                                                    .toCapitalized(),
                                                style:
                                                    TextStyle(fontSize: 16.sp),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                ],
                              );
                            },
                          ),

                          // // Stock information
                          Text(
                              'In stock: ${product.initialStock ?? "Not Available"} ',
                              style: const TextStyle(color: Colors.green)),
                          const SizedBox(height: 15),

                          CustomButton(
                            buttonColor: PTColor.secondary,
                            height: 45.h,
                            label: 'Add to Cart',
                            onClick: () {
                              productProvider.updateQuantity();
                            },
                          ),
                          // // Description
                          const SizedBox(height: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Description',
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                              const SizedBox(height: 8),
                              HtmlWidget(
                                product.description,
                                onTapUrl: (url) async => true,
                              ),
                            ],
                          ),

                          // // Specifications
                          const SizedBox(height: 15),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Specifications',
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                              const SizedBox(height: 8),
                              ...product.specification.map((spec) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Row(
                                      children: [
                                        Text('${spec.type}: ',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Text(spec.value),
                                      ],
                                    ),
                                  )),
                            ],
                          ),

                          // // Reviews (placeholder)
                          const SizedBox(height: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Reviews',
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                              const SizedBox(height: 8),
                              const Text('No reviews yet.'),
                            ],
                          ),

                          // // Message seller
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
                                    height: MediaQuery.of(context).size.height *
                                        0.75,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter a message';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.r),
                                                  borderSide: BorderSide(
                                                      color: Colors
                                                          .grey.shade200)),
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
                          const SizedBox(height: 20),
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
