import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LevelOneScreen extends StatefulWidget {
  const LevelOneScreen({super.key});

  @override
  State<LevelOneScreen> createState() => _LevelOneScreenState();
}

class _LevelOneScreenState extends State<LevelOneScreen> {
  late Timer _countdownTimer;
  Duration _timeLeft = const Duration(hours: 24);
  int _membersJoined = 0;
  final String _inviteLink = "https://squadapp.com/invite/xYz123AbCd";
  bool _isLinkCopied = false;

  @override
  void initState() {
    super.initState();
    _startCountdown();
    // Simulate members joining randomly
    Timer.periodic(const Duration(seconds: 10), (timer) {
      if (_membersJoined < 10) {
        setState(() => _membersJoined++);
      }
    });
  }

  @override
  void dispose() {
    _countdownTimer.cancel();
    super.dispose();
  }

  void _startCountdown() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft.inSeconds > 0) {
        setState(() {
          _timeLeft = _timeLeft - const Duration(seconds: 1);
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _inviteLink));
    setState(() => _isLinkCopied = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _isLinkCopied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Squad Invite Challenge',
          style: TextStyle(fontSize: 16),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Countdown Timer
          Text(
            'Time Remaining: ${_timeLeft.inHours.toString().padLeft(2, '0')}:${(_timeLeft.inMinutes % 60).toString().padLeft(2, '0')}:${(_timeLeft.inSeconds % 60).toString().padLeft(2, '0')}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 40),
          
          // Members Joined Circle
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.green,
                width: 4,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$_membersJoined/10',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  'Members Joined',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          
          // Invite Link Section
          const Text(
            'Your Squad Invite Link:',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _inviteLink,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    _isLinkCopied ? Icons.check : Icons.copy,
                    size: 20,
                    color: _isLinkCopied ? Colors.green : Colors.black54,
                  ),
                  onPressed: _copyToClipboard,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            _isLinkCopied ? 'Link copied!' : 'Tap to copy invite link',
            style: TextStyle(
              fontSize: 12,
              color: _isLinkCopied ? Colors.green : Colors.grey,
            ),
          ),
          const SizedBox(height: 40),
          
          // Progress Text
          Text(
            'Get ${10 - _membersJoined} more people to join in next ${_timeLeft.inHours}h ${_timeLeft.inMinutes % 60}m to unlock reward',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}