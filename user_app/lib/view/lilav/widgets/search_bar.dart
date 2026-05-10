import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';
import 'package:user_app/controller/lilav/search_controller.dart';
import 'package:user_app/view/lilav/Sreens/store_model.dart';
import 'package:user_app/view/lilav/Sreens/store_search_page.dart';
import 'package:user_app/view/lilav/widgets/store_card.dart';

class MySearchBar extends StatelessWidget {
   MySearchBar({super.key, });
  final StoreSearchController controller =
    Get.put(StoreSearchController());

  @override
  Widget build(BuildContext context) {
     bool isDark =
      Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
       Get.to(() => StoreSearchPage());
      },
      child: Container(
        width:double.infinity,
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
            border: Border.all(
          color: isDark
              ? Colors.white24
              : Colors.grey.shade400,
          width: 1,
        ),
        ),
        child:  Row(
          children: [
             Icon(
            Icons.search,
            size: 25,
            color: isDark
                ? Colors.white70
                : Colors.grey.shade700,
          ),
            SizedBox(width: 10),
          
          ],
        ),
      ),
    );
  }
}

class StoreSearchDelegate extends SearchDelegate {
  
  // تغيير لون وشكل البحث ليتناسب مع تصميمك
  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear, color: Colors.black54),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.black54),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) => _buildGridResults();

  @override
  Widget buildSuggestions(BuildContext context) => _buildGridResults();

  // الدالة التي تعرض الكروت بشكل شبكة (Grid)
  Widget _buildGridResults() {
    // تصفية القائمة بناءً على ما يكتبه المستخدم
    final results = StoreModel.allStores.where((store) {
      return store.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    if (results.isEmpty) {
      return const Center(child: Text("No stores found"));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(15),
      itemCount: results.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,         // عرض كرتين في الصف الواحد
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 0.8,     // تناسب الطول مع العرض للكارد
      ),
      itemBuilder: (context, index) {
        // استدعاء الكارد الخاص بكِ مباشرة
        return StoreCard(selectedStore: results[index]);
      },
    );
  }
}