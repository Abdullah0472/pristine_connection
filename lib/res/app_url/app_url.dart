

class AppUrl {
  static const String baseUrl = 'http://209.126.10.15' ;
  static const String signUpApi = '$baseUrl/api/signup' ;
  static const String loginApi = '$baseUrl/api/login' ;
  static const String userProfileApi = '$baseUrl/api/get/driver/' ;
  static const String updateUserProfileApi = '$baseUrl/api/driver/update' ;
  static const String updateImageApi = '$baseUrl/api/driver/update/image' ;
  static const String updatePasswordApi = '$baseUrl/api/change/password' ;
  static const String loadsApi = '$baseUrl/api/get/loads' ;
  static const String makeBidApi = '$baseUrl/api/make/bid' ;
  static const String getBidApi = '$baseUrl/api/get/bids' ;
  static const String cancelBidApi = '$baseUrl/api/cancel/bid' ;
  static const String assignBidApi = '$baseUrl/api/get/assigned' ;
  static const String startTripApi = '$baseUrl/api/start/trip';
  static const String tripStatusApi = '$baseUrl/api/trip/status';
  static const String currentTripApi = '$baseUrl/api/current/trip';
  static const String uploadDataApi = '$baseUrl/api/load/data';
  static const String uploadUnloadDataApi = '$baseUrl/api/unload/data';
}