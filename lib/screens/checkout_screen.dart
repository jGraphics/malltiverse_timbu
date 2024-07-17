import 'package:flutter/material.dart';
import 'package:malltiverse_timbu/constants/colors.dart';

class CheckoutSuccessPage extends StatelessWidget {
  const CheckoutSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 90,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              './assets/images/mall_logo.png',
              width: 99,
              height: 31,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 8),
          ],
        ),
        centerTitle: true,
        backgroundColor: colorBgW,
      ),
      backgroundColor: colorBgW,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('./assets/images/confetti.png'),
                repeat: ImageRepeat.repeat,
              ),
            ),
          ),
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle,
                  size: 92,
                  color: colorPrimary,
                ),
                SizedBox(height: 20),
                Text(
                  'Order Placed Successfully',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Thanks for your purchase',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
