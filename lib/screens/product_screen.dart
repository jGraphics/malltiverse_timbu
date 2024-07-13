import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:malltiverse_timbu/apis/timbu_api.dart';
import 'package:malltiverse_timbu/constants/colors.dart';
import 'package:malltiverse_timbu/screens/view_product.dart';
import 'package:malltiverse_timbu/apis/models/listOfProductItem.dart';

class ProductScreen extends StatefulWidget {
  final List<Item> cart;
  final void Function(Item product) addToCart;

  const ProductScreen({super.key, required this.cart, required this.addToCart});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final Map<String, List<Item>> _categoryProducts = {};

  @override
  void initState() {
    super.initState();
    getAllProductByCategory();
  }

  void getAllProductByCategory() async {
    final get = Provider.of<TimbuApiProvider>(context, listen: false);
    var categories = ["Tech Gadget", "Men's Fashion", "Women's Fashion"];

    for (var category in categories) {
      var products = await get.getProductByCategory(category);
      setState(() {
        _categoryProducts[category] = products.items;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final NumberFormat currencyFormat =
        NumberFormat.currency(symbol: '₦', decimalDigits: 2);

    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          './assets/images/mall_logo.png',
          fit: BoxFit.contain,
        ),
        title: const Text(
          'Product List',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: colorBgW,
        elevation: 4.0,
      ),
      backgroundColor: colorBgW,
      body: _categoryProducts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      width: 380,
                      height: 232,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          image: AssetImage('./assets/images/hnc.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Premium Sound,',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Premium Savings',
                                style: TextStyle(
                                  color: colorBgW,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Limited offer, hop on and get yours now',
                                style: TextStyle(
                                  color: colorBgW,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 44),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _categoryProducts.keys.map((category) {
                        List<Item> products = _categoryProducts[category]!;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                category,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 200,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: products.length,
                                itemBuilder: (context, index) {
                                  Item product = products[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ViewProductPage(
                                              id: product.id,
                                              itemPrice: currencyFormat.format(
                                                  product.currentPrice?[0]
                                                          .ngn[0] ??
                                                      0),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 185,
                                        height: 347,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Center(
                                                child: Image.network(
                                                  "https://api.timbu.cloud/images/${product.photos[0].url}",
                                                  height: 112,
                                                  width: 150,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    product.name ?? '',
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    currencyFormat.format(
                                                        product.currentPrice?[0]
                                                                .ngn[0] ??
                                                            0),
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
