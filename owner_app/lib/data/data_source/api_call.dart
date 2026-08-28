import 'package:dio/dio.dart';
import 'package:owner_app/data/data_source/api_constants.dart';
import 'package:owner_app/data/model/accept_orders_model.dart';
import 'package:owner_app/data/model/all_stores_reviews_model.dart' show all_stores_reviews_model;
import 'package:owner_app/data/model/dash_chart_model.dart';
import 'package:owner_app/data/model/dash_model.dart';
import 'package:owner_app/data/model/order_rejact_model.dart';
import 'package:owner_app/data/model/order_status_model.dart';
import 'package:owner_app/data/model/show_order_model.dart';
import 'package:owner_app/data/model/view_orders_model.dart';
import 'package:retrofit/retrofit.dart';

part 'api_call.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiCall {
  factory ApiCall(Dio dio, {String? baseUrl}) = _ApiCall;

  @GET('/merchant/orders')
Future<view_orders_model> viewOrder();

  @GET('/merchant/order/{id}')
  Future<show_order_model> showOrder(@Path('id') int id);

  @POST('/merchant/orders/{id}/accept')
  Future<accept_orders_model> acceptOrder(@Path('id') int id);

  @POST('/merchant/orders/{id}/reject')
  Future<order_rejact_model> rejectOrder(
    @Path('id') int id,
    @Body() Map<String, dynamic> body,
  );

  @POST('/orders/{id}/status')
  Future<order_status_model> statusOrder(
    @Path('id') int id,
    @Body() Map<String, dynamic> body,
  );
  @GET('/dashboard')
  Future<dash_model> dashboard();

  @GET('/dashboard/chart')
  Future<dash_chart_model> dashboardChart();

  @GET('/store/reviews')
  Future<all_stores_reviews_model> allStoreReviews();
}

