class ApiRoutes {
  ApiRoutes._();
  static const String basePath =
      "https://roaster-server-production.up.railway.app/api/";
  // static const String basePath = "http://192.168.1.44:5000/api/";

  // login
  static const String loginSendOtp = '${basePath}users/login-otp';
  static const String login = '${basePath}users/login-verify-otp';
  static const String getUser = '${basePath}users/me';

  // Register steps
  static const String registerSendOtp = '${basePath}users/register-otp';
  static const String registerVerifyOtp =
      '${basePath}users/register-verify-otp';
  static const String updateProfile = '${basePath}users/update';
  static const String uploadImges = '${basePath}users/upload-images';

  static const String getAllUsers = '${basePath}users/all-users';

  // Chat
  static const String getConvo = '${basePath}chat/get-my-convo';
  static const String getChatList = '${basePath}chat/get-chat-list';
  static const String sendMessage = '${basePath}chat/send';
}
