import '../screens/cart_screen.dart';
import 'package:flutter/material.dart';
import '../screens/product_screen.dart';
import '../apis/models/listOfProductItem.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:malltiverse_timbu/constants/colors.dart';
import 'package:malltiverse_timbu/screens/profileScreen.dart';




class BNavWidget extends StatefulWidget {
  const BNavWidget({super.key});

  @override
  State<BNavWidget> createState() => _BNavWidgetState();
}

class _BNavWidgetState extends State<BNavWidget> {
  int _selectedIndex = 0;
  List<Item> cart = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

 void addToCart(Item product) {
    setState(() {
      final existingItemIndex = cart.indexWhere((item) => item.id == product.id);
      if (existingItemIndex >= 0) {
        cart[existingItemIndex].quantity++;
      } else {
        cart.add(product);
      }
    });
  }

void removeFromCart(Item product) {
    setState(() {
      final existingItemIndex = cart.indexWhere((item) => item.id == product.id);
      if (existingItemIndex >= 0) {
        cart[existingItemIndex].quantity--;
        if (cart[existingItemIndex].quantity == 0) {
          cart.removeAt(existingItemIndex);
        }
      }
    });
  }
  void updateCart() {
    setState(() {});
  }

  int getTotalCartQuantity() {
    return cart.fold(0, (total, current) => total + current.quantity);
  }

  List<Widget> _widgetOptions() {
    return [
      ProductScreen(
        cart: cart,
        addToCart: addToCart,
      ),
      CartPage(
        cart: cart,
        removeFromCart: removeFromCart,
        updateCart: updateCart,
      ),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    int cartItemCount = getTotalCartQuantity();
    return Scaffold(
      body: Center(
        child: _widgetOptions().elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(IconsaxPlusBold.home_2),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: <Widget>[
                const Icon(IconsaxPlusBold.shopping_cart),
                if (cartItemCount > 0)
                  Positioned(
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      child: Text(
                        '$cartItemCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: colorPrimary,
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
        backgroundColor: Colors.black,
      ),
    );
  }
}


bottomNavigationBar: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: InkWell(
          onTap: () {
            if (item2 != null) {
              addTocart(item2!);
            }
          },
          child: Padding(
            padding:
                const EdgeInsets.only(left: 8.0, right: 8, bottom: 5, top: 5),
            child: Container(
              height: 60,
              decoration: const BoxDecoration(
                  color: colorPrimary,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(75),
                      bottomLeft: Radius.circular(75),
                      bottomRight: Radius.circular(25))),
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
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),