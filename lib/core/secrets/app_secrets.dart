class AppSecrets {
  //static const baseUrl = 'http://192.168.18.127:3000/api'; // RD Home
  static const baseUrl = 'http://192.168.95.156:3000/api'; // RD Office

  // Auth
  static const String loginUrl = "$baseUrl/auth/login";
  static const String registerUrl = "$baseUrl/auth/register";
  static const String googleSignInUrl = "$baseUrl/auth/google";

  // Tokens
  static const String refreshTokenUrl = "$baseUrl/tokens/refresh";

  // Users
  static const String meUrl = "$baseUrl/users/me";
}
