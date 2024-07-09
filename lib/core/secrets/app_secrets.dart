class AppSecrets {
  static const baseUrl = 'http://192.168.18.127:3000'; // RD Home
  //static const baseUrl = 'http://192.168.95.156:3000'; // RD Office

  // Auth
  static const String loginUrl = "$baseUrl/api/auth/login";
  static const String registerUrl = "$baseUrl/api/auth/register";
  static const String googleSignInUrl = "$baseUrl/api/auth/google";

  // Tokens
  static const String refreshTokenUrl = "$baseUrl/api/tokens/refresh";

  // Users
  static const String meUrl = "$baseUrl/api/users/me";

  // Pets
  static const String petsUrl = "$baseUrl/api/pets";
  static const String petUrl = "$baseUrl/api/pets/:id";
}
