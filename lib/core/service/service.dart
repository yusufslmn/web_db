import 'dart:convert';

class IService {
  static String baseUrl = 'https://ditsat.com/api/';
  static String basicAuth =
      'Basic ${base64Encode(utf8.encode('$email:$password'))}';
  static String email = "yusufslmn@outlook.com.tr";
  static String password = "yusuf2001";
  static bool validationUser = false;

  static Map<String, String> baseHeader = {
    'Content-Type': 'application/json',
  };
  static Map<String, String> basicHeader = {
    'Content-Type': 'application/json',
    'Authorization': IService.basicAuth,
  };

  static Uri url(String route) {
    switch (route) {
      case 'uptdatePassword':
        return Uri.parse('${IService.baseUrl}User/UpdatePassword');
      case 'register':
        return Uri.parse('${IService.baseUrl}User/Register');
      case 'login':
        return Uri.parse('${IService.baseUrl}User/CheckUser');
      case 'adminLogin':
        return Uri.parse('${IService.baseUrl}User/CheckAdmin');
      case 'addToBasket':
        return Uri.parse('${IService.baseUrl}Basket/AddOrUpdateBasketItem');
      case 'updateQuantity':
        return Uri.parse('${IService.baseUrl}Basket/UpdateBasketItemQuantity');
      case 'getBasket':
        return Uri.parse('${IService.baseUrl}Basket/GetBasket');
      case 'createOrder':
        return Uri.parse('${IService.baseUrl}Basket/CreateOrder');
      case 'getTransportMethods':
        return Uri.parse('${IService.baseUrl}Basket/GetTransportMethods');
      case 'getPaymentMethods':
        return Uri.parse('${IService.baseUrl}Basket/GetPaymentMethods');
      case 'emptyBasket':
        return Uri.parse('${IService.baseUrl}Basket/EmptyBasket');
      case 'getAllCoupons':
        return Uri.parse('${IService.baseUrl}Coupon/GetAllCoupons');
      case 'getUserCoupons':
        return Uri.parse('${IService.baseUrl}Coupon/GetUserCoupons');
      case 'getUserData':
        return Uri.parse('${IService.baseUrl}User/GetAccountData');
      case 'getCategories':
        return Uri.parse('${IService.baseUrl}Category/GetCategories');
      case 'sendMailHOTP':
        return Uri.parse('${IService.baseUrl}User/SendMailHOTP');
      case 'getOrder':
        return Uri.parse('${IService.baseUrl}Order/GetOrders');
      case 'verifyMailHOTP':
        return Uri.parse('${IService.baseUrl}User/VerifyMailHOTP');
      case 'updateUserData':
        return Uri.parse('${IService.baseUrl}User/UpdateAccountData');
      case 'getShowroomProducts':
        return Uri.parse('${IService.baseUrl}Product/GetShowroomProducts');
      case 'addOrUpdateCommentRating':
        return Uri.parse('${IService.baseUrl}Product/AddOrUpdateCommentRating');
      case 'addOrUpdateCommentResponse':
        return Uri.parse(
            '${IService.baseUrl}Product/AddOrUpdateCommentResponse');
      case 'addComment':
        return Uri.parse('${IService.baseUrl}Product/AddComment');
      default:
        return Uri.parse(IService.baseUrl);
    }
  }
}

enum ApiRouteName {
  uptdatePassword,
  register,
  getOrder,
  login,
  adminLogin,
  sendMailHOTP,
  getUserData,
  verifyMailHOTP,
  getShowroomProducts,
  getAllCoupons,
  getUserCoupons,
  addToBasket,
  getCategories,
  updateUserData,
  getBasket,
  getTransportMethods,
  getPaymentMethods,
  emptyBasket,
  createOrder,
  addOrUpdateCommentRating,
  addOrUpdateCommentResponse,
  addComment,
  updateQuantity,
}

String encodeBasic({required String email, required String password}) {
  return 'Basic ${base64Encode(utf8.encode('$email:$password'))}';
}
