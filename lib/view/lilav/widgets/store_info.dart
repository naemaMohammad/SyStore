import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:user_app/core/theme/color.dart';

class StoreInfo extends StatelessWidget {
  final String name;
  final String image;

  const StoreInfo({super.key, required this.name, required this.image});

  @override
  Widget build(BuildContext context) {

    final bool isDark =
    Theme.of(context).brightness == Brightness.dark;

    return Container(
      color: isDark
          ? AppColors.backgroundSecondaryDarkHome
          :  Colors.grey.shade200,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // store logo 
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
             color: isDark
                   ? AppColors.backgroundDarkHome
                     : AppColors.background,
              image: DecorationImage(
                image: AssetImage(image), 
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // store name
              Text(name, style:
              TextStyle(fontSize: 18, fontWeight: FontWeight.bold, 
              color: isDark
                      ? AppColors.textDarkHome
                      : Colors.black,
              
              )), 
              const SizedBox(height: 4,width: 4,),
               Text(
               'store_description'.tr, 
                style: TextStyle( fontWeight: FontWeight.w400,
                 color: isDark
                   ? AppColors.textSecondaryDarkHome
                     : Colors.black,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                '0988825012', // يمكن تحويل هذا أيضاً لباراميتر إذا كان الرقم مختلف لكل محل
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
              ),
            ],
          )
        ],
      ),
    );
  }
}