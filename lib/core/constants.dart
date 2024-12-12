class AppConstants {
  // App Configuration
  static const String appName = 'Powered City Guide';
  
  // API and Network Constants
  static const String baseApiUrl = 'https://api.poweredcityguide.com';
  
  // Local Storage Keys
  static const String userPreferencesKey = 'user_preferences';
  
  // Default Values
  static const int defaultRadius = 5; // kilometers
  static const int maxRecommendations = 10;
  
  // Feature Flags
  static const bool enableLocationServices = true;
  static const bool enableSmartRecommendations = true;
  
  // Routing
  static const Duration pageTransitionDuration = Duration(milliseconds: 300);
}
