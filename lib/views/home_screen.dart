import 'package:e_commerce_app/constants/color-codes.dart';
import 'package:e_commerce_app/controllers/products_controller.dart';
import 'package:e_commerce_app/models/products_model.dart';
import 'package:e_commerce_app/views/components/font_manager.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  final remoteConfig = FirebaseRemoteConfig.instance;
  @override
  void initState() {
    super.initState();
    _initializeRemoteConfig();
  }

  Future<void> _initializeRemoteConfig() async {
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 20),
      minimumFetchInterval: const Duration(hours: 1),
    ));
    await remoteConfig.setDefaults(const {
      "displayDiscount": false,
    });
    await remoteConfig.fetchAndActivate();
    remoteConfig.onConfigUpdated.listen((event) async {
      await remoteConfig.activate();
      final productsProvider =
          Provider.of<ProductsProvider>(context, listen: false);

      // Check if the context is still valid
      if (mounted) {
        productsProvider.updateDiscountDisplayStatus(
            remoteConfig.getBool("displayDiscount"));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: null,
      backgroundColor: ColorCodes.primaryBg,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: null,
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "e-Shop",
              style: FontManager.getTextStyle(
                context,
                color: Colors.white,
                fontSize: 18,
                lWeight: FontWeight.w700,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
              child: const Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: ColorCodes.primaryButtonBg,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
        child: FutureBuilder<List<Product>>(
            future:
                Provider.of<ProductsProvider>(context).fetchProducts(context),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                    child: Text(
                        "Error: failed to load data due to ${snapshot.error} "));
              }
              List<Product> products = snapshot.data ?? [];
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    mainAxisExtent: 310),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return _buildProdcutCard(products[index]);
                },
              );
            }),
      ),
    );
  }

  Widget _buildProdcutCard(Product product) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "/productInfo",arguments: {"productId" : product.id});
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0), color: Colors.white),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: 200,
              child: Image.network(
                product.thumbnail,
                fit: BoxFit.contain,
              ),
            ),
            Text(
              product.title,
              style: FontManager.getTextStyle(context,
                  color: Colors.black, fontSize: 14, lWeight: FontWeight.w600),
            ),
            Text(
              product.description,
              style: FontManager.getTextStyle(
                context,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Provider.of<ProductsProvider>(
                      context,
                    ).displayDiscount!
                        ? Container(
                            margin: EdgeInsets.only(right: 4.0),
                            child: Text(
                              "\$${product.price.toString()}",
                              style: const TextStyle(
                                fontSize: 12,
                                color:
                                    Colors.grey, // Color for the original price
                                decoration: TextDecoration
                                    .lineThrough, // Strikethrough effect
                              ),
                            ),
                          )
                        : Text("\$${product.price.toString()}",
                            style: FontManager.getTextStyle(context,
                                color: Colors.black, fontSize: 14)),
                    Provider.of<ProductsProvider>(
                      context,
                    ).displayDiscount!
                        ? Text(
                            "\$${getDiscountedPrice(product.price, product.discountPercentage)}",
                            style:
                                FontManager.getTextStyle(context, fontSize: 12),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
                Provider.of<ProductsProvider>(
                  context,
                ).displayDiscount!
                    ? Text(
                        "${product.discountPercentage.toStringAsFixed(1)}% off",
                        style: FontManager.getTextStyle(context,
                            fontSize: 12, color: Colors.green.shade400),
                      )
                    : SizedBox.shrink(),
              ],
            )
          ],
        ),
      ),
    );
  }

  String getDiscountedPrice(double price, double discountPercentage) {
    final discountedPrice = price * (1 - discountPercentage / 100);
    return discountedPrice.toStringAsFixed(2);
  }
}
