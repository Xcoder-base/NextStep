import 'package:flutter/material.dart';
import 'challenge_screen.dart';
import 'squad_screen.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final challenges = [
      {
        'image': 'assets/peopleonphone.jpg',
        'title': 'Squad Invite',
        'unlocks': 'Starter',
        'locked': false, // First challenge unlocked
      },
      {
        'image': 'assets/salesman.jpeg',
        'title': 'The Lock',
        'unlocks': '3.2M unlocks',
        'locked': true,
      },
      {
        'image': 'assets/pinterest1.jpg',
        'title': 'Smart Path',
        'unlocks': '2.8M unlocks',
        'locked': true,
      },
      {
        'image': 'assets/pinterest2.jpg',
        'title': 'The Code',
        'unlocks': '1.9M unlocks',
        'locked': true,
      },
      {
        'image': 'assets/pinterest3.jpg',
        'title': 'Brain Box',
        'unlocks': '1.5M unlocks',
        'locked': true,
      },
      {
        'image': 'assets/pinterest4.jpg',
        'title': 'Hidden Key',
        'unlocks': '932K unlocks',
        'locked': true,
      },
      {
        'image': 'assets/pinterest5.jpg',
        'title': 'IQ Door',
        'unlocks': '745K unlocks',
        'locked': true,
      },
      {
        'image': 'assets/pinterest6.jpg',
        'title': 'The Puzzle',
        'unlocks': '432K unlocks',
        'locked': true,
      },
      {
        'image': 'assets/pinterest7.jpg',
        'title': 'Final Switch',
        'unlocks': '128K unlocks',
        'locked': true,
      },
      {
        'image': 'assets/pinterest8.jpg',
        'title': 'Number Maze',
        'unlocks': '2.1M unlocks',
        'locked': true,
      },
      {
        'image': 'assets/pinterest9.jpg',
        'title': 'The Match',
        'unlocks': '1.7M unlocks',
        'locked': true,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'NextStep',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SquadScreen()),
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.group,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
                const Text(
                  'Squad',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 8), // Reduced spacing
            const Text(
              'Unlock all Challenges. Get rewarded \$500',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.7,
              ),
              itemCount: challenges.length,
              itemBuilder: (context, index) => ChallengeCard(challenge: challenges[index]),
            ),
          ],
        ),
      ),
    );
  }
}

class ChallengeCard extends StatelessWidget {
  final Map<String, dynamic> challenge;
  const ChallengeCard({super.key, required this.challenge});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          if (!challenge['locked']) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ChallengeScreen(),
              ),
            );
          }
        },
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                challenge['image'],
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
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
                    Text(
                      challenge['title'],
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          challenge['unlocks'],
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                        challenge['locked']
                            ? const Icon(
                                Icons.lock,
                                color: Colors.white,
                                size: 14,
                              )
                            : Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  'PLAY',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
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
      ),
    );
  }
}