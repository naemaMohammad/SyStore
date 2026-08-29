import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/store/store_controller.dart';
import 'package:user_app/view/screens/search/store_search_page.dart';
import 'package:user_app/view/widgets/stores/store_card.dart';


class MySearchBar extends StatelessWidget {
   const MySearchBar({super.key, });

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

     final StoreController controller = Get.find<StoreController>();

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


  Widget _buildGridResults() {

    final results =controller.stores.where((store) {
      return (store.storeName ?? '').toLowerCase().contains(query.toLowerCase());
    }).toList();

    if (results.isEmpty) {
      return const Center(child: Text("No stores found"));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(15),
      itemCount: results.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {

        return StoreCard(selectedStore: results[index]);
      },
    );
  }
}