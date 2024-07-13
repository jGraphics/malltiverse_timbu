import 'dart:developer';
import 'package:intl/intl.dart';
import '../model/message_res.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:malltiverse_timbu/apis/timbu_api.dart';
import 'package:malltiverse_timbu/constants/colors.dart';
import 'package:malltiverse_timbu/widgets/review_slider.dart';
import 'package:malltiverse_timbu/apis/models/listOfProductItem.dart';


class ViewProductPage extends StatefulWidget {
  const ViewProductPage({super.key, this.id, this.itemPrice});
  final String? id;
  final String? itemPrice;

  @override
  State<ViewProductPage> createState() => _ViewProductPageState();
}

class _ViewProductPageState extends State<ViewProductPage> {
  var name = '';
  Item? item;
  bool isLoading = true;
  
  get cart => null;

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print("${widget.id}");
    }
    getAproduct();
  }

  void getAproduct() async {
    var get = Provider.of<TimbuApiProvider>(context, listen: false);
    try {
      var product = await get.getAProduct(widget.id!);
      setState(() {
        name = product.name;
        item = product;
        isLoading = false;
      });
      log(product.name);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      log("Error fetching product: $e");
    }
  }

  void addTocart(Item productModel) async {
    // Assuming `cart2` is a List<Item2> defined elsewhere in your code
    cart.add(productModel);
    if (kDebugMode) {
      print('${productModel.name} added to cart');
    }
    success(context: context, message: "${productModel.name} is now in cart");
  }

  String text = lorem(paragraphs: 1, words: 20);
  String text2 = lorem(paragraphs: 1, words: 19);

  final NumberFormat currencyFormat =
      NumberFormat.currency(symbol: '₦', decimalDigits: 2);

  @override
  Widget build(BuildContext context) {
    double? itemPrice = double.tryParse(
        widget.itemPrice?.replaceAll('₦', '').replaceAll(',', '') ?? '0');
    return Scaffold(
      backgroundColor: colorBgW,
      appBar: AppBar(
        backgroundColor: colorPrimary,
        toolbarHeight: 60,
        leading: IconButton(
          color: colorBgW,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Product Details',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (item != null) ...[
                    SizedBox(
                      height: 350,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: item!.photos.length,
                        itemBuilder: (context, index) {
                          var photoUrl =
                              "https://api.timbu.cloud/images/${item!.photos[index].url}";
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Image.network(
                                photoUrl,
                                height: 250,
                                width: 250,
                                fit: BoxFit.contain,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          color: colorBgW,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right:210),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item!.name!.toUpperCase(),
                                  softWrap: true,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  currencyFormat.format(itemPrice),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                              Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Quantity = ${item!.availableQuantity} pcs available now',
                                  style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.normal),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: const SizedBox(
                                    width: 50,
                                    height: 40,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Description",
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        item!.description == null
                                            ? Text(
                                                text2,
                                                softWrap: true,
                                                style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black),
                                              )
                                            : Text(
                                                item!.description!,
                                                style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black),
                                              )
                                      ]),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ReviewSlider(),
                          ],
                        ),
                      ),
                    ),
                  ] else
                    const Center(child: Text("Product not found")),
                ],
              ),
            ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(color: colorBgW),
        child: InkWell(
          onTap: () {
            if (item != null) {
              addTocart(item!);
            }
          },
          child: Padding(
            padding:
                const EdgeInsets.only(left: 24, right: 20, bottom: 15, top: 15),
            child: Container(
              height: 60,
              decoration: const BoxDecoration(
                  color: colorPrimary,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Add To Cart  ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                  Icon(
                    IconsaxPlusBold.shopping_cart,
                    color: Colors.white,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
