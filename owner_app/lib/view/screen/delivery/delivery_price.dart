// lib/view/lana/delivery/delivery_price.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owner_app/controller/auth/delivery_price_controller.dart' show DeliveryPriceController;
import 'package:owner_app/view/widgets/buttons/button.dart';


class DeliveryPricesScreen extends StatelessWidget {
  final bool isFromSettings;
  const DeliveryPricesScreen({super.key, this.isFromSettings = false});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<DeliveryPriceController>()) {
      Get.put(DeliveryPriceController());
    }
    final controller = Get.find<DeliveryPriceController>();

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),

                    // ✅ العنوان
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        "delivery_prices_desc".tr,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Raleway',
                          fontFamilyFallback: const ['Cairo'],
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                    ),

                    // ✅ القائمة + مؤشر التحميل في المنتصف
                    Expanded(
                      child: Obx(() {
                        // ✅ حالة التحميل الأولى (جلب البيانات من الباك)
                        if (controller.isLoading.value &&
                            controller.areas.isEmpty) {
                          return Center(
                            child: Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 4,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'loading'.tr,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium?.color,
                                      fontFamily: 'NunitoSans',
                                      fontFamilyFallback: ['Tajawal'],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        // ✅ إذا كانت المناطق فاضية (والـ loading خلص)
                        if (controller.areas.isEmpty) {
                          return Center(
                            child: Text(
                              'no_delivery_zones'.tr,
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.color,
                              ),
                            ),
                          );
                        }

                        // ✅ الوضع الطبيعي: عرض القائمة
                        return ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemCount: controller.areas.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            final item = controller.areas[index];
                            return Container(
                              height: 100,
                              decoration: BoxDecoration(
                                color: Theme.of(context).secondaryHeaderColor,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.1),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 12,
                                      ),
                                      child: Text(
                                        item['title'] ?? 'Area ${item['id']}',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'NunitoSans',
                                          fontFamilyFallback: const ['Tajawal'],
                                          color: Theme.of(
                                            context,
                                          ).textTheme.bodyLarge?.color,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 75,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                          color: Colors.grey.withOpacity(0.25),
                                        ),
                                      ),
                                    ),
                                    child: Switch(
                                      value: item["enabled"],
                                      activeThumbColor: Colors.white,
                                      activeTrackColor: Theme.of(
                                        context,
                                      ).colorScheme.secondary,
                                      inactiveThumbColor: Colors.white,
                                      inactiveTrackColor: Theme.of(
                                        context,
                                      ).colorScheme.tertiary,
                                      onChanged: (value) {
                                        controller.toggleArea(index, value);
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                          color: Colors.grey.withOpacity(0.25),
                                        ),
                                      ),
                                    ),
                                    child: Center(
                                      child: TextField(
                                        controller:
                                            controller.priceControllers[index],
                                        textDirection: TextDirection.ltr,
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          controller.updatePrice(index, value);
                                        },
                                        decoration: InputDecoration(
                                          hintText: "SYP".tr,
                                          border: InputBorder.none,
                                          hintStyle: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey.withOpacity(0.5),
                                          ),
                                        ),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(
                                            context,
                                          ).textTheme.bodyLarge?.color,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }),
                    ),

                    const SizedBox(height: 10),

                    // ✅ الزر مع Loading عند الضغط
                    Obx(() {
                      // ✅ إذا كان في تحميل (عند الضغط على الزر)
                      if (controller.isLoading.value &&
                          controller.areas.isNotEmpty) {
                        return Container(
                          width: double.infinity,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).primaryColor.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'loading'.tr,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'NunitoSans',
                                    fontFamilyFallback: ['Tajawal'],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      // ✅ الزر الطبيعي
                      return CustomButton(
                        text: isFromSettings ? "update".tr : "confirm".tr,
                        onPressed: () {
                          if (isFromSettings) {
                            controller.updatePrices();
                          } else {
                            controller.confirmPrices();
                          }
                        },
                      );
                    }),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
