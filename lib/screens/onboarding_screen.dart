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
    ];

    final List<Alignment> imagePositions = [
      const Alignment(-0.8, -0.4),
      const Alignment(0.7, -0.5),
      const Alignment(-0.6, -0.2),
      const Alignment(0.5, -0.1),
      const Alignment(-0.4, 0.0),
      const Alignment(0.3, 0.1),
      const Alignment(0.0, -0.3),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Floating images above title
          for (int i = 0; i < assetImages.length; i++)
            Align(
              alignment: imagePositions[i],
              child: Container(
                width: 70, // Uniform small size
                height: 70,
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

          // Main content column
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 2), // Push content down
                
                // Title and content
                const Text(
                  "NextStep",
                  style: TextStyle(
                    fontSize: 32, // Slightly larger for hierarchy
                    fontWeight: FontWeight.w800,
                    height: 1,
                    letterSpacing: -1,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Prove your genius.Get rewarded.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16, // Slightly larger for readability
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _navigateToAuthScreen(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Join Now",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  children: [
                    const Text(
                      "65,897/100,000 participants Joined",
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Challenges will start on 5th May, 2025",
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40), // Bottom padding
              ],
            ),
          ),

          // Black pill-shaped login button
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            right: 24,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(50), // Pill shape
              ),
              child: TextButton(
                onPressed: () => _showLoginBottomSheet(context),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50), // Pill shape
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
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