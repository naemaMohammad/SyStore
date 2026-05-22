import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:owner_app/controller/lilav/product_controller.dart';
import 'package:owner_app/data/model/myProduct.dart';
import 'package:owner_app/data/model/product_variant_model.dart';
import 'package:owner_app/view/lilav/screens/store_page.dart';

class AddProductController extends GetxController {

  final nameController = TextEditingController();

  final descriptionController = TextEditingController();

  final materialController = TextEditingController();

  final priceController = TextEditingController();

  RxString selectedCategory = ''.obs;

  RxString imagePath = ''.obs;

  Rx<ProductVariant?> currentVariant =
    Rx<ProductVariant?>(null);

  RxList<Color> selectedColors = <Color>[].obs;

  RxList<String> selectedSizes = <String>[].obs;

  RxBool isCreatingVariant = false.obs;


 final List<String> categories = [
  'women'.tr,
  'men'.tr,
  'girl'.tr,
  'boy'.tr,
];

  final List<String> sizes = [
    "S",
    "M",
    "L",
    "XL",
    "Free"
  ];

  static List<Color> availableColors = [
    const Color(0xFFF0F0F0),
    const Color(0xFFFFFFFF),
    const Color(0xFF000000),
    const Color(0xFF8B1A1A),
    const Color(0xFFFF3131),
    const Color(0xFFFFABAB),
    const Color(0xFF5D4037),
    const Color(0xFFFFF59D),
    const Color(0xFFE67E22),
    const Color(0xFFD7CCC8),
    const Color(0xFF81D4FA),
    const Color(0xFF1A237E),
    const Color(0xFFA5D6A7),
    const Color(0xFF00897B),
    const Color(0xFFE1BEE7),
    const Color(0xFF8E24AA),
    const Color(0xFFD81B60),
  ];

Rx<Color> currentColor = Colors.blue.obs;

final List<String> adultSizes = [
  'S',
  'M',
  'L',
  'XL',
  'XXL',
  "free"
];

final List<String> kidsSizes = [
  '2Y',
  '4Y',
  '6Y',
  '8Y',
  '10Y',
  'free'
];
    
RxList<ProductVariant> variants =
    <ProductVariant>[].obs;    

Rx<Color> selectedVariantColor =
    Colors.blue.obs;

RxList<String> variantImages =
    <String>[].obs;

RxMap<String, TextEditingController>
    inventoryControllers =
        <String, TextEditingController>{}.obs;


@override
void onInit() {

  super.onInit();

  inventoryControllers['S'] =
      TextEditingController();

  inventoryControllers['M'] =
      TextEditingController();

  inventoryControllers['L'] =
      TextEditingController();

  inventoryControllers['XL'] =
      TextEditingController();
}

final List<String> productTypes = [

  'tshirt'.tr,
  'jacket'.tr,
  'hoodie'.tr,
  'dress'.tr,
  'skirt'.tr,
  'sweater'.tr,
  'set'.tr,
  'abaya'.tr,

];

RxString selectedProductType = ''.obs;
RxBool isLoading = false.obs;


Future<void> addNewProduct() async {

  final productController =
      Get.find<ProductController>();

      if (variants.isEmpty) {
    Get.snackbar(
      "Error",
      "Please add at least one color",
    );
    return;
  }

  
  if (variants.first.images.isEmpty) {
    Get.snackbar(
      "Error",
      "Please add product image",
    );
    return;
  }

  final newProduct = ProductModel(

    id:  DateTime.now().millisecondsSinceEpoch.toString(),

    title: nameController.text.trim(),

    description:
        descriptionController.text.trim(),

    price:
        double.tryParse(
          priceController.text,
        ) ?? 0,

    imagePath:
        variants.first.images.first,

    category:
        selectedCategory.value,

    sizes:
        selectedSizes.toList(),

    productType: selectedProductType.value,

     storeId: 'store_1',
     isActive:  true, 
     
     variants: variants.toList(),

      material:materialController.text.trim(),
    
  );

    productController.addProduct(newProduct);
 
  isLoading.value = true;

  await Future.delayed(
    const Duration(seconds: 2),
  );

  isLoading.value = false;

  clearData();

  Get.offAll(() => StorePage());
}


void clearData() {

  nameController.clear();

  descriptionController.clear();

  materialController.clear();

  priceController.clear();

  selectedCategory.value = '';

  selectedProductType.value = '';

  selectedSizes.clear();

  variants.clear();

  imagePath.value = '';
}



  void toggleSize(String size) {
    if (selectedSizes.contains(size)) {
      selectedSizes.remove(size);
    } else {
      selectedSizes.add(size);
    }
  }

  void toggleColor(Color color) {
    if (selectedColors.contains(color)) {
      selectedColors.remove(color);
    } else {
      selectedColors.add(color);
    }
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  void selectImage(String path) {
    imagePath.value = path;
  }
List<String> get currentSizes {

  if (
      selectedCategory.value == 'girl' ||
      selectedCategory.value == 'boy'
  ) {

    return kidsSizes;
  }

  return adultSizes;
}
void addVariant() {

  final variant = ProductVariant(
    color: null,
    images: [],
    stock: {},
  );

  variants.add(variant);
  variants.refresh();

  currentVariant.value = variant;
}


void removeVariant(int index) {
  variants.removeAt(index);
}

void selectVariantColor(Color color) {
  currentVariant.value!.color = color;

  currentVariant.refresh();
}


Future<void> addVariantImage() async {
 if (currentVariant.value == null){
  Get.snackbar("Error", "please create or select a color first",
  snackPosition :SnackPosition.TOP,
  ); return;
 }
 final ImagePicker picker = ImagePicker();
 final XFile? image = await picker.pickImage(source: ImageSource.gallery);
 if(image != null ){
  currentVariant.value!.images.add(image.path);
  currentVariant.refresh();
  variants.refresh();
 }
}

void removeVariantImage(int imageIndex) {
  currentVariant.value!.images.removeAt(imageIndex);

  currentVariant.refresh();
}


void updateStock(
  String size,
  String value,
) {
  currentVariant.value!.stock[size] =
      int.tryParse(value) ?? 0;

  currentVariant.refresh();
}

void saveCurrentVariant() {

  if (currentVariant.value == null) return;

  variants.add(
    ProductVariant(
      color: currentVariant.value!.color,
      images: List.from(currentVariant.value!.images),
      stock: Map.from(currentVariant.value!.stock),
    ),
  );

  currentVariant.value = null;
  variants.refresh();
}
@override
void onClose() {
  nameController.dispose();
  descriptionController.dispose();
  materialController.dispose();
  priceController.dispose();
  inventoryControllers.forEach((key, controller) => controller.dispose());
  super.onClose();
}
}




