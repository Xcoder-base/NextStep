import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'eliminated_screen.dart';
import 'demo_congrats_screen.dart';

class LevelOneScreen extends StatefulWidget {
  const LevelOneScreen({super.key});

  @override
  State<LevelOneScreen> createState() => _LevelOneScreenState();
}

class _LevelOneScreenState extends State<LevelOneScreen> {
  final Random _random = Random();
  final List<List<int>> _numberColumns = [
    [96, 121, 69, 79, 104, 37, 54, 11, 95, 34, 27, 73],
    [28, 118, 23, 60, 53, 20, 159, 19, 42, 64, 20, 182],
    [41, 59, 44, 88, 20, 85, 23, 95, 139, 143, 139, 66],
    [73, 92, 88, 36, 216, 80, 25, 60, 147, 198, 158, 88],
    [30, 87, 140, 455, 46, 40, 4, 147, 15, 40, 1, 98],
    [208, 163, 91, 2, 64, 76, 11, 264, 8, 77, 184, 160],
    [17, 2, 83, 9, 33, 6, 190, 4, 5, 38, 155, 4],
    [51, 17, 18, 10, 6, 55, 97, 69, 259, 157, 6, 90],
    [239, 90, 70, 26, 29, 78, 73, 56, 7, 69, 123, 56],
    [78, 56, 74, 21, 141, 153, 2, 57, 25, 9, 24, 47],
    [12, 31, 9, 3, 146, 39, 153, 55, 103, 43, 13, 3],
    [3, 40, 167, 87, 18, 207, 85, 39, 31, 4, 26, 9]
  ];

  int _currentColumnIndex = 0;
  int _collectedPoints = 0;
  int _timeLeft = 180;
  int? _selectedNumber;
  late Timer _gameTimer;
  bool _isGameOver = false;
  List<int> _currentNumbers = [];
  List<int> _randomPositions = [];

  @override
  void initState() {
    super.initState();
    _initializeColumn();
    _startGame();
  }

  @override
  void dispose() {
    _gameTimer.cancel();
    super.dispose();
  }

  void _initializeColumn() {
    _currentNumbers = List.from(_numberColumns[_currentColumnIndex]);
    _randomPositions = List.generate(12, (index) => index)..shuffle(_random);
  }

  void _startGame() {
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() => _timeLeft--);
      } else {
        _endGame(false);
      }
    });
  }

  void _endGame(bool isSuccess) {
    _gameTimer.cancel();
    setState(() => _isGameOver = true);
    
    Future.delayed(const Duration(seconds: 1), () {
      if (isSuccess) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DemoCongratsScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const EliminatedScreen()),
        );
      }
    });
  }

  void _onNumberSelected(int number) {
    if (_isGameOver || _selectedNumber != null) return;

    setState(() {
      _selectedNumber = number;
      _collectedPoints += number;
    });

    if (_currentColumnIndex == _numberColumns.length - 1) {
      if (_collectedPoints == 876) {
        _endGame(true);
      } else {
        _endGame(false);
      }
    } else {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            _currentColumnIndex++;
            _selectedNumber = null;
            _initializeColumn();
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final boxSize = screenSize.width * 0.15; // Smaller box size

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Ultra-minimalist status bar
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStatusPanel('POINTS', '$_collectedPoints/876', 
                    Colors.white.withOpacity(0.9)),
                const SizedBox(width: 24),
                _buildStatusPanel('TIME', '$_timeLeft', 
                    Colors.white.withOpacity(0.9)),
              ],
            ),
          ),

          // Centered number grid with elegant spacing
          Center(
            child: Wrap(
              spacing: 12, // Horizontal space between boxes
              runSpacing: 12, // Vertical space between boxes
              alignment: WrapAlignment.center,
              children: List.generate(12, (index) {
                final number = _currentNumbers[_randomPositions[index]];
                final isSelected = _selectedNumber == number;

                return GestureDetector(
                  onTap: () => _onNumberSelected(number),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: boxSize,
                    height: boxSize,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white.withOpacity(0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected
                            ? Colors.white
                            : Colors.white.withOpacity(0.2),
                        width: isSelected ? 1.5 : 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '+$number',
                        style: TextStyle(
                          fontSize: 14, // Slightly larger for readability
                          fontWeight: FontWeight.w500,
                          color: isSelected 
                              ? Colors.white 
                              : Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          // Minimal progress indicator
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  '${_currentColumnIndex + 1}/${_numberColumns.length}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusPanel(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: color.withOpacity(0.7),
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: color,
            letterSpacing: 1.1,
          ),
        ),
      ],
    );
  }
}