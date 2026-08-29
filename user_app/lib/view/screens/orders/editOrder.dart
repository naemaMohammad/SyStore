import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/order/EditOrderController.dart';
import 'package:user_app/data/utils/api_utils.dart';
import 'package:user_app/view/widgets/editorder/bottomSheet.dart';
import 'package:user_app/view/widgets/editorder/editProductCard.dart';

class Editorder extends StatelessWidget {
  const Editorder({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EditOrderController>();
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        toolbarHeight: 66,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '1'.tr,
          style: TextStyle(
            fontFamily: 'Raleway',
            fontFamilyFallback: ['Cairo'],
            fontWeight: FontWeight.w700,
            fontSize: 23,
            color: Theme.of(context).textTheme.bodyMedium?.color,
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
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 280),
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            final p = controller.products[index];

            return EditProductCard(
              image: getFullImageUrl(p.product?.image), // ✅ الصورة موجودة
              title: p.product?.name ?? "",
              price: (double.tryParse(p.product?.price ?? "0") ?? 0).toInt(),
              size: p.size?.name ?? "",
              color: p.color?.name ?? "",
            );
          },
        );
      }),
      bottomNavigationBar: Obx(
        () => Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// ✅ choose sector - لون معدل حسب الثيم
                Container(
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[800] : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Theme(
                    data: Theme.of(
                      context,
                    ).copyWith(dividerColor: Colors.transparent),
                    child: Obx(() {
                      return ExpansionTile(
                        maintainState: true,
                        tilePadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 2,
                        ),
                        childrenPadding: const EdgeInsets.only(
                          left: 0,
                          right: 0,
                          bottom: 10,
                        ),
                        collapsedBackgroundColor: isDark
                            ? Colors.grey[800]
                            : Colors.grey.shade100,
                        backgroundColor: isDark
                            ? Colors.grey[800]
                            : Colors.grey.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        collapsedShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        title: Text(
                          controller.selectedRegion.value.isEmpty
                              ? "29".tr
                              : "${controller.selectedSector.value} / ${controller.selectedRegion.value}",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'NunitoSans',
                            fontFamilyFallback: ['Tajawal'],
                            color: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.color,
                          ),
                        ),
                        trailing: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                        children: controller.deliveryZones.map((zone) {
                          final isExpanded =
                              controller.expandedZoneId.value == zone.id;

                          return Column(
                            key: ValueKey('zone_${zone.id}'),
                            children: [
                              ListTile(
                                dense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                title: Text(
                                  zone.sectorName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Raleway',
                                    fontFamilyFallback: ['Cairo'],
                                    color: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.color,
                                  ),
                                ),
                                trailing: Icon(
                                  isExpanded
                                      ? Icons.keyboard_arrow_up_rounded
                                      : Icons.keyboard_arrow_down_rounded,
                                  color: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.color,
                                ),
                                onTap: () {
                                  controller.toggleZoneExpansion(zone.id);
                                },
                              ),
                              if (isExpanded)
                                ...zone.regionsList.map((region) {
                                  final isSelected =
                                      controller.selectedRegion.value == region;
                                  return ListTile(
                                    dense: true,
                                    contentPadding: const EdgeInsets.only(
                                      left: 32,
                                      right: 32,
                                    ),
                                    title: Text(
                                      region,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'NunitoSans',
                                        fontFamilyFallback: ['Tajawal'],
                                        color: isSelected
                                            ? Theme.of(
                                                context,
                                              ).colorScheme.primary
                                            : Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.color
                                                  ?.withOpacity(0.8),
                                      ),
                                    ),
                                    onTap: () {
                                      controller.selectRegion(zone, region);
                                    },
                                  );
                                }).toList(),
                              const Divider(height: 1, thickness: 0.5),
                            ],
                          );
                        }).toList(),
                      );
                    }),
                  ),
                ),

                /// totals
                const SizedBox(height: 8),
                Divider(color: Theme.of(context).dividerColor),
                const SizedBox(height: 12),
                _row(
                  context,
                  "4".tr,
                  "${controller.subTotal} ${'currency'.tr}",
                ),
                const SizedBox(height: 10),
                _row(
                  context,
                  "3".tr,
                  "${controller.delivery} ${'currency'.tr}",
                ),
                Divider(height: 26, color: Theme.of(context).dividerColor),
                _row(
                  context,
                  "2".tr,
                  "${controller.total} ${'currency'.tr}",
                  isBold: true,
                ),
                const SizedBox(height: 18),

                /// button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.selectedRegion.value.isEmpty
                        ? null
                        : () {
                            editBottomSheet(context, controller);
                          },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      "7".tr,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Raleway',
                        fontFamilyFallback: ['Cairo'],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _row(
  BuildContext context,
  String title,
  String value, {
  bool isBold = false,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        "$title :",
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'NunitoSans',
          fontFamilyFallback: ['Tajawal'],
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
      ),
      Text(
        value,
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'NunitoSans',
          fontFamilyFallback: ['Tajawal'],
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
      ),
    ],
  );
}
