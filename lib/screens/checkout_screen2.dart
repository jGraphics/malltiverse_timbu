import 'dart:ui';
import 'payment_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';





class CheckoutStage2 extends StatefulWidget {
  @override
  _CheckoutStage2State createState() => _CheckoutStage2State();
}

class _CheckoutStage2State extends State<CheckoutStage2> {
  String _selectedAddress = 'Address 1';
  final TextEditingController _deliveryAddressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: Image.asset('./assets/images/mall_logo.png', scale: 2.0,),
        title: const Text('Checkout ', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 19),),
      centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            const Text(
              'Select how to recceive your packages(s)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
                        const SizedBox(height: 21),
            const Text(
              'Pickup',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            ListTile(
              title: const Text('Old Secretariat Complex, Area 1, Garki Abaji Abji',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),),
              leading: Radio<String>(
                value: 'Address 1',
                groupValue: _selectedAddress,
                onChanged: (String? value) {
                  setState(() {
                    _selectedAddress = value!;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Sokoto Street, Area 1, Garki Area 1 AMAC',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),),
              leading: Radio<String>(
                value: 'Address 2',
                groupValue: _selectedAddress,
                onChanged: (String? value) {
                  setState(() {
                    _selectedAddress = value!;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
           const Text(
              'Delivery',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 35,),
            TextField(
              controller: _deliveryAddressController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Contact',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12,),
            TextField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(
                labelText: 'Phone nos 1',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16,),
            TextField(
              controller: _deliveryAddressController,
              decoration: const InputDecoration(
                labelText: 'Phone nos 1',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PaymentScreen(),
                    ),
                  );
                },
                child: const Text('Proceed to Payment'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
