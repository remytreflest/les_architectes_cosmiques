import 'package:shared_preferences/shared_preferences.dart';

class OnboardingUtils {
  static const String _onboardingKey = 'onboarding_completed';

  /// Vérifie si l'onboarding a été complété
  static Future<bool> hasCompletedOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingKey) ?? false;
  }

  /// Marque l'onboarding comme complété
  static Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, true);
  }

  /// Réinitialise l'onboarding (pour les tests)
  static Future<void> resetOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_onboardingKey);
  }
}
