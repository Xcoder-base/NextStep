import 'dart:async';
import 'package:flutter/material.dart';
import 'level_one_screen.dart';

class EliminatedScreen extends StatefulWidget {
  const EliminatedScreen({super.key});

  @override
  _EliminatedScreenState createState() => _EliminatedScreenState();
}

class _EliminatedScreenState extends State<EliminatedScreen> {
  int _retryCountdown = 1800; // 30 minutes in seconds
  late Timer _timer;
  bool _canRetry = true;

  @override
  void initState() {
    super.initState();
    _startRetryCountdown();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startRetryCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_retryCountdown > 0) {
        setState(() {
          _retryCountdown--;
        });
      } else {
        setState(() {
          _canRetry = false;
        });
        _timer.cancel();
      }
    });
  }

  String _formatCountdown(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/eliminated.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/sademoji.png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 16),
                const Text(
                  'You have failed the Challenge',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _canRetry 
                      ? 'Retry available for ${_formatCountdown(_retryCountdown)}'
                      : 'Retry period expired',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: _canRetry
                    ? () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const LevelOneScreen()),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _canRetry ? Colors.red : Colors.grey[600],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  _canRetry ? 'RETRY FOR FREE' : 'RETRY EXPIRED',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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