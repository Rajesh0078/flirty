class ApiRoutes {
  ApiRoutes._();
  static const String basePath =
      "https://roaster-server-production.up.railway.app/api/";
  // static const String basePath = "http://192.168.1.44:5000/api/";

  // login
  static const String loginSendOtp = '${basePath}users/login-otp';
  static const String login = '${basePath}users/login';
  static const String getUser = '${basePath}users/me';

  // Register steps
  static const String registerSendOtp = '${basePath}users/register-otp';
  static const String registerVerifyOtp = '${basePath}users/verify-otp';
  static const String updateProfile = '${basePath}users/update';
  static const String uploadImges = '${basePath}users/upload-images';
}
