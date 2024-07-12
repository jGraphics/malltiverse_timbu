import 'package:flutter/material.dart';
import 'package:malltiverse_timbu/constants/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: colorPrimary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: colorPrimary,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/profile_picture.png'), // Replace with your profile picture asset
                    ),
                    SizedBox(height: 10),
                    Text(
                      'John Doe', // Replace with actual user name
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'johndoe@example.com', // Replace with actual user email
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.account_circle, color: colorPrimary),
              title: const Text('Account Information'),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
              onTap: () {
                // Handle navigation to account information screen
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings, color: colorPrimary),
              title: const Text('Settings'),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
              onTap: () {
                // Handle navigation to settings screen
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.history, color: colorPrimary),
              title: const Text('Order History'),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
              onTap: () {
                // Handle navigation to order history screen
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: colorPrimary),
              title: const Text('Logout'),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
              onTap: () {
                // Handle logout functionality
              },
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
