import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/store/store_controller.dart';
import 'package:user_app/core/theme/color.dart';
import 'package:user_app/core/theme/theme.dart';
import 'package:user_app/data/model/store_model.dart';
import 'package:user_app/view/widgets/stores/store_card.dart';

class AllStoresScreen extends StatefulWidget {
  final String initialCategory;
  const AllStoresScreen({
    super.key,
    this.initialCategory =
        "all",
  });

  @override
  State<AllStoresScreen> createState() => _AllStoresScreenState();
}

class _AllStoresScreenState extends State<AllStoresScreen> {
  final StoreController controller = Get.find<StoreController>();

  final List<String> categories = ["all", "Women", "Men", "Girl", "Boy"];

  late RxString selectedCategory;

  @override
  void initState() {
    super.initState();
     print('=== AllStoresScreen initState ===');
    selectedCategory = widget.initialCategory.obs;
   // controller.getStores();
  }

  void changeCategory(String category) {
    selectedCategory.value = category;
  }

  List<StoreModel> get filteredStores {
    if (selectedCategory.value == "all") {
      return controller.stores;
    }

    
    return controller.stores
        .where((store) => store.hasCategory(selectedCategory.value))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
     print('=== AllStoresScreen build ===');
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF1E1E1E)
          : Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Theme.of(context).textTheme.bodyMedium?.color,
              size: 24,
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: StoreSearchDelegate(controller.stores),
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
        title: Text(
          'all_stores'.tr,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyMedium?.color,

            fontFamily: AppFonts.heading(),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6),
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).dividerColor.withOpacity(0.15),
                  blurRadius: 1,
                ),
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
                children: categories.map((category) {
                  bool isSelected = selectedCategory.value == category;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: () {
                        changeCategory(category);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? (isDark ? Colors.white24 : Colors.grey[300])
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(
                            color: isSelected
                                ? Colors.transparent
                                : (isDark ? Colors.white10 : Colors.grey[300]!),
                          ),
                        ),
                        child: Text(
                          category.tr,
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

          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              final currentStores = selectedCategory.value == "all"
                  ? controller.stores
                  : controller.stores
                        .where(
                          (store) => store.hasCategory(selectedCategory.value),
                        )
                        .toList();

              if (currentStores.isEmpty) {
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
                itemCount: currentStores.length,
                itemBuilder: (context, index) {
                  final store = currentStores[index];
                  return StoreCard(
                    selectedStore: store,
                
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

class StoreSearchDelegate extends SearchDelegate {
  final List<StoreModel> allStores;

  StoreSearchDelegate(this.allStores);

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
          (store) => (store.storeName ?? '').toLowerCase().contains(
            query.toLowerCase(),
          ),
        )
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final store = results[index];
        return ListTile(
          leading: store.logoUrl.isEmpty
              ? const Icon(Icons.store, size: 40)
              : Image.network(
                  store.logoUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.store, size: 40),
                ),
          title: Text(store.storeName ?? ''),
          subtitle: Text(store.location ?? ''),
          onTap: () {},
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = allStores
        .where(
          (store) => (store.storeName ?? '').toLowerCase().contains(
            query.toLowerCase(),
          ),
        )
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final store = suggestions[index];
        return ListTile(
          leading: store.logoUrl.isEmpty
              ? const Icon(Icons.store, size: 40)
              : Image.network(
                  store.logoUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.store, size: 40),
                ),
          title: Text(store.storeName ?? ''),
          subtitle: Text(store.location ?? ''),
          onTap: () {
            query = store.storeName ?? '';
            showResults(context);
          },
        );
      },
    );
  }
}
