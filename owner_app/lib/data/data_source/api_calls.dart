import 'package:dio/dio.dart';
import 'package:owner_app/data/data_source/api_constants.dart';
import 'package:owner_app/data/model/ProductModel.dart';
import 'package:owner_app/data/model/StoreModel.dart';
import 'package:owner_app/data/model/product_response_model.dart';
import 'package:retrofit/retrofit.dart';

part 'api_calls.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiCalls {
  factory ApiCalls(Dio dio, {String? baseUrl}) = _ApiCalls;

  // تابع جلب وعرض بيانات المحل للتاجر
  @GET('/merchant/store')
  Future<StoreModel> getMerchantStore();


@POST('/store/update')
Future<StoreModel> updateStore({
  @Body() required dynamic storeData,
});

    // 🌟 دالة جلب تفاصيل المنتج (التي سنستخدمها قبل التعديل)
  @GET("/products/{id}")
  Future<ProductModel> getProductDetails(@Path("id") int id);

 @POST('/products/{id}')
  Future<ProductModel> updateProduct({
    @Path("id") required int productId,
    
    @Header('Accept') String accept = 'application/json', // 👈 إرسال هيدر Accept بجهة حقل مع قيمة افتراضية!
    @Body() required dynamic productData,
  });


  //    حذف المنتج

  @DELETE('/products/{id}')
  Future<HttpResponse> deleteProduct({
    
    @Path('id') required int id,
  });

// تعطيل المنتج

@PATCH('/products/{id}/toggle-status')
Future <ProductModel> toggleProductStatus({
  
  @Path('id') required int id,});

  //  فلترة وجلب المنتجات
  //  يطابق مواصفات الـ backend تماماً: لا category_id (يُتجاهل من السيرفر)،
  //  ولا store_id (محدّد تلقائياً للمتجر الخاص بالتاجر عبر الـ Sanctum token)،
  //  ومع `page` لدعم الترقيم (السيرفر يثبّت 12 عنصر/صفحة).
  @GET('/products/filter')
  Future<ProductResponseModel> filterProducts({
    
    @Query('sub_category_id') int? subCategoryId,
    @Query('size_id') int? sizeId,
    @Query('color_id') int? colorId,
    @Query('min_price') double? minPrice,
    @Query('max_price') double? maxPrice,
    @Query('category_id') int? page, int? categoryId,
  });


}