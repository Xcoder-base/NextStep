import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/scheduler.dart';
import 'dart:math'; // Add this import for Random and math functions
import 'home_screen.dart';

class DemoCongratsScreen extends StatefulWidget {
  const DemoCongratsScreen({super.key});

  @override
  State<DemoCongratsScreen> createState() => _DemoCongratsScreenState();
}

class _DemoCongratsScreenState extends State<DemoCongratsScreen> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  final List<Particle> _particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _scaleAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.9, end: 1.1), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.1, end: 0.9), weight: 50),
    ]).animate(_controller);

    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.8, curve: Curves.easeInOut),
      ),
    );

    // Initialize particles
    for (int i = 0; i < 50; i++) {
      _particles.add(Particle(_random));
    }

    // Start particle animation loop
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _startParticleAnimation();
    });
  }

  void _startParticleAnimation() {
    _controller.addListener(() {
      setState(() {
        for (var particle in _particles) {
          particle.update(_random);
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Animated particles background
          for (var particle in _particles)
            Positioned(
              left: particle.x * size.width,
              top: particle.y * size.height,
              child: Transform.rotate(
                angle: particle.rotation,
                child: Opacity(
                  opacity: particle.opacity,
                  child: Icon(
                    _getParticleIcon(particle.type),
                    size: particle.size,
                    color: _getParticleColor(particle.type),
                  ),
                ),
              ),
            ),

          // Main content
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Opacity(
                    opacity: _opacityAnimation.value,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Premium badge with shine effect
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                Colors.amber.withOpacity(0.8),
                                Colors.amberAccent.withOpacity(0.3),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.amber.withOpacity(0.4),
                                blurRadius: 30,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.workspace_premium,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Glowing title
                        ShaderMask(
                          shaderCallback: (bounds) {
                            return const LinearGradient(
                              colors: [
                                Colors.amber,
                                Colors.amberAccent,
                                Colors.white,
                              ],
                            ).createShader(bounds);
                          },
                          child: const Text(
                            'Genius level thinking',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 2.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Animated reward card
                        Container(
                          width: size.width * 0.7,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.grey[850]!,
                                Colors.grey[900]!,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.amber.withOpacity(0.3),
                                blurRadius: 20,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'You\'ve demonstrated supreme intellect',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.account_balance_wallet,
                                    color: Colors.amber,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    '\$20.00 USD',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      foreground: Paint()
                                        ..shader = const LinearGradient(
                                          colors: [
                                            Colors.amber,
                                            Colors.amberAccent,
                                          ],
                                        ).createShader(
                                          const Rect.fromLTWH(0, 0, 150, 20),
                                        ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Premium action button
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 15,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: const BorderSide(
                                color: Colors.amber,
                                width: 2,
                              ),
                            ),
                            elevation: 0,
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'CLAIM YOUR REWARD',
                                style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              SizedBox(width: 10),
                              Icon(Icons.arrow_forward, size: 18),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  IconData _getParticleIcon(int type) {
    switch (type % 4) {
      case 0: return Icons.star;
      case 1: return Icons.hexagon;
      case 2: return Icons.circle;
      default: return Icons.diamond;
    }
  }

  Color _getParticleColor(int type) {
    switch (type % 5) {
      case 0: return Colors.amber.withOpacity(0.7);
      case 1: return Colors.amberAccent.withOpacity(0.6);
      case 2: return Colors.white.withOpacity(0.5);
      case 3: return Colors.orange.withOpacity(0.4);
      default: return Colors.yellow.withOpacity(0.3);
    }
  }
}

class Particle {
  double x, y;
  double size;
  double speed;
  double angle;
  double rotation;
  double opacity;
  int type;

  Particle(Random random) : 
    x = random.nextDouble(),
    y = random.nextDouble(),
    size = random.nextDouble() * 8 + 4,
    speed = random.nextDouble() * 0.002 + 0.001,
    angle = random.nextDouble() * 2 * pi,
    rotation = random.nextDouble() * 2 * pi,
    opacity = random.nextDouble() * 0.5 + 0.1,
    type = random.nextInt(5);

  void update(Random random) {
    x += cos(angle) * speed;
    y += sin(angle) * speed;
    rotation += 0.01;
    
    // Reset particles that go off screen
    if (x < 0 || x > 1 || y < 0 || y > 1) {
      x = random.nextDouble();
      y = random.nextDouble();
      angle = random.nextDouble() * 2 * pi;
    }
  }
}