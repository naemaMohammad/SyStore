import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:user_app/data/data_source/api_constants.dart';
import 'package:user_app/data/model/auth_response.dart';
import 'package:user_app/data/model/can_rate_model.dart';
import 'package:user_app/data/model/rating_model.dart';
import 'package:user_app/data/model/responses.dart';
import 'package:user_app/data/model/sliders_response_model.dart';
import 'package:user_app/data/utils/api_utils.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: ApiConfig.apiBaseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  // AUTH ENDPOINTS (public + Bearer)

  @POST(ApiConstants.register)
  @MultiPart()
  Future<AuthResponse> register(
    @Part() String full_name,
    @Part() String phone,
    @Part() String email,
    @Part() String password,
    @Part() String fcm_token,
  );

  @POST(ApiConstants.login)
  Future<AuthResponse> login(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.verifyOtp)
  Future<AuthResponse> verifyOtp(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.resendOtp)
  Future<AuthResponse> resendOtp(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.forgotPassword)
  Future<AuthResponse> forgotPassword(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.verifyResetOtp)
  Future<AuthResponse> verifyResetOtp(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.resetPassword)
  Future<AuthResponse> resetPassword(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.logout)
  Future<AuthResponse> logout();

  @POST(ApiConstants.updateProfile)
  @MultiPart()
  Future<AuthResponse> updateProfile(
    @Part() String full_name,
    @Part() String phone,
  );

  // STORE ENDPOINTS (public (no Bearer required))

  @GET(ApiConstants.stores)
  Future<StoresListResponse> getStores();

  @GET('${ApiConstants.storeDetail}/{id}')
  Future<SingleStoreResponse> getStore(@Path('id') int id);

  @GET(ApiConstants.topRatedStores)
  Future<TopStoresResponse> topRatedStores();

  // PRODUCT ENDPOINTS (public + Bearer for filter)

  @GET(ApiConstants.productsFilter)
  Future<FilterResponse> filterProducts(@Queries() Map<String, dynamic> params);

  @GET('${ApiConstants.productDetail}/{id}')
  Future<SingleProductResponse> getProduct(@Path('id') int id);

  @GET(ApiConstants.topRatedProducts)
  Future<TopProductsResponse> topRatedProducts();

  // FAVORITES ENDPOINTS (Bearer)

  @POST(ApiConstants.favoritesToggle)
  Future<FavoriteToggleResponse> toggleFavorite(
    @Body() Map<String, dynamic> body,
  );

  @GET(ApiConstants.favorites)
  Future<FavoritesResponse> getFavorites();

  // REPORT ENDPOINTS (Bearer)

  @POST(ApiConstants.reportProduct)
  Future<ReportResponse> reportProduct(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.reportStore)
  Future<ReportResponse> reportStore(@Body() Map<String, dynamic> body);

  // Slider endpoints

  @GET(ApiConstants.sliders)
  Future<SlidersResponseModel> getSliders();

  // CART ENDPOINTS (Bearer)

  @POST(ApiConstants.cartCheckStore)
  Future<CheckStoreResponse> checkStore(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.cartAdd)
  Future<CartAddResponse> addToCart(@Body() Map<String, dynamic> body);

  @DELETE(ApiConstants.cartClear)
  Future<ClearCartResponse> clearCart();

  @GET(ApiConstants.cartView)
  Future<dynamic> viewCart();

  @PUT(ApiConstants.cartUpdate)
  Future<dynamic> updateCart(@Body() Map<String, dynamic> body);

  @DELETE(ApiConstants.cartRemove)
  Future<dynamic> removeCart(@Body() Map<String, dynamic> body);

  @GET(ApiConstants.cartDeliveryZones)
  Future<dynamic> cartDeliveryZones({@Query('order_id') int? orderId});

  // ORDER ENDPOINTS (Bearer)

  @POST(ApiConstants.ordersCreate)
  Future<dynamic> createOrder(@Body() Map<String, dynamic> body);

  @GET(ApiConstants.orders)
  Future<dynamic> viewOrders();

  @GET('${ApiConstants.orderShow}/{id}')
  Future<dynamic> showOrder(@Path('id') int id);

  @POST('${ApiConstants.orderCancel}/{id}')
  Future<dynamic> cancelOrder(@Path('id') int id);

  @PUT('${ApiConstants.orderUpdate}/{id}')
  Future<dynamic> updateOrder(
    @Path('id') int id,
    @Body() Map<String, dynamic> body,
  );

  // REVIEWS ENDPOINTS (Bearer)

  @GET(ApiConstants.reviewsCanRate)
  Future<can_rate_model> canRate(@Queries() Map<String, dynamic> queries);

  @POST(ApiConstants.reviewsRate)
  Future<rating_model> rate(@Body() Map<String, dynamic> body);

  // SEARCH ENDPOINTS (public)

  @POST(ApiConstants.aiSearch)
  Future<AiSearchResponse> aiSearch(
    @Body() Map<String, dynamic> body, {
    @Extras() Map<String, dynamic>? extras,
  });

  @GET(ApiConstants.geminiTest)
  Future<dynamic> geminiTest();

  // OTHER

  @GET(ApiConstants.formLink)
  Future<dynamic> getFormLink();
}
