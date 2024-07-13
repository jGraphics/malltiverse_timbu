import 'dart:ui';
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
  List<Item> _list = [];

  @override
  void initState() {
    super.initState();
    getAllProduct();
  }

  void getAllProduct() {
    final get = Provider.of<TimbuApiProvider>(context, listen: false);
    get.getProduct().then((value) {
      setState(() {
        _list = value.items;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final get = context.watch<TimbuApiProvider>();
    final NumberFormat currencyFormat =
        NumberFormat.currency(symbol: '₦', decimalDigits: 2);

    return Scaffold(
      backgroundColor: colorBgW,
      appBar: AppBar(
        leading: const Image(image: AssetImage('./assets/images/mall_logo.png')),
        title: const Text(
          'Jejelove Products List',
          style: TextStyle(
            color: Colors.black, 
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        backgroundColor: colorBgW,
        elevation: 4.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: get.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
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
                          color: const Color(0x80b2b2b2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Middle Title',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Subtitle Text',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 44),
                    const Text(
                      'Tech Gadget',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        mainAxisExtent: 350,
                      ),
                      itemCount: _list.length,
                      itemBuilder: (BuildContext context, int index) {
                        var product = _list[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewProductPage(
                                  id: product.id,
                                  itemPrice: currencyFormat.format(
                                      product.currentPrice?[0].ngn[0] ?? 0),
                                ),
                              ),
                            );
                          },
                         child: Card(
                            color: Colors.white.withOpacity(1),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xABededed),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Image.network(
                                        "https://api.timbu.cloud/images/${product.photos[0].url}",
                                        height: 184,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        currencyFormat.format(product.currentPrice?[0].ngn[0] ?? 0),
                                        style: const TextStyle(
                                            fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.shopping_bag_outlined,
                                          color: colorPrimary,
                                          size: 24,
                                        ),
                                        onPressed: () {
                                          success(
                                              context,
                                              "${product.name} added to cart",
                                              colorPrimary);
                                          widget.addToCart(product);
                                        },
                                      ),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      product.name!,
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

void success(BuildContext context, String successMessage, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Text(
        successMessage,
        style: const TextStyle(color: Colors.white),
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}