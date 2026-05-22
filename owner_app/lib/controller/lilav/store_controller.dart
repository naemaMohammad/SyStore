import 'package:get/get.dart';
import 'package:owner_app/data/model/myStore_maodel.dart';

class StoreController extends GetxController {
RxBool isEditing = false.obs;
RxList<String> selectedCategories =
    <String>[].obs;

@override
void onInit() {

  super.onInit();

  selectedCategories.value =
      store.value.categories;
}

  Rx<StoreModel> store =
      StoreModel(

        id: '1',

        name: 'MIA Boutique',

        description:
            'Fashion Store',

        phone: '0988825012',

        logo:
            'assets/images/MIA.jpg',

        coverImage:
            'assets/images/store_cover.jpg',

        categories: [
          'women',
          'men',
        ],
      ).obs;

  void updateStore(
    StoreModel updatedStore,
  ) {

    store.value = updatedStore;

    store.refresh();
  }

void updateStoreInfo({
  required String name,
  required String description,
  required String phone,
}) {

  store.update((value) {

    value!.name = name;

    value.description = description;

    value.phone = phone;

    value.categories =
        selectedCategories.toList();
  });
}
}