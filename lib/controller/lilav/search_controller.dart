import 'package:get/get.dart';
import 'package:user_app/view/lilav/Sreens/store_model.dart';
import 'package:user_app/view/lilav/widgets/store_card.dart';

class StoreSearchController extends GetxController {

  // النص اللي المستخدم يكتبه
  RxString query = ''.obs;

  // النتائج
  RxList<StoreModel> results = <StoreModel>[].obs;

  // كل المتاجر
  final allStores = StoreModel.allStores;

  @override
  void onInit() {
    super.onInit();

    // بالبداية عرض الكل
    results.assignAll(allStores);
  }

  // تحديث البحث
  void search(String value) {

    query.value = value;

    if (value.isEmpty) {
      results.assignAll(allStores);
      return;
    }

    results.assignAll(
      allStores.where((store) {

        return store.name
            .toLowerCase()
            .contains(value.toLowerCase());

      }).toList(),
    );
  }

  // إعادة ضبط البحث
  void clearSearch() {
    query.value = '';
    results.assignAll(allStores);
  }
}