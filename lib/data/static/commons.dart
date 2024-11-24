// common_data.dart

class CommonData {
  static Map<String, String> _localeMap = {
    'English': 'en-US',
    'Hindi': 'hi-IN',
    'Japanese': 'ja-JP',
    'Korean': 'ko-KR',
    'Chinese': 'zh-CN',
    'German': 'de-DE',
    'Spanish': 'es-ES',
    'Italian': 'it-IT',
    'Kannada': 'kn-IN',
    'Gujarati': 'gu-IN',
    'Bahasa Indonesia': 'id-ID',
    'Arabic': 'ar-SA',
    'French': 'fr-FR',
  };

  static List<String> _locale = [
    'English',
    'Hindi',
    'Japanese',
    'Korean',
    'Chinese',
    'German',
    'Spanish',
    'Italian',
    'Kannada',
    'Gujarati',
    'Bahasa Indonesia',
    'Arabic',
    'French',
  ];

  static Map<String, String> get localeMap => _localeMap;
  static List<String> get locale => _locale;
}
