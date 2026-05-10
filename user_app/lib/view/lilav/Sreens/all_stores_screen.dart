import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:user_app/controller/lilav/all_stores_controller.dart';
import 'package:user_app/core/theme/color.dart';
import 'package:user_app/core/theme/theme.dart';
import 'package:user_app/view/lilav/Sreens/store_model.dart';
import '../widgets/store_card.dart';

class StoreData {
  final String name;
  final String category;
  final String image;
  final Color bgColor;

  StoreData({
    required this.name,
    required this.category,
    required this.image,
    required this.bgColor,
  });
}

class AllStoresScreen extends StatelessWidget {
   AllStoresScreen({super.key});

  final List<String> categories = [
    "all".tr,
    "Women".tr,
    "Men".tr,
    "Girl".tr,
    "Boy".tr,
  ];

  String selectedCategory = "all".tr;

  final AllStoresController controller = Get.put(AllStoresController());

  // القائمة الكاملة للمتاجر
  final List<StoreData> allStores = [
    StoreData(
      name: "MIA",
      category: "Women",
      image: 'assets/images/MIA.jpg',
      bgColor: Colors.white,
    ),
    StoreData(
      name: "AURA",
      category: "Women",
      image: 'assets/images/Aura.jpg',
      bgColor: const Color(0xFFF6EFE9),
    ),
    StoreData(
      name: "PHANIE",
      category: "Women",
      image: 'assets/images/phanie.jpg',
      bgColor: const Color(0xFFF6EFE9),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // المنطق الخاص بالفلترة:
    // إذا كان المختار "All" نعرض كل القائمة، وإلا نعرض ما يطابق التصنيف فقط
    List<StoreData> filteredStores = selectedCategory == "All"
        ? allStores
        : allStores
              .where((store) => store.category == selectedCategory)
              .toList();

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF1E1E1E)
          : Theme.of(context).scaffoldBackgroundColor,
      appBar:  AppBar(
         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          actions: [
          IconButton(
            icon: Icon(Icons.search, color: Theme.of(context).textTheme.bodyMedium?.color, size: 24),
            onPressed: () {
              showSearch(
                context: context,
                delegate: storeSearchDelegate(allStores),
              );
            },
          ),
        ],
          leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
          
onPressed: () {
  Get.back();
},
         
        
      ),
       title:  Text(
          'all_stores'.tr,
          style: TextStyle(
            color:
                Theme.of(context).textTheme.bodyMedium?.color,
                // استخدم لون النص من الثيم
             fontFamily: AppFonts.heading(),
            fontSize: 25,
            fontWeight: FontWeight.bold,
           
          ),
        ), bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6),
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(color: Colors.grey.shade300, blurRadius: 1),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Obx(
              () => Row(
                children: controller.categories.map((category) {
                  bool isSelected = controller.selectedCategory == category;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: () {
                        controller.changeCategory(category);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? (isDark
                                    ? Colors.white24
                                    : Colors
                                          .grey[300]) // شفافية بسيطة في الداكن
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(
                            color: isSelected
                                ? Colors.transparent
                                : (isDark ? Colors.white10 : Colors.grey[300]!),
                          ),
                        ),
                        child: Text(
                          category,
                          style: TextStyle(
                            color: isDark
                                ? AppColors.textDarkHome
                                : Colors.black,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                            fontFamily: AppFonts.heading(),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // --- قسم المتاجر المفلترة ---
          Expanded(
            child: Obx(() {
              final filteredStores = controller.filteredStores;

              if (filteredStores.isEmpty) {
                return Center(
                  child: Text(
                    "no_stores".tr,
                    style: TextStyle(
                      color: isDark ? Colors.white70 : Colors.black,
                      fontFamily: AppFonts.heading(),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }

              return GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.72,
                ),
                itemCount: filteredStores.length,
                itemBuilder: (context, index) {
                  final store = filteredStores[index];
                  return StoreCard(
                    selectedStore: StoreModel(
                      name: store.name,
                      category: store.category,
                      image: store.image,
                      coverImage: 'assets/images/store_cover.jpg',
                      bgColor: store.bgColor,
                      description: 'store_description'.tr,
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

class storeSearchDelegate extends SearchDelegate {
  final List<StoreData> allStores;

  storeSearchDelegate(this.allStores);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = allStores
        .where(
          (store) => store.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final store = results[index];
        return ListTile(
          leading: Image.asset(
            store.image,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          title: Text(store.name),
          subtitle: Text(store.category),
          onTap: () {
            // يمكنك إضافة وظيفة عند الضغط على النتيجة، مثل الانتقال إلى صفحة المتجر
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = allStores
        .where(
          (store) => store.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final store = suggestions[index];
        return ListTile(
          leading: Image.asset(
            store.image,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          title: Text(store.name),
          subtitle: Text(store.category),
          onTap: () {
            query = store.name;
            showResults(context);
          },
        );
      },
    );
  }
}
