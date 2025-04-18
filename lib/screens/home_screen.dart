import 'package:flutter/material.dart';
import 'challenge_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPageIndex = 0;
  final List<Map<String, dynamic>> challenges = [
    {
      'image': 'assets/homescreen.jpg',
      'title': 'Numbers Survival',
      'difficulty': '2/10 (IQ 100+)',
      'reward': '\$40 USD',
      'locked': true,
      'isDemo': false,
    },
    {
      'image': 'assets/pinterest.jpg',
      'title': 'The Lock',
      'difficulty': '4/10 (IQ 115+)',
      'reward': '\$55 USD',
      'locked': true,
      'isDemo': false,
    },
    {
      'image': 'assets/pinterest1.jpg',
      'title': 'Smart Path',
      'difficulty': '3/10 (IQ 110+)',
      'reward': '\$65 USD',
      'locked': true,
      'isDemo': false,
    },
    {
      'image': 'assets/pinterest2.jpg',
      'title': 'The Code',
      'difficulty': '5/10 (IQ 120+)',
      'reward': '\$65 USD',
      'locked': true,
      'isDemo': false,
    },
    {
      'image': 'assets/pinterest3.jpg',
      'title': 'Brain Box',
      'difficulty': '6/10 (IQ 125+)',
      'reward': '\$75 USD',
      'locked': true,
      'isDemo': false,
    },
    {
      'image': 'assets/pinterest4.jpg',
      'title': 'Hidden Key',
      'difficulty': '7/10 (IQ 130+)',
      'reward': '\$90 USD',
      'locked': true,
      'isDemo': false,
    },
    {
      'image': 'assets/pinterest5.jpg',
      'title': 'IQ Door',
      'difficulty': '8/10 (IQ 135+)',
      'reward': '\$100 USD',
      'locked': true,
      'isDemo': false,
    },
    {
      'image': 'assets/pinterest6.jpg',
      'title': 'The Puzzle',
      'difficulty': '9/10 (IQ 140+)',
      'reward': '\$120 USD',
      'locked': true,
      'isDemo': false,
    },
    {
      'image': 'assets/pinterest7.jpg',
      'title': 'Final Switch',
      'difficulty': '10/10 (IQ 145+)',
      'reward': '\$200 USD',
      'locked': true,
      'isDemo': false,
    },
    {
      'image': 'assets/pinterest8.jpg',
      'title': 'Number Maze',
      'difficulty': '4/10 (IQ 115+)',
      'reward': '\$50 USD',
      'locked': true,
      'isDemo': false,
    },
    {
      'image': 'assets/pinterest9.jpg',
      'title': 'The Match',
      'difficulty': '5/10 (IQ 120+)',
      'reward': '\$60 USD',
      'locked': true,
      'isDemo': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildNavPill('Home', 0),
            const SizedBox(width: 12),
            _buildNavPill('Board', 1),
            const SizedBox(width: 12),
            _buildNavPill('Wallet', 2),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: _currentPageIndex,
              children: [
                _buildHomePage(),
                _buildBoardPage(),
                _buildWalletPage(),
              ],
            ),
          ),
          if (_currentPageIndex == 0) _buildParticipantsCounter(),
        ],
      ),
    );
  }

  Widget _buildNavPill(String title, int index) {
    return GestureDetector(
      onTap: () => setState(() => _currentPageIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: _currentPageIndex == index ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 11, // Reduced from 12
            fontWeight: FontWeight.w500,
            color: _currentPageIndex == index ? Colors.white : Colors.grey[600],
          ),
        ),
      ),
    );
  }

  Widget _buildHomePage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Text(
            'Challenges', // Changed from 'Available Challenges'
            style: TextStyle(
              fontSize: 18, // Reduced from 20
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.7,
            ),
            itemCount: challenges.length,
            itemBuilder: (context, index) {
              final challenge = challenges[index];
              return _buildChallengeCard(challenge);
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildChallengeCard(Map<String, dynamic> challenge) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.all(0),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              challenge['image'],
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (challenge['isDemo'])
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'Demo Challenge',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  const SizedBox(height: 8),
                  Text(
                    challenge['title'],
                    style: const TextStyle(
                      fontSize: 15, // Reduced from 16
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            challenge['difficulty'],
                            style: const TextStyle(
                              fontSize: 11, // Reduced from 12
                              color: Colors.white70,
                            ),
                          ),
                          Text(
                            challenge['reward'],
                            style: const TextStyle(
                              fontSize: 11, // Reduced from 12
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      challenge['locked']
                          ? const Icon(
                              Icons.lock,
                              color: Colors.white,
                              size: 18, // Reduced from 20
                            )
                          : GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ChallengeScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  'Start',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParticipantsCounter() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Text(
        '100K+ Particpants Joined',
        style: TextStyle(
          fontSize: 13, // Reduced from 14
          color: Colors.grey[700],
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildBoardPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        children: [
          _buildStatRow('Total Participants', '1000,000'),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Divider(height: 24),
          ),
          _buildStatRow('Completed', '0'),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Divider(height: 24),
          ),
          _buildStatRow('Eliminated', '0'),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Divider(height: 24),
          ),
          _buildStatRow('Retries', '0'),
        ],
      ),
    );
  }

  Widget _buildWalletPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Reward so far',
                      style: TextStyle(
                        fontSize: 11, // Reduced from 12
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      '\$0',
                      style: const TextStyle(
                        fontSize: 12, // Reduced from 13
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Level',
                      style: TextStyle(
                        fontSize: 11, // Reduced from 12
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      '0/20',
                      style: const TextStyle(
                        fontSize: 12, // Reduced from 13
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Reward History',
            style: TextStyle(
              fontSize: 12, // Reduced from 13
              fontWeight: FontWeight.w600,
              color: Colors.grey[900],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildHistoryItem('No rewards yet', '+ \$0', '--'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Withdraw to PayPal',
                style: TextStyle(
                  fontSize: 12, // Reduced from 13
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11, // Reduced from 12
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 11, // Reduced from 12
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(String title, String amount, String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 11, // Reduced from 12
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 2),
              Text(
                date,
                style: TextStyle(
                  fontSize: 9, // Reduced from 10
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 11, // Reduced from 12
              fontWeight: FontWeight.w600,
              color: Colors.green[600],
            ),
          ),
        ],
      ),
    );
  }
}