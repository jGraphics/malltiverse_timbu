import 'payment_screen.dart';
import 'package:flutter/material.dart';


class CheckoutStage2 extends StatefulWidget {
  @override
  _CheckoutStage2State createState() => _CheckoutStage2State();
}

class _CheckoutStage2State extends State<CheckoutStage2> {
  String _selectedAddress = 'Address 1';
  TextEditingController _deliveryAddressController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout Stage 2'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pickup Option',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: const Text('Address 1'),
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
              title: const Text('Address 2'),
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
              'Delivery Option',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _deliveryAddressController,
              decoration: const InputDecoration(
                labelText: 'Delivery Address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
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
