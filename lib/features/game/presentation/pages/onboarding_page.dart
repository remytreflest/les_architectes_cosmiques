import 'package:flutter/material.dart';

import '../../../../core/constants/onboarding_slide_data.dart';
import '../../../../core/utils/onboarding_utils.dart';
import '../../data/models/onboarding_slide_model.dart';
import '../widgets/onboarding_slide.dart';

/// Écran d'onboarding simple qui s'affiche uniquement au premier lancement
/// Navigation : OnboardingScreen → PlayerNameScreen → Jeu
class OnboardingScreen extends StatefulWidget {
  /// Page suivante (typiquement PlayerNameScreen)
  final Widget nextPage;

  const OnboardingScreen({Key? key, required this.nextPage}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late final List<OnboardingSlide> _slides;

  @override
  void initState() {
    super.initState();
    _slides = OnboardingSlidesData.getSlides();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _completeOnboarding() async {
    await OnboardingUtils.completeOnboarding();

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => widget.nextPage),
      );
    }
  }

  void _skipOnboarding() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text(
          'Passer l\'introduction ?',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Voulez-vous vraiment passer l\'introduction ?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Non'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _completeOnboarding();
            },
            child: const Text('Oui, passer'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF0a0e27),
              const Color(0xFF1a1f3a),
              const Color(0xFF2a1b3d),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildSkipButton(),
              _buildPageView(),
              _buildProgressDots(),
              _buildNavigationButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkipButton() {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextButton(
          onPressed: _skipOnboarding,
          child: const Text(
            'Passer',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildPageView() {
    return Expanded(
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemCount: _slides.length,
        itemBuilder: (context, index) {
          return OnboardingSlideWidget(slide: _slides[index]);
        },
      ),
    );
  }

  Widget _buildProgressDots() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          _slides.length,
          (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            height: 8,
            width: _currentPage == index ? 24 : 8,
            decoration: BoxDecoration(
              color: _currentPage == index ? Colors.cyanAccent : Colors.white30,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_buildPreviousButton(), _buildNextButton()],
      ),
    );
  }

  Widget _buildPreviousButton() {
    if (_currentPage == 0) {
      return const SizedBox();
    }

    return ElevatedButton(
      onPressed: _previousPage,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white12,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: const Row(
        children: [
          Icon(Icons.arrow_back, color: Colors.white),
          SizedBox(width: 8),
          Text('Précédent', style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildNextButton() {
    final isLastPage = _currentPage == _slides.length - 1;

    return ElevatedButton(
      onPressed: _nextPage,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: Row(
        children: [
          Text(
            isLastPage ? 'Commencer' : 'Suivant',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            isLastPage ? Icons.rocket_launch : Icons.arrow_forward,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
