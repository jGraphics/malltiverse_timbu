import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
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
        leadingWidth: 65,
        leading: Image.asset(
          './assets/images/mall_logo.png', width: 120, height: 40,
          fit: BoxFit.contain,
        ),
        title: Text(
          'Product List',
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              fontSize: 19.0,
              fontWeight: FontWeight.w600,
              height: 1.22,
              color: blFa,
            ),
          ),
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
                              height: 350,
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
                                        width: 250,
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
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                              ),
                                              child: Image.network(
                                                "https://api.timbu.cloud/images/${product.photos[0].url}",
                                                height: 150,
                                                width: double.infinity,
                                                fit: BoxFit.contain,
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
                                                    product.description ?? '',
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(height: 4),
                                                  const Row(
                                                    children: [
                                                      Image(
                                                          image: AssetImage(
                                                              'assets/images/fill_star.png')),
                                                      Image(
                                                          image: AssetImage(
                                                              'assets/images/fill_star.png')),
                                                      Image(
                                                          image: AssetImage(
                                                              'assets/images/fill_star.png')),
                                                      Image(
                                                          image: AssetImage(
                                                              'assets/images/fill_star.png')),
                                                      Image(
                                                          image: AssetImage(
                                                              'assets/images/fill_star.png')),
                                                    ],
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
                                                  OutlinedButton(
                                                    onPressed: () {
                                                      widget.addToCart(product);
                                                    },
                                                    style: ButtonStyle(
                                                      padding:
                                                          WidgetStateProperty.all(
                                                              const EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      20)),
                                                      side: WidgetStateProperty.all(
                                                        const BorderSide(
                                                          color: colorPrimary,
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                      shape: WidgetStateProperty.all(
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  14),
                                                        ),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      'Add to Cart',
                                                      style:
                                                          GoogleFonts.montserrat(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
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