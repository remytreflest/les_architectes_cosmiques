import 'package:flutter/material.dart';

import '../../data/models/onboarding_slide_model.dart';

class OnboardingSlideWidget extends StatefulWidget {
  final OnboardingSlide slide;

  const OnboardingSlideWidget({Key? key, required this.slide})
    : super(key: key);

  @override
  State<OnboardingSlideWidget> createState() => _OnboardingSlideWidgetState();
}

class _OnboardingSlideWidgetState extends State<OnboardingSlideWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _floatAnimation;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(
      begin: -10,
      end: 10,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _shakeAnimation = Tween<double>(
      begin: -0.05,
      end: 0.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenHeight < 700;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: isSmallScreen ? 20 : screenHeight * 0.05),

          // Animated icon
          AnimatedBuilder(
            animation: widget.slide.isShaking
                ? _shakeAnimation
                : _floatAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: widget.slide.isShaking
                    ? Offset.zero
                    : Offset(0, _floatAnimation.value),
                child: Transform.rotate(
                  angle: widget.slide.isShaking ? _shakeAnimation.value : 0,
                  child: Text(
                    widget.slide.icon,
                    style: TextStyle(fontSize: isSmallScreen ? 80 : 100),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: isSmallScreen ? 30 : 40),

          // Title
          Text(
            widget.slide.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isSmallScreen ? 24 : 28,
              fontWeight: FontWeight.bold,
              color: widget.slide.color,
            ),
          ),
          SizedBox(height: isSmallScreen ? 15 : 20),

          // Description
          Text(
            widget.slide.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isSmallScreen ? 16 : 18,
              color: Colors.white70,
              height: 1.5,
            ),
          ),
          SizedBox(height: isSmallScreen ? 20 : 30),

          // Features list
          if (widget.slide.features != null) ...[
            ...widget.slide.features!.map(
              (feature) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(color: widget.slide.color, width: 4),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          feature,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isSmallScreen ? 14 : 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],

          SizedBox(height: isSmallScreen ? 20 : screenHeight * 0.05),
        ],
      ),
    );
  }
}
