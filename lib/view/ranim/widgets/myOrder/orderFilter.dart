import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/ranim/myOrderController.dart';

class OrderFilters extends StatefulWidget {
  const OrderFilters({super.key});

  @override
  State<OrderFilters> createState() => _OrderFiltersState();
}

class _OrderFiltersState extends State<OrderFilters> {
  final controller = Get.find<OrdersController>();

  final List<String> filters = [
    "All",
    "Process",
    "Preparing",
    "On the way",
    "Delivered",
    "Cancelled",
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(filters.length, (index) {
              final isSelected =
                  controller.selectedFilter.value == filters[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: ChoiceChip(
                  showCheckmark: false,
                  label: Text(filters[index]),

                  selected: isSelected,

                  onSelected: (val) {
                    controller.changeFilter(filters[index]);
                  },

                  // 🎯 selected chip color
                  selectedColor:
                      Theme.of(context).colorScheme.primary.withOpacity(0.2),

                  // 🎯 unselected chip color
                  backgroundColor: Theme.of(context).cardColor,

                  // 🎯 border (مهم للدراك مود)
                  shape: StadiumBorder(
                    side: BorderSide(
                      color: Theme.of(context).dividerColor,
                    ),
                  ),

                  // 🎯 label style (dark/light safe)
                  labelStyle: TextStyle(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.color,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              );
            }),
          ),
        ));
  }
}