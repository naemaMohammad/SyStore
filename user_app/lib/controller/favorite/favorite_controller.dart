import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:user_app/data/model/product_model.dart';
import '../../data/services/api_client.dart';
import '../../data/services/token_service.dart';

class FavoriteController extends GetxController {
  FavoriteController({ApiClient? apiClient, TokenService? tokenService})
      : _api = apiClient,
        _tokens = tokenService;

  final ApiClient? _api;
  ApiClient get api => _api ?? Get.find<ApiClient>();

  final TokenService? _tokens;
  TokenService get tokens => _tokens ?? Get.find<TokenService>();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  final RxList<ApiProductModel> favorites = <ApiProductModel>[].obs;

  final RxSet<int> favoriteIds = <int>{}.obs;

  bool isFavorite(int productId) => favoriteIds.contains(productId);

  Future<void> getFavorites() async {
    if (!await tokens.hasToken) {
      _fail('Please log in to view your favorites.');
      return;
    }
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final res = await api.getFavorites();
      final list = res.favorites ?? const <ApiProductModel>[];
      favorites.value = list;
      favoriteIds.assignAll(list.map((p) => p.id).whereType<int>());
    } on DioException catch (e) {
      _fail(e.message ?? 'Could not load favorites.');
    } catch (_) {
      _fail('Could not load favorites.');
    } finally {
      isLoading.value = false;
    }
  }

  
  Future<bool?> toggleFavorite(int productId, {ApiProductModel? product}) async {
    if (!await tokens.hasToken) {
      _fail('Please log in to manage favorites.');
      return null;
    }

    final wasFavorite = isFavorite(productId);
    _apply(productId, !wasFavorite, product);

    try {
      final res = await api.toggleFavorite({'product_id': productId});
      final nowFavorite = res.isFavorite ?? !wasFavorite;
      _apply(productId, nowFavorite, product);
      return nowFavorite;
    } on DioException catch (e) {
      _apply(productId, wasFavorite, product); 
      _fail(e.message ?? 'Could not update favorite.');
      return null;
    } catch (_) {
      _apply(productId, wasFavorite, product); 
      _fail('Could not update favorite.');
      return null;
    }
  }

  void _apply(int productId, bool favorite, ApiProductModel? product) {
    if (favorite) {
      favoriteIds.add(productId);
      if (product != null && product.id != null) {
        final id = product.id!;
        if (!favorites.any((p) => p.id == id)) {
          favorites.add(product);
        }
      }
    } else {
      favoriteIds.remove(productId);
      favorites.removeWhere((p) => p.id == productId);
    }
  }

  void _fail(String message) {
    errorMessage.value = message;
    Get.snackbar('Error', message, snackPosition: SnackPosition.BOTTOM);
  }
}
