import 'dart:convert';

class IService {
  static String baseUrl = 'https://ditsat.com/api/';
  static String basicAuth =
      'Basic ${base64Encode(utf8.encode('$email:$password'))}';
  static String email = "yusufslmn@outlook.com.tr";
  static String password = "19191919";
  static Map<String, String> baseHeader = {
    'Content-Type': 'application/json',
  };
  static Map<String, String> basicHeader = {
    'Content-Type': 'application/json',
    'Authorization': IService.basicAuth,
  };

  static Uri url(String route) {
    switch (route) {
      case 'uptadePassword':
        return Uri.parse('${IService.baseUrl}User/UptadePassword');
      case 'register':
        return Uri.parse('${IService.baseUrl}User/Register');
      case 'login':
        return Uri.parse('${IService.baseUrl}User/CheckUser');
      case 'addToBasket':
        return Uri.parse('${IService.baseUrl}Basket/AddOrUpdateBasketItem');
      case 'getBasket':
        return Uri.parse('${IService.baseUrl}Basket/GetBasket');
      case 'emptyBasket':
        return Uri.parse('${IService.baseUrl}Basket/EmptyBasket');
      case 'getUserData':
        return Uri.parse('${IService.baseUrl}User/GetAccountData');
      case 'getShowroomProducts':
        return Uri.parse('${IService.baseUrl}Product/GetShowroomProducts');
      default:
        return Uri.parse(IService.baseUrl);
    }
  }
}

enum ApiRouteName {
  uptadePassword,
  register,
  login,
  getUserData,
  getShowroomProducts,
  addToBasket,
  getBasket,
  emptyBasket
}

String encodeBasic({required String email, required String password}) {
  return 'Basic ${base64Encode(utf8.encode('$email:$password'))}';
}
