import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:money_tracker/core/routes/routers.dart';

class SuccessScreen extends StatefulWidget {
  final Duration delay;

  const SuccessScreen({super.key, this.delay = const Duration(seconds: 3)});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen>
    with TickerProviderStateMixin {
  late AnimationController _iconController;
  late AnimationController _textController;
  late AnimationController _fadeOutController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeTextAnimation;
  late Animation<double> _fadeOutAnimation;

  @override
  void initState() {
    super.initState();

    _iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _scaleAnimation = TweenSequence([
      TweenSequenceItem(
        tween: Tween(
          begin: 0.0,
          end: 1.2,
        ).chain(CurveTween(curve: Curves.easeOutBack)),
        weight: 70,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.2,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 30,
      ),
    ]).animate(_iconController);

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeTextAnimation = CurvedAnimation(
      parent: _textController,
      curve: Curves.easeIn,
    );

    _fadeOutController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeOutAnimation = CurvedAnimation(
      parent: _fadeOutController,
      curve: Curves.easeOut,
    );

    _iconController.forward().then((_) {
      if (mounted) _textController.forward();
    });

    Timer(widget.delay - const Duration(milliseconds: 500), () async {
      if (mounted) {
        await _fadeOutController.forward();
        if (mounted) {
          GoRouter.of(context).go(AppRoutes.homeScreen);
        }
      }
    });
  }

  @override
  void dispose() {
    _iconController.dispose();
    _textController.dispose();
    _fadeOutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: FadeTransition(
        opacity: ReverseAnimation(_fadeOutAnimation),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(28),
                  child: const Icon(Icons.check, color: Colors.green, size: 70),
                ),
              ),
              const SizedBox(height: 20),
              FadeTransition(
                opacity: _fadeTextAnimation,
                child: const Text(
                  "You're all set!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
