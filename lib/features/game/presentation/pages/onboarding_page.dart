import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPage extends StatefulWidget {
  final VoidCallback onComplete;

  const OnboardingPage({Key? key, required this.onComplete}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingSlide> _slides = [
    OnboardingSlide(
      icon: '🚀',
      title: 'Bienvenue, Commandant !',
      description:
          'Préparez-vous à conquérir le système solaire et à bâtir votre empire galactique.',
      color: Colors.deepPurple,
    ),
    OnboardingSlide(
      icon: '🪐',
      title: 'Colonisez les Planètes',
      description:
          'Explorez et colonisez les 8 planètes du système solaire. Gérez plusieurs colonies simultanément !',
      features: [
        '🌍 Gestion Multi-Planètes',
        '⚡ Production Automatique',
        '📊 Ressources en temps réel',
      ],
      color: Colors.blue,
    ),
    OnboardingSlide(
      icon: '🏭',
      title: 'Construisez des Bâtiments',
      description:
          'Développez votre infrastructure pour produire des ressources.',
      features: [
        '⛏️ Mines (Métal, Cristal, Deutérium)',
        '☀️ Centrale Solaire (Énergie)',
        '🤖 Usine de Robots (Construction)',
      ],
      color: Colors.orange,
    ),
    OnboardingSlide(
      icon: '🔬',
      title: 'Recherchez des Technologies',
      description: 'Débloquez 9 technologies pour améliorer votre empire.',
      features: [
        '🔫 Laser, Plasma, Hyperespace',
        '📈 Améliorations progressives',
        '🚀 Nouvelles capacités',
      ],
      color: Colors.cyan,
    ),
    OnboardingSlide(
      icon: '🎭',
      title: 'Adoptez des Politiques',
      description: 'Choisissez parmi 8 politiques galactiques humoristiques !',
      features: [
        '☭ Communisme Spatial',
        '💰 Capitalisme Galactique',
        '🥖 Révolution Française',
        '🍕 Pizza Party Universelle',
      ],
      color: Colors.pink,
    ),
    OnboardingSlide(
      icon: '📱',
      title: 'Secouez pour Gagner !',
      description:
          'Utilisez le gyroscope de votre téléphone pour obtenir des ressources bonus.',
      features: ['✨ Bonus surprises', '🎮 Mini-jeu interactif'],
      color: Colors.amber,
      isShaking: true,
    ),
    OnboardingSlide(
      icon: '🎮',
      title: 'Prêt à Conquérir ?',
      description: 'Votre aventure commence maintenant !',
      features: [
        '💾 Sauvegarde Automatique',
        '⏱️ Production en Temps Réel',
        '🌌 Univers Immersif',
      ],
      color: Colors.deepPurple,
      isLast: true,
    ),
  ];

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
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);
    widget.onComplete();
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
              print('🌍 [DEBUG] _completeOnboarding');
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
              // Skip button
              Align(
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
              ),

              // PageView
              Expanded(
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
              ),

              // Progress dots
              Padding(
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
                        color: _currentPage == index
                            ? Colors.cyanAccent
                            : Colors.white30,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),

              // Navigation buttons
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Previous button
                    if (_currentPage > 0)
                      ElevatedButton(
                        onPressed: _previousPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white12,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.arrow_back, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              'Précédent',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      )
                    else
                      const SizedBox(),

                    // Next button
                    ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            _currentPage == _slides.length - 1
                                ? 'Commencer'
                                : 'Suivant',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            _currentPage == _slides.length - 1
                                ? Icons.rocket_launch
                                : Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingSlide {
  final String icon;
  final String title;
  final String description;
  final List<String>? features;
  final Color color;
  final bool isShaking;
  final bool isLast;

  OnboardingSlide({
    required this.icon,
    required this.title,
    required this.description,
    this.features,
    required this.color,
    this.isShaking = false,
    this.isLast = false,
  });
}

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
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                    style: const TextStyle(fontSize: 100),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 40),

          // Title
          Text(
            widget.slide.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: widget.slide.color,
            ),
          ),
          const SizedBox(height: 20),

          // Description
          Text(
            widget.slide.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white70,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 30),

          // Features list
          if (widget.slide.features != null) ...[
            ...widget.slide.features!.map(
              (feature) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  padding: const EdgeInsets.all(16),
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
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
