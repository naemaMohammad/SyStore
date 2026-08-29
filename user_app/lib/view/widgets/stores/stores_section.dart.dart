import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:user_app/controller/store/store_controller.dart';
import 'package:user_app/core/theme/color.dart';
import 'package:user_app/core/theme/theme.dart';
import 'package:user_app/view/screens/stores/all_stores_screen.dart';
import 'package:user_app/view/widgets/stores/store_card.dart';


class StoresSection extends StatefulWidget {
  const StoresSection({super.key});

  @override
  State<StoresSection> createState() => _StoresSectionState();
}

class _StoresSectionState extends State<StoresSection> {
  final StoreController controller = Get.find<StoreController>();

  @override
  void initState() {
    super.initState();
    if (controller.stores.isEmpty) {
      controller.getStores();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark =
        Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
          "stores".tr,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w800,
            fontFamily: AppFonts.heading(),
            color: isDark
    ? AppColors.textDarkHome
    : Colors.black
          ),
        ),
           TextButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>  const AllStoresScreen(),
      ),
    );
  },
  style: TextButton.styleFrom(
    padding: EdgeInsets.zero,
    minimumSize: Size.zero,
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  ),
  child:  Text(
    "see_all".tr,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFonts.heading(),
                  color: Color.fromARGB(255, 122, 45, 150),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 15),


        SizedBox(
          height: 180,
          child: Obx(() => ListView.separated(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            itemCount: controller.stores.length,
            itemBuilder: (context, index) {
              return StoreCard(selectedStore: controller.stores[index]);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(width: 15);
            },
          )),
        ),
      ],
    );
  }
}