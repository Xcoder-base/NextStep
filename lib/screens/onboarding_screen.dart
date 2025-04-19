import 'package:flutter/material.dart';
import 'login_bottom_sheet.dart';
import 'authentication_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  void _showLoginBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const LoginBottomSheet(),
    );
  }

  void _navigateToAuthScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AuthenticationScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> assetImages = [
      'assets/davincicode.jpg',
      'assets/dice.jpg',
      'assets/professor.jpg',
      'assets/chess.jpg',
      'assets/kit.jpg',
      'assets/davinci.jpg',
      'assets/board.jpg',
      'assets/meditation.jpg',
      'assets/matrix.jpg',
      'assets/fingeronscreen.jpg',
      'assets/dice.jpg',
      'assets/boxes.jpeg',
    ];

    final List<Alignment> imagePositions = [
      const Alignment(-0.9, -0.5),  // Top-left
      const Alignment(0.8, -0.6),   // Top-right
      const Alignment(-0.7, -0.3),  // Mid-left
      const Alignment(0.6, -0.2),   // Mid-right
      const Alignment(-0.5, 0.0),   // Center-left
      const Alignment(0.4, 0.1),    // Center-right
      const Alignment(0.0, -0.4),   // Top-center
      const Alignment(-0.3, 0.3),   // Bottom-left
      const Alignment(0.2, -0.1),   // Upper-mid-right
      const Alignment(-0.1, 0.4),   // Bottom-mid-left
      const Alignment(0.3, 0.5),    // Bottom-right
      const Alignment(0.1, -0.2),   // Upper-mid-center
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Floating images in top half
          for (int i = 0; i < assetImages.length; i++)
            Align(
              alignment: imagePositions[i],
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    assetImages[i],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

          // Content column
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                
                // Title
                const Text(
                  "NextStep",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    height: 1,
                    letterSpacing: -1,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 6),
                
                // Subtitle
                const Text(
                  "Beat the Challenge. Get Rewarded.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 24),
                
                // Join button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _navigateToAuthScreen(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Join Now",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                
                // Participants count
                const Text(
                  "65,897/100,000 participants Joined",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),

          // Login button
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            right: 24,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(50),
              ),
              child: TextButton(
                onPressed: () => _showLoginBottomSheet(context),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}