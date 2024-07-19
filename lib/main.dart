import 'apis/timbu_api.dart';
import 'screens/cart_screen.dart';
import 'screens/view_product.dart';
import 'screens/profile_screen.dart';
import 'screens/product_screen.dart';
import 'screens/payment_screen.dart';
import 'model/onboarding_model.dart';
import 'screens/onboarding_page.dart';
import 'screens/checkout_screen.dart';
import 'screens/checkout_screen2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'apis/models/OnBoardingController.dart';
import 'package:malltiverse_timbu/screens/wish_list.dart';
import 'package:malltiverse_timbu/constants/bottom_bar.dart';
import 'package:malltiverse_timbu/screens/order_history.dart';
import 'package:malltiverse_timbu/constants/wish_list_provider.dart';





void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TimbuApiProvider(),
        ),
         ChangeNotifierProvider(
          create: (_) => WishlistProvider(),
          ),
        ChangeNotifierProvider(
          create: (_) => OnboardingController(
            pageController: PageController(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Jejelove x HNG 11',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
          }),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: 'bnav',
        routes: {
                   'onboarding': (context) => const OnboardingScreen(),
          'bnav': (context) => const BottomNav(),
          'checkout': (context) => const CheckoutSuccessPage(),
          'cart': (context) => CartPage(
                cart: const [],
                removeFromCart: (product) {},
                updateCart: () {},
              ),
          'profile': (context) => const ProfileScreen(),
          'product': (context) => ProductScreen(
                cart: const [],
                addToCart: (product) {}, category: '',
              ),
          'products-detail': (context) => const ViewProductPage(),
          'order-history': (context) => const OrderHistoryScreen(),
          'wish-list': (context) => const WishlistScreen(wishlistItems: [],),
          'checkout_stage_2': (context) => CheckoutStage2(), // Add route for checkout stage 2
          'payment': (context) => PaymentScreen(), // Add route for payment screen
        },
      ),
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final onboardingController = Provider.of<OnboardingController>(context);

    final onboardingModel = OnboardingModel(
      backgroundImg: 'assets/images/hnc.png',
      onBoardMsgHeading: 'Jejelove Malltiverse Timbu Shop',
      onBoardMsgBody: 'Shop products from timbu api - HNG Stage4',
    );

    return OnboardingScreenUtil(
      onboardingModel: onboardingModel,
      controller: onboardingController,
    );
  }
}