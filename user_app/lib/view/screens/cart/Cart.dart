import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/cart/CartController.dart';
import 'package:user_app/data/utils/api_utils.dart';
import 'package:user_app/view/widgets/Cart/CartProductCard.dart';
import 'package:user_app/view/widgets/Cart/bottomsheet.dart';

class Order extends StatelessWidget {
  const Order({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ViewCartController>();

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
                  color: Theme.of(context).dividerColor.withOpacity(0.3),
                  blurRadius: 1,
                ),
              ],
            ),
          ),
        ),
      ),

      body: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.only(bottom: 140),
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            final p = controller.products[index];

            return Cartproductcard(
              image: getFullImageUrl(
                p.product?.image,
              ), // ✅ استخدم getFullImageUrl
              title: p.product?.name ?? "",
              price: (double.tryParse(p.product?.price ?? "0") ?? 0).toInt(),
              size: p.size?.name ?? "",
              color: p.color?.name ?? "",
              qty: p.pivot?.quantity ?? 0,
              onAdd: () => controller.increaseQty(index),
              onRemove: () => controller.decreaseQty(index),
              onDelete: () => controller.deleteItem(index),
            );
          },
        ),
      ),

      bottomNavigationBar: Obx(() {
        final screenHeight = MediaQuery.of(context).size.height;
        final maxSheetHeight = screenHeight * 0.85;

        return Container(
          constraints: BoxConstraints(maxHeight: maxSheetHeight),

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
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).secondaryHeaderColor,
                    borderRadius: BorderRadius.circular(16),
                  ),

                  child: Theme(
                    data: Theme.of(
                      context,
                    ).copyWith(dividerColor: Colors.transparent),

                    child: ExpansionTile(
                      key: ValueKey(controller.selectedRegion.value),

                      initiallyExpanded: false,

                      tilePadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 2,
                      ),

                      childrenPadding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 10,
                      ),

                      collapsedBackgroundColor: Theme.of(
                        context,
                      ).secondaryHeaderColor,

                      backgroundColor: Theme.of(context).secondaryHeaderColor,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),

                      collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),

                      title: Text(
                        controller.selectedRegion.value.isEmpty
                            ? "29".tr
                            : controller.selectedRegion.value,

                        style: TextStyle(
                          fontFamily: 'NunitoSans',
                          fontFamilyFallback: ['Tajawal'],
                          fontSize: 14,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),

                      trailing: Icon(
                        Icons.keyboard_arrow_down_rounded,

                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),

                      children: controller.deliveryZones.asMap().entries.map((
                        entry,
                      ) {
                        final sectorIndex = entry.key;
                        final zone = entry.value;
                        final regions = zone.regionsList;
                        final isExpanded =
                            controller.expandedSectorIndex.value == sectorIndex;

                        return ExpansionTile(
                          key: ValueKey('sector_${sectorIndex}_$isExpanded'),

                          initiallyExpanded: isExpanded,

                          onExpansionChanged: (expanded) {
                            controller.setExpandedSector(sectorIndex, expanded);
                          },

                          tilePadding: EdgeInsets.zero,
                          childrenPadding: const EdgeInsets.only(left: 16),

                          title: Text(
                            zone.sectorName,
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontFamilyFallback: ['Cairo'],
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          children: regions.map((region) {
                            return ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                region,
                                style: TextStyle(
                                  fontFamily: 'NunitoSans',
                                  fontFamilyFallback: ['Tajawal'],
                                ),
                              ),
                              onTap: () {
                                controller.selectRegion(zone, region);
                              },
                            );
                          }).toList(),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                if (controller.selectedRegion.value.isNotEmpty) ...[
                  const SizedBox(height: 8),

                  Divider(color: Theme.of(context).dividerColor),

                  const SizedBox(height: 12),

                  _row(
                    context,
                    "4".tr,
                    "${controller.subTotal} ${'currency'.tr}",
                    isBold: true,
                  ),

                  const SizedBox(height: 10),

                  _row(
                    context,
                    "3".tr,
                    "${controller.delivery} ${'currency'.tr}",
                  ),

                  Divider(height: 26, color: Theme.of(context).dividerColor),

                  _row(context, "2".tr, "${controller.total} ${'currency'.tr}"),
                  const SizedBox(height: 18),
                ],

                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,

                  child: ElevatedButton(
                    onPressed: controller.selectedRegion.value.isEmpty
                        ? null
                        : () {
                            showOrderBottomSheet(context, controller);
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
                      "21".tr,

                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontFamilyFallback: ['Cairo'],
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
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
          title,

          style: TextStyle(
            fontFamily: isBold ? 'Raleway' : 'NunitoSans',
            fontFamilyFallback: isBold ? ['Cairo'] : ['Tajawal'],
            fontSize: 15,

            fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,

            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),

        Text(
          value,

          style: TextStyle(
            fontFamily: isBold ? 'Raleway' : 'NunitoSans',
            fontFamilyFallback: isBold ? ['Cairo'] : ['Tajawal'],
            fontSize: 15,

            fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,

            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
      ],
    );
  }
}
