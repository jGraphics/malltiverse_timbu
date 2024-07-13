import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:malltiverse_timbu/constants/colors.dart';
import 'package:malltiverse_timbu/model/message_res.dart';
import 'package:malltiverse_timbu/screens/checkout_screen2.dart';
import 'package:malltiverse_timbu/apis/models/listOfProductItem.dart';

class CartPage extends StatefulWidget {
  final List<Item> cart;
  final void Function(Item product) removeFromCart;
  final void Function() updateCart;

  const CartPage({
    Key? key,
    required this.cart,
    required this.removeFromCart,
    required this.updateCart,
  }) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final NumberFormat currencyFormat = NumberFormat.currency(symbol: '₦', decimalDigits: 2);

  void checkout() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CheckoutStage2()),
    );
    setState(() {
      widget.cart.clear();
    });

    widget.updateCart(); // Update cart state
    success(context: context, message: 'Cart cleared.');
  }

  void incrementQuantity(Item product) {
    setState(() {
      product.quantity++;
    });
    widget.updateCart(); // Update cart state
  }

  void decrementQuantity(Item product) {
    setState(() {
      if (product.quantity > 1) {
        product.quantity--;
      } else {
        success(context: context, message: '${product.name} removed from cart');
        widget.removeFromCart(product);
      }
    });
    widget.updateCart(); // Update cart state
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = widget.cart.fold(0.00, (previousValue, product) {
      return previousValue + (product.currentPrice?[0].ngn[0] ?? 0.0 * product.quantity);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Cart',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: colorBgW,
      ),
      backgroundColor: colorBgW,
      body: SingleChildScrollView(
        child: widget.cart.isNotEmpty
            ? Column(
                children: [
                  const SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.cart.length + 1, // +1 for the shopping summary card
                    physics: const NeverScrollableScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    itemBuilder: (context, index) {
                      if (index < widget.cart.length) {
                        Item product = widget.cart[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: const BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                          child: ListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            leading: Image.network(
                              'https://api.timbu.cloud/images/${product.photos[0].url}',
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                            title: Text(
                              '${product.name}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '₦${product.currentPrice?[0].ngn[0].toString()}',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Quantity: ${product.quantity}'),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(IconsaxPlusLinear.minus_square),
                                          onPressed: () {
                                            decrementQuantity(product);
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(IconsaxPlusLinear.add_square),
                                          onPressed: () {
                                            incrementQuantity(product);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                success(
                                  context: context,
                                  message: '${product.name} removed from cart',
                                );
                                setState(() {
                                  widget.removeFromCart(product);
                                });
                                widget.updateCart(); // Update cart state
                              },
                            ),
                          ),
                        );
                      } else {
                        // This section creates the shopping summary card
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: const BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Shopping Summary',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    const Expanded(
                                      flex: 3,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: 'Enter Discount Code',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      flex: 1,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // Apply discount logic
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: colorPrimary,
                                        ),
                                        child: const Text('Apply'),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Sub-Total'),
                                    Text(
                                      currencyFormat.format(totalPrice),
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Delivery Fee'),
                                    const Text('₦1,500'),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Total Amount:',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      currencyFormat.format(totalPrice),
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              )
            : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 305),
                  Center(
                    child: Text(
                      'No Items in Cart',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
