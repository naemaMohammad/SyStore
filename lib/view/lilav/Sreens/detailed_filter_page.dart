import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:user_app/controller/lilav/filter_controller.dart';
import 'package:user_app/core/theme/color.dart';
import 'package:user_app/core/theme/theme.dart';
import 'package:user_app/view/lilav/widgets/product_card.dart';

class DetailedFilterPage extends StatelessWidget {
  final String initialCategory;
  final double initialPrice;
  final FilterController controller =
    Get.put(FilterController());
   static List<Color> availableColors = [
    const Color(0xFFF0F0F0), const Color(0xFFFFFFFF), const Color(0xFF000000),
    const Color(0xFF8B1A1A), const Color(0xFFFF3131), const Color(0xFFFFABAB),
    const Color(0xFF5D4037), const Color(0xFFFFF59D), const Color(0xFFE67E22),
    const Color(0xFFD7CCC8), const Color(0xFF81D4FA), const Color(0xFF1A237E),
    const Color(0xFFA5D6A7), const Color(0xFF00897B), const Color(0xFFE1BEE7),
    const Color(0xFF8E24AA), const Color(0xFFD81B60),
  ];

  DetailedFilterPage({
  super.key,
  required this.initialCategory,
  required this.initialPrice,
}) {
  controller.initialize(
    category: initialCategory,
    price: initialPrice,
  );
}

  @override
  Widget build(BuildContext context) {
    
    final bool isDark =
    Theme.of(context).brightness == Brightness.dark;
   
    return Scaffold(

   backgroundColor: isDark
          ? Theme.of(context).scaffoldBackgroundColor
          : Theme.of(context).scaffoldBackgroundColor,
      appBar:   
      AppBar(
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
       title:  Text(
          'Filter'.tr,
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('category'.tr),
            const SizedBox(height: 12),
          Obx(() =>  Wrap(
              spacing: 10, runSpacing: 10,
              children: ['tshirt'.tr, 'jacket'.tr, 'hoodie'.tr, 'dress'.tr, 'skirt'.tr, 'sweater'.tr, 'set'.tr, 'abaya'.tr]
                  .map((cat) => _buildChoiceChip(cat, controller.selectedCategory.value == cat)).toList(),
            )),
            const SizedBox(height: 25),
            _buildSectionTitle('size'.tr),
            const SizedBox(height: 12),
           Obx(() =>  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ['S', 'M', 'L', 'XL', 'XXL', 'Free'].map((size) =>
               _buildSizeBox(size,controller.selectedSize.value == size)).toList(),
            ),),
            
            const SizedBox(height: 25),
            _buildSectionTitle('price'.tr),
            const SizedBox(height: 12),
            Obx(() =>  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('10 \$', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('${controller.currentPrice.value.round()} \$', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),),
             Obx(() =>
            Slider(
              value: controller.currentPrice.value, min: 10, max: 1000,
              activeColor: const Color(0xFF4A2B66),
              inactiveColor: Colors.grey.shade200,
              onChanged: (val) => controller.currentPrice.value = val),
            ),
            const SizedBox(height: 25),
            _buildSectionTitle('color'.tr),
            const SizedBox(height: 12),
            _buildColorPalette(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomButtons(),
    );
  }

  Widget _buildSectionTitle(String title) {
    BuildContext context = Get.context!;
    final bool isDark =
      Theme.of(context).brightness == Brightness.dark;
    return
  Text(title, style:
    TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
    fontFamily: AppFonts.heading(),
    color: isDark
          ? AppColors.textDarkHome
          : Colors.black,
    ));
  }
  Widget _buildChoiceChip(String label, bool isSelected) {
    BuildContext context = Get.context!;
    bool isDark =
      Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => controller.changeCategory(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
color: isSelected
    ? const Color(0xFF4A2B66).withOpacity(0.1)
    : isDark
        ? AppColors.backgroundSecondaryDarkHome
        : Colors.white,      
          borderRadius: BorderRadius.circular(10),

          border: Border.all(color: isSelected ?
           const Color(0xFF532564)
             : (isDark ? Colors.grey[700]! : Colors.grey.shade300)),
        ),
        child: Text(label, style: TextStyle(
          fontFamily: AppFonts.heading(),
          color: isSelected
    ? const Color(0xFF4A2B66)
    : isDark
        ? AppColors.textDarkHome
        : Colors.black54)),

      ),
    );
  }

  Widget _buildSizeBox(String size, bool isSelected) {
    BuildContext context = Get.context!;
    bool isDark =
      Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => controller.changeSize(size),
      child: Container(
        width: 48, height: 42, alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected 
        ? (isDark ? const Color(0xFF532564).withOpacity(0.3) : const Color(0xFFF3E5F5))
          : (isDark ? Colors.grey[850] : Colors.white),          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isSelected ?
                const Color(0xFF532564)
              : (isDark ? Colors.grey[700]! : Colors.grey.shade300)),
        ),
        child: Text(size, style:  TextStyle(
          fontFamily: AppFonts.heading(),
          
        
        color: isSelected
                ? (isDark ? Colors.white : const Color(0xFF532564))
                : (isDark ? Colors.white70 : Colors.black),
      ),
    )));
  }

  Widget _buildColorPalette() {
    return Obx(() => Wrap(
      spacing: 12, runSpacing: 15,
      children: DetailedFilterPage.availableColors.map((color) {
        bool isChosen = controller.selectedColor.value == color;
        return GestureDetector(
          onTap: () => controller.changeColor(color),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 40, height: 40,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),
              ),
              if (isChosen)
                Container(
                  width: 20, height: 20,
                  decoration: const BoxDecoration(color: Color(0xFF4A2B66), shape: BoxShape.circle),
                  child: const Icon(Icons.check, size: 14, color: Colors.white),
                ),
            ],
          ),
        );
      }).toList(),)
    );
  }

  Widget _buildBottomButtons() {
     BuildContext context = Get.context!;
     bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => 
                controller.clearFilters(),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                 backgroundColor:
                  isDark ? const Color(0xFF1E1E1E) : Colors.white,

                
                 side: BorderSide(
                color: isDark
                    ? Colors.grey.shade700
                    : Colors.grey.shade300,
              ),),
              child:  Text('clear'.tr, style: TextStyle(
                fontFamily: AppFonts.heading(),
                 color: isDark
                    ? AppColors.textDarkHome
                    : Colors.black,
                )),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // تنفيذ منطق الفلترة على القائمة الثابتة الموجودة في ProductCard
                var filtered = ProductCard.allProducts.where((product) {
                  
                  // 1. فحص القسم (إذا كان 'All' يظهر الجميع، غير ذلك يقارن النصوص)
                  bool matchesCategory = controller.selectedCategory.value == 'all'.tr || 
                      product.category.toLowerCase().trim() == controller.selectedCategory.value.toLowerCase().trim();
                  
                  // 2. فحص المقاس
                  bool matchesSize = product.size == controller.selectedSize.value;
                  
                  // 3. فحص السعر (بناءً على قيمة الـ Slider عندك من 10 إلى _currentPrice)
                  bool matchesPrice = product.priceValue <=controller.currentPrice.value;

                  // ملاحظة: يمكنك إضافة فحص اللون هنا إذا أردتِ مستقبلاً
                  
                  return matchesCategory && matchesSize && matchesPrice;
                }).toList();

                // إغلاق الصفحة وإرسال النتائج
                Navigator.pop(context, filtered); 
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4A2B66), padding: const EdgeInsets.symmetric(vertical: 16)),
              child:  Text('apply'.tr, style: TextStyle(
                fontFamily: AppFonts.heading(),
                color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}