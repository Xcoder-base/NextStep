import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            const SizedBox(height: 16),
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.black12,
              child: Icon(
                Icons.person,
                size: 40,
                color: Colors.black45,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'USERNAME',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'user@example.com',
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12, width: 0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _buildProfileItem(Icons.edit, 'Edit Profile'),
                  const Divider(height: 1, thickness: 0.5, indent: 16),
                  _buildProfileItem(Icons.settings, 'Settings'),
                  const Divider(height: 1, thickness: 0.5, indent: 16),
                  _buildProfileItem(Icons.help_outline, 'Help'),
                  const Divider(height: 1, thickness: 0.5, indent: 16),
                  _buildProfileItem(Icons.info_outline, 'About'),
                  const Divider(height: 1, thickness: 0.5, indent: 16),
                  _buildProfileItem(Icons.logout, 'Sign Out', isRed: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String label, {bool isRed = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: isRed ? Colors.red : Colors.black54,
          ),
          const SizedBox(width: 12),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: isRed ? Colors.red : Colors.black87,
              letterSpacing: 1.1,
            ),
          ),
          const Spacer(),
          Icon(
            Icons.chevron_right,
            size: 16,
            color: Colors.grey.shade400,
          ),
        ],
      ),
    );
  }
}