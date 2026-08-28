class ApiConstants {
  ApiConstants._();

  // HOST & BASE URL
  static const String host = 'http://192.168.43.66:8000';
  static const String baseUrl = '$host/api';
  static const String imageBaseUrl = '$host/storage/';

  // TIMEOUTS
  static const Duration defaultTimeout = Duration(seconds: 30);
  static const Duration aiSearchTimeout = Duration(seconds: 180);

  // AUTH ENDPOINTS

  static const String register = '/user/register';
  static const String login = '/user/login';
  static const String verifyOtp = '/user/verify-otp';
  static const String resendOtp = '/user/resend-otp';
  static const String forgotPassword = '/user/forgot-password';
  static const String verifyResetOtp = '/user/verify-reset-otp';
  static const String resetPassword = '/user/reset-password';
  static const String logout = '/user/logout';
  static const String updateProfile = '/user/update';

  // STORE ENDPOINTS

  static const String stores = '/user/stores';
  static const String storeDetail = '/stores';
  static const String topRatedStores = '/stores/top-rated';

  // PRODUCT ENDPOINTS

  static const String productsFilter = '/products/filter';
  static const String productDetail = '/products';
  static const String topRatedProducts = '/products/top-rated';
  static const String sliders = '/sliders';

  // FAVORITES ENDPOINTS

  static const String favoritesToggle = '/favorites/toggle';
  static const String favorites = '/favorites';

  // CART ENDPOINTS

  static const String cartCheckStore = '/cart/check-store';
  static const String cartAdd = '/cart/add';
  static const String cartView = '/cart';
  static const String cartUpdate = '/cart/update';
  static const String cartRemove = '/cart/remove';
  static const String cartClear = '/cart/clear';
  static const String cartDeliveryZones = '/cart/delivery-zones';

  // ORDER ENDPOINTS

  static const String ordersCreate = '/orders/create';
  static const String orders = '/orders';
  static const String orderShow = '/order/show';
  static const String orderCancel = '/cancel-order';
  static const String orderUpdate = '/order';

  // REVIEWS ENDPOINTS

  static const String reviewsCanRate = '/reviews/can-rate';
  static const String reviewsRate = '/reviews/rate';

  // REPORT ENDPOINTS

  static const String reportProduct = '/report/product';
  static const String reportStore = '/report/store';

  // SEARCH ENDPOINTS

  static const String aiSearch = '/ai-search';
  static const String geminiTest = '/gemini-test';

  // OTHER

  static const String formLink = '/form-link';
}
