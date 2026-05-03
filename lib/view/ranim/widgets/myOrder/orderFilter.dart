import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
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
    return   SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(filters.length, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: ChoiceChip(
            showCheckmark: false,
            label: Text(filters[index]),
              selected: controller.selectedFilter.value == filters[index],
              onSelected: (val) {
              controller.changeFilter(filters[index]);
                },
            selectedColor: const Color.fromARGB(255, 124, 122, 126),
              backgroundColor: Colors.grey.shade100,
            labelStyle: TextStyle(
            color: controller.selectedFilter.value == filters[index]
        ? Colors.white
        : Colors.black,
        ),
            ),
          );
        }),
      ),
    );
  }
}
