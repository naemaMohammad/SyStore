import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:owner_app/data/data_source/api_constants.dart';
import 'package:owner_app/data/model/forgot_password_request.dart';
import 'package:owner_app/data/model/merchant_auth_response.dart';
import 'package:owner_app/data/model/merchant_login_request.dart';
import 'package:owner_app/data/model/otp_request.dart';
import 'package:retrofit/retrofit.dart';

import 'dart:io';

part 'merchant_api.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class MerchantApi {
  factory MerchantApi(Dio dio, {String baseUrl}) = _MerchantApi;

  // ============================================================
  // 🔐 AUTH APIs
  // ============================================================

  @POST('/merchant/register')
  @MultiPart()
  Future<MerchantAuthResponse> register(
    @Part() String fullName,
    @Part() String phone,
    @Part() String email,
    @Part() String password,
    @Part() String socialMedia,
    @Part() String storeName,
    @Part() String storePhone,
    @Part() String location,
    @Part() String description,
    @Part() List<int> categoryIds,
    @Part() List<Map<String, dynamic>> deliveryZones,
    @Part() File? idImage,
    @Part() File? logoImage,
    @Part() File? coverImage,
    @Part() String fcmToken,
  );

  @POST('/merchant/verify-otp')
  Future<MerchantAuthResponse> verifyOtp(@Body() OtpRequest request);

  @POST('/merchant/login')
  Future<MerchantAuthResponse> login(@Body() MerchantLoginRequest request);

  @POST('/merchant/resend-otp')
  Future<MerchantAuthResponse> resendOtp(@Body() ResendOtpRequest request);

  @POST('/merchant/forgot-password')
  Future<MerchantAuthResponse> forgotPassword(
    @Body() ForgotPasswordRequest request,
  );

  @POST('/merchant/verify-reset-otp')
  Future<MerchantAuthResponse> verifyResetOtp(@Body() OtpRequest request);

  @POST('/merchant/reset-password')
  Future<MerchantAuthResponse> resetPassword(
    @Body() ResetPasswordRequest request,
  );

  @POST('/merchant/logout')
  Future<MerchantAuthResponse> logout();

  @POST('/merchant/update')
  @MultiPart()
  Future<MerchantAuthResponse> updateMerchant(
    @Part(name: 'full_name') String fullName,
    @Part() String phone,
    @Part(name: 'social_media') String socialMedia,
  );

  @DELETE('/merchant/delete')
  Future<MerchantAuthResponse> deleteAccount();

  // ============================================================
  // 🏪 STORE APIs
  // ============================================================
  @GET('/delivery-zones')
  Future<dynamic> getDeliveryZones();

  @GET('/merchant/store')
  Future<dynamic> getStore();
}
