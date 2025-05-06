class ApiConstants {
  // **** Olds endpoints ****
  //static const String baseUrl = 'https://www.signclock.com/vfttapi/';
  // static const String login = '$baseUrl/postphonenum_v2.php';
  // static const String otp = '$baseUrl/postphonenum_v2.php';

  // **** New endpoints ****
  // static const String baseUrl = 'https://ls.signclock.com/api';
  static const String baseUrl = 'http://192.168.1.141:8000/api';
  // static const String baseUrl = 'https://172.28.97.8/api';
  static const String login = '$baseUrl/authenticate';
  static const String otp = '$baseUrl/otp';

  // sign
  static const String sign = '$baseUrl/sign';

  // listing regs
  static const String signList = '$baseUrl/signList';

  // chat
  static const String chat = '$baseUrl/chat';
  static const String message = '$baseUrl/message';

  // Settings
  static const String statusInfo = '$baseUrl/statusInfo';
  static const String getGroups = '$baseUrl/getGroups';
  static const String updateGroup = '$baseUrl/updateGroup';
  static const String setGeoFence = '$baseUrl/setGeoFence';
}
