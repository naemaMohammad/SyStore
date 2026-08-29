import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../data/model/product_model.dart';
import '../../data/model/store_model.dart';
import '../../data/services/api_client.dart';


class StoreController extends GetxController {
  StoreController({ApiClient? apiClient}) : _api = apiClient;

  final ApiClient? _api;
  ApiClient get api => _api ?? Get.find<ApiClient>();
  

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  final RxList<StoreModel> stores = <StoreModel>[].obs;

  final Rx<StoreModel?> store = Rx<StoreModel?>(null);
  final RxDouble storeRating = 0.0.obs;

  final RxList<StoreModel> topStores = <StoreModel>[].obs;

Future<void> getStores() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final res = await api.getStores();
      stores.value = res.stores ?? [];
    } on DioException catch (e) {
      developer.log('getStores DioException', error: e, stackTrace: e.stackTrace);
      _fail(e.message ?? 'Could not load stores.');
    } catch (e, s) {
      developer.log('getStores failed', error: e, stackTrace: s);
      _fail('Could not load stores: $e');
    } finally {
      isLoading.value = false;
    }
  }

Future<void> getStore(int id) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final res = await api.getStore(id);
      store.value = res.store;
      storeRating.value = res.storeRating ?? 0;
    } on DioException catch (e) {
      _fail(e.message ?? 'Could not load this store.');
    } catch (_) {
      _fail('Could not load this store.');
    } finally {
      isLoading.value = false;
    }
  }

   Future<void> getTopStores() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final res = await api.topRatedStores();
      topStores.value = res.stores ?? [];
    } on DioException catch (e) {
      _fail(e.message ?? 'Could not load top stores.');
    } catch (_) {
      _fail('Could not load top stores.');
    } finally {
      isLoading.value = false;
    }
  }
  List<ApiProductModel> get storeProducts => store.value?.products ?? [];

  void _fail(String message) {
    errorMessage.value = message;
    Get.snackbar('Error', message, snackPosition: SnackPosition.BOTTOM);
  }
}
