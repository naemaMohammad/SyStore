import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/lilav/search_controller.dart';
import 'package:user_app/core/theme/color.dart';
import 'package:user_app/core/theme/theme.dart';
import 'package:user_app/view/lilav/widgets/store_card.dart';

class StoreSearchPage extends StatelessWidget {

  final StoreSearchController controller =
      Get.put(StoreSearchController());

  StoreSearchPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
onPressed: () {
  Get.back();
},
        ),
        toolbarHeight: 66,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: TextField(
          onChanged: controller.search,
          decoration:  InputDecoration(
            hintText: "search".tr,
            hintStyle: TextStyle(fontSize: 16,fontFamily: AppFonts.body(),
            color:Theme.of(context).textTheme.bodyMedium?.color), 
            border: InputBorder.none,
          ),
        ),
        actions: [
          IconButton(
            onPressed: controller.clearSearch,
            icon:  Icon(Icons.clear ,color: Theme.of(context).textTheme.bodyMedium?.color,),
          )
        ],
         bottom: PreferredSize(
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

      body: Obx(() {

        if (controller.results.isEmpty) {
          bool isDark =
              Theme.of(context).brightness == Brightness.dark;
          return  Center(child: Text("no_results".tr,
          style: TextStyle(
              color: isDark
                ? AppColors.textDarkHome
                : Colors.grey[600], 
              fontSize: 16,fontFamily: AppFonts.heading(), 
              fontWeight: FontWeight.w500),));
        }

        return GridView.builder(
          padding: const EdgeInsets.all(15),
          itemCount: controller.results.length,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
          ),
          itemBuilder: (context, index) {

            return StoreCard(
              selectedStore:
                  controller.results[index],
            );
          },
        );
      }),
    );
  }
}