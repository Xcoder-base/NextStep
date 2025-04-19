import 'package:flutter/material.dart';

class BoardScreen extends StatelessWidget {
  const BoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final unlockHistory = [
      {'user': 'alex@gmail.com', 'challenge': 'Smart Path', 'time': '2 min ago'},
      {'user': 'taylor@yahoo.com', 'challenge': 'The Code', 'time': '7 min ago'},
      {'user': 'jordan@outlook.com', 'challenge': 'Brain Box', 'time': '15 min ago'},
      {'user': 'casey@protonmail.com', 'challenge': 'IQ Door', 'time': '22 min ago'},
      {'user': 'riley@icloud.com', 'challenge': 'Final Switch', 'time': '31 min ago'},
      {'user': 'morgan@gmail.com', 'challenge': 'Number Maze', 'time': '47 min ago'},
      {'user': 'skyler@yahoo.com', 'challenge': 'The Match', 'time': '1 hr ago'},
      {'user': 'dakota@outlook.com', 'challenge': 'Hidden Key', 'time': '1 hr ago'},
      {'user': 'quinn@gmail.com', 'challenge': 'The Lock', 'time': '2 hrs ago'},
      {'user': 'avery@hotmail.com', 'challenge': 'Logic Gate', 'time': '3 hrs ago'},
      {'user': 'peyton@gmail.com', 'challenge': 'Memory Lane', 'time': '4 hrs ago'},
      {'user': 'blake@yahoo.com', 'challenge': 'Pattern Finder', 'time': '5 hrs ago'},
      {'user': 'cameron@outlook.com', 'challenge': 'Word Puzzle', 'time': '6 hrs ago'},
      {'user': 'hayden@protonmail.com', 'challenge': 'Math Riddle', 'time': '7 hrs ago'},
      {'user': 'reese@icloud.com', 'challenge': 'Color Mix', 'time': '8 hrs ago'},
      {'user': 'jamie@gmail.com', 'challenge': 'Sequence Break', 'time': '9 hrs ago'},
      {'user': 'kendall@yahoo.com', 'challenge': 'The Vault', 'time': '10 hrs ago'},
      {'user': 'rowan@outlook.com', 'challenge': 'Pixel Path', 'time': '11 hrs ago'},
      {'user': 'sage@gmail.com', 'challenge': 'Sound Puzzle', 'time': '12 hrs ago'},
      {'user': 'elliott@yahoo.com', 'challenge': 'Final Door', 'time': '13 hrs ago'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recent Unlocks',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Activity Feed Header
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                'RECENT UNLOCKS',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                  letterSpacing: 1.1,
                ),
              ),
            ),
            
            // Activity Feed Box
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12, width: 0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.separated(
                  itemCount: unlockHistory.length,
                  separatorBuilder: (context, index) => const Divider(height: 16, thickness: 0.5),
                  itemBuilder: (context, index) {
                    final entry = unlockHistory[index];
                    return _buildActivityItem(
                      entry['user']!,
                      entry['challenge']!,
                      entry['time']!,
                      _getUserColor(entry['user']!),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getUserColor(String email) {
    final colors = [
      Colors.blue[400]!,
      Colors.purple[400]!,
      Colors.orange[400]!,
      Colors.green[400]!,
      Colors.red[400]!,
      Colors.teal[400]!,
      Colors.indigo[400]!,
    ];
    return colors[email.hashCode % colors.length];
  }

  Widget _buildActivityItem(String user, String challenge, String time, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          alignment: Alignment.center,
          child: Text(
            user.substring(0, 1).toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 9,
                    color: Colors.black54,
                  ),
                  children: [
                    const TextSpan(text: 'Unlocked '),
                    TextSpan(
                      text: challenge,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    TextSpan(text: ' • $time'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}