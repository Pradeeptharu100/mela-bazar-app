import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:melebazaar_app/common/custom_button.dart';
import 'package:melebazaar_app/common/pt_colors.dart';
import 'package:melebazaar_app/features/product_detail/provider/product_provider.dart';
import 'package:melebazaar_app/utils/logger.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatefulWidget {
  final VoidCallback toggleTheme;

  const ProductDetailPage({super.key, required this.toggleTheme});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Map<String, String> selectedVariants = {};
  TextEditingController messageController = TextEditingController();
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<ProductProvider>(
          builder: (context, productProvider, child) {
            if (productProvider.product == null) {
              return const Text('Product Detail');
            }
            return Text(productProvider.product!.name);
          },
        ),
        actions: [
          Stack(
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
                  child: const Text(
                    '1',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.dark_mode : Icons.light_mode,
            ),
            onPressed: () {
              widget.toggleTheme();
              setState(() {
                isDarkMode = !isDarkMode;
              });
            },
          ),
        ],
      ),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          if (productProvider.product == null) {
            return const Center(child: CircularProgressIndicator());
          }
          final product = productProvider.product!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
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
                  items: product.images.map((url) {
                    return Builder(
                      builder: (BuildContext context) {
                        logger.d(
                            'Product image length : ${product.images.length}');
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.r),
                            child: CachedNetworkImage(
                              imageUrl: url,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const SizedBox(
                                child:
                                    Center(child: CircularProgressIndicator()),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.name,
                          style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text('NPR.${product.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(width: 8),
                          Text('NPR.${product.strikePrice.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 16,
                                  decoration: TextDecoration.lineThrough)),
                          const SizedBox(width: 8),
                          Text(
                              '${((product.strikePrice - product.price) / product.strikePrice * 100).toStringAsFixed(0)}% off',
                              style: const TextStyle(color: Colors.green)),
                        ],
                      ),
                    ],
                  ),
                ),
                // Variants selection
                ...product.variants[0].options.map((option) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(option.type,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: product.variants
                                .expand((variant) => variant.options)
                                .where((variantOption) =>
                                    variantOption.type == option.type)
                                .map((variantOption) => ChoiceChip(
                                      label: Text(variantOption.value),
                                      selected: selectedVariants[option.type] ==
                                          variantOption.value,
                                      onSelected: (selected) {
                                        setState(() {
                                          selectedVariants[option.type] =
                                              variantOption.value;
                                        });
                                      },
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                    )),

                // Stock information
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Text('In stock: ${product.variants[0].stock}',
                      style: const TextStyle(color: Colors.green)),
                ),

                // Add to cart button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomButton(
                    buttonColor: PTColor.secondary,
                    height: 45.h,
                    label: 'Add to Cart',
                    onClick: () {},
                  ),
                ),

                // Description
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Description',
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 8),
                      HtmlWidget(
                        product.description,
                        onTapUrl: (url) async => true,
                      ),
                    ],
                  ),
                ),

                // Specifications
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Specifications',
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 8),
                      ...product.specification.map((spec) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              children: [
                                Text('${spec['type']}: ',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                Text(spec['value']),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),

                // Reviews (placeholder)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Reviews',
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 8),
                      const Text('No reviews yet.'),
                    ],
                  ),
                ),

                // Message seller
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomButton(
                    buttonColor: PTColor.secondary,
                    label: 'Message Seller',
                    onClick: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Message Seller'),
                          content: TextField(
                            controller: messageController,
                            decoration: const InputDecoration(
                                hintText: 'Enter your message'),
                          ),
                          actions: [
                            TextButton(
                              child: const Text('Cancel'),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            TextButton(
                              child: const Text('Send'),
                              onPressed: () {
                                showNotification();
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void initializeNotifications() {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false).fetchProduct();
    });
    initializeNotifications();
  }

  Future<void> showNotification() async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'channel_id', 'channel_name',
        importance: Importance.max, priority: Priority.high, ticker: 'ticker');
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      'Thank you for Contacting Us',
      'We will get back to you soon.',
      platformChannelSpecifics,
      payload: 'Notification Payload',
    );
  }
}
